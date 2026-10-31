import 'dart:async';
import 'dart:math';
import 'package:cat_domain/cat_domain.dart';

/// Agent 聊天 Mock 服务
///
/// 模拟 AI Agent 的流式响应输出。
/// 根据用户输入的关键词匹配预定义的回复模板，
/// 通过 [Stream] 逐字推送文本内容以实现打字机效果。
/// 同时生成结构化卡片（告警/确认/信息/动作卡片）嵌入回复。
class AgentChatService {
  final _random = Random();
  final _messageCounter = <String, int>{};

  /// 当前会话的消息历史（用于上下文感知）
  final List<AgentMessage> _history = [];

  /// 按关键词匹配的回复模板
  static final _responseTemplates = {
    '告警': _AlertResponse(),
    '车队': _FleetResponse(),
    '设备': _FleetResponse(),
    '车辆': _FleetResponse(),
    '任务': _MissionResponse(),
    '状态': _StatusResponse(),
    '帮助': _HelpResponse(),
    '建议': _SuggestionResponse(),
  };

  /// 默认兜底回复
  static final _defaultResponse = _DefaultResponse();

  /// 发送消息并返回流式响应
  Stream<AgentMessage> sendMessage(String content, {List<AgentCard>? contextCards}) async* {
    final userMsgId = _nextId('user');
    final userMsg = AgentMessage(
      id: userMsgId,
      content: content,
      role: 'user',
      timestamp: DateTime.now(),
    );
    _history.add(userMsg);
    yield userMsg;

    // 查找匹配的回复模板
    final template = _matchTemplate(content);

    // 生成回复 ID
    final assistantMsgId = _nextId('assistant');

    // 构建完整回复文本
    final fullText = template.buildText(content, _history);

    // 生成结构化卡片
    final cards = template.buildCards(content, _history);

    // 延迟一小段时间模拟"思考中"
    await Future.delayed(const Duration(milliseconds: 400));

    // 逐字流式输出
    final buffer = StringBuffer();
    for (int i = 0; i < fullText.length; i++) {
      buffer.write(fullText[i]);
      yield AgentMessage(
        id: assistantMsgId,
        content: buffer.toString(),
        role: 'assistant',
        timestamp: DateTime.now(),
        cards: i == fullText.length - 1 ? cards : null,
        isStreaming: i < fullText.length - 1,
      );

      // 模拟打字速度：中文 50ms/字，英文/标点 15ms
      final char = fullText[i];
      final delay = _isChineseChar(char) ? 50 + _random.nextInt(40) : 15 + _random.nextInt(10);
      await Future.delayed(Duration(milliseconds: delay));
    }

    // 最终完整消息
    final finalMsg = AgentMessage(
      id: assistantMsgId,
      content: fullText,
      role: 'assistant',
      timestamp: DateTime.now(),
      cards: cards,
      isStreaming: false,
    );
    _history.add(finalMsg);
    yield finalMsg;
  }

  /// 根据当前告警上下文生成 Agent 建议
  Future<AgentMessage?> getSuggestionForAlert(Map<String, dynamic> alertContext) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final alertTitle = alertContext['title'] as String? ?? '未知告警';
    final alertLevel = alertContext['level'] as String? ?? 'info';
    final vehicleName = alertContext['vehicleName'] as String? ?? '未知车辆';

    final msgId = _nextId('suggestion');
    String suggestionText;
    List<AgentCard> cards;

    if (alertTitle.contains('温度') || alertTitle.contains('过热')) {
      suggestionText = '检测到 $vehicleName $alertTitle，建议立即暂停作业并派遣维修人员检查。是否需要我为您暂停该车辆的当前任务？';
      cards = [
        AgentCard.alertCard(
          alertId: alertContext['alertId'] as String? ?? msgId,
          title: alertTitle,
          level: alertLevel,
          message: '$vehicleName 出现严重告警，发动机温度超出安全阈值。',
          vehicleName: vehicleName,
          actions: ['暂停作业', '忽略', '详情'],
        ),
      ];
    } else if (alertTitle.contains('油量') || alertTitle.contains('燃油')) {
      suggestionText = '$vehicleName $alertTitle，建议安排该车辆返回加油点。是否需要我规划最近加油路线？';
      cards = [
        AgentCard.alertCard(
          alertId: alertContext['alertId'] as String? ?? msgId,
          title: alertTitle,
          level: alertLevel,
          message: '$vehicleName 燃油不足，可能影响正常作业。',
          vehicleName: vehicleName,
          actions: ['规划路线', '忽略', '详情'],
        ),
      ];
    } else if (alertTitle.contains('超速')) {
      suggestionText = '$vehicleName $alertTitle，已自动记录此次违规。建议向驾驶员发送警告通知。';
      cards = [
        AgentCard.alertCard(
          alertId: alertContext['alertId'] as String? ?? msgId,
          title: alertTitle,
          level: alertLevel,
          message: '$vehicleName 行驶速度超出矿区限速规定。',
          vehicleName: vehicleName,
          actions: ['发送警告', '忽略', '详情'],
        ),
      ];
    } else {
      suggestionText = '$vehicleName 触发了一条「$alertTitle」告警，需要我帮您分析处理吗？';
      cards = [
        AgentCard.actionCard(
          title: '检测到新告警',
          description: '$vehicleName — $alertTitle',
          actions: ['分析原因', '查看详情', '忽略'],
          status: 'pending',
        ),
      ];
    }

    final msg = AgentMessage(
      id: msgId,
      content: suggestionText,
      role: 'assistant',
      timestamp: DateTime.now(),
      cards: cards,
      isStreaming: false,
    );

    _history.add(msg);
    return msg;
  }

  /// 确认/取消操作
  Future<AgentMessage> confirmAction(String actionId, bool confirmed) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final msgId = _nextId('confirm_result');
    final text = confirmed
        ? '✅ 操作已确认执行。系统正在处理您的请求...'
        : '操作已取消。如需其他帮助，请随时告诉我。';

    final msg = AgentMessage(
      id: msgId,
      content: text,
      role: 'assistant',
      timestamp: DateTime.now(),
      isStreaming: false,
    );
    _history.add(msg);
    return msg;
  }

  /// 获取历史消息
  List<AgentMessage> get history => List.unmodifiable(_history);

  /// 清除历史
  void clearHistory() => _history.clear();

  /// 释放资源
  void dispose() {
    _history.clear();
  }

  // --- 私有方法 ---

  /// 生成带前缀的唯一消息 ID
  String _nextId(String prefix) {
    final count = (_messageCounter[prefix] ?? 0) + 1;
    _messageCounter[prefix] = count;
    return '${prefix}_${DateTime.now().millisecondsSinceEpoch}_$count';
  }

  /// 按关键词匹配回复模板，无匹配时返回默认模板
  static _ResponseTemplate _matchTemplate(String content) {
    for (final entry in _responseTemplates.entries) {
      if (content.contains(entry.key)) {
        return entry.value;
      }
    }
    return _defaultResponse;
  }

  /// 判断字符是否为中文字符（Unicode CJK 范围）
  static bool _isChineseChar(String char) {
    final code = char.codeUnitAt(0);
    return code >= 0x4E00 && code <= 0x9FFF;
  }
}

/// 回复模板抽象接口
///
/// 每种对话场景（告警/车队/任务/状态/帮助/建议）对应一个实现类，
/// 提供对应的 [buildText] 和可选的 [buildCards] 输出。
abstract class _ResponseTemplate {
  String buildText(String input, List<AgentMessage> history);
  List<AgentCard>? buildCards(String input, List<AgentMessage> history);
}

/// 告警相关回复模板
class _AlertResponse implements _ResponseTemplate {
  @override
  String buildText(String input, List<AgentMessage> history) {
    return '收到您的告警查询。当前系统中共有 5 条活跃告警，其中 2 条严重、2 条警告、1 条提示。建议优先处理严重级别的告警。\n\n最近告警：矿卡-003 发动机温度过高 (142°C)，已持续 15 分钟。';
  }

  @override
  List<AgentCard>? buildCards(String input, List<AgentMessage> history) {
    return [
      AgentCard.alertCard(
        alertId: 'alert_engine_temp',
        title: '发动机温度过高',
        level: 'critical',
        message: '矿卡-003 发动机温度达 142°C，超出安全阈值 (120°C)。建议立即暂停作业。',
        vehicleName: '矿卡-003',
        actions: ['暂停作业', '忽略', '详情'],
      ),
      AgentCard.infoCard(
        title: '告警统计',
        content: '当前系统告警汇总',
        iconName: 'warning',
        fields: [
          const InfoField(label: '严重', value: '2 条'),
          const InfoField(label: '警告', value: '2 条'),
          const InfoField(label: '提示', value: '1 条'),
          const InfoField(label: '未确认', value: '3 条'),
        ],
      ),
    ];
  }
}

/// 车队相关回复模板
class _FleetResponse implements _ResponseTemplate {
  @override
  String buildText(String input, List<AgentMessage> history) {
    return '当前车队状态总览：\n\n🟢 在线：5 辆矿卡、1 辆挖掘机、1 辆推土机\n🟡 告警：矿卡-003（发动机高温）\n🔴 离线：矿卡-005（GPS 信号丢失）\n\n整体出勤率 87.5%，设备利用率 72.3%。矿卡-003 建议尽快安排维修。';
  }

  @override
  List<AgentCard>? buildCards(String input, List<AgentMessage> history) {
    return [
      AgentCard.infoCard(
        title: '车队运营概览',
        content: '当前核心设备运行指标',
        iconName: 'info',
        fields: [
          const InfoField(label: '在线设备', value: '7 台'),
          const InfoField(label: '出勤率', value: '87.5%'),
          const InfoField(label: '设备利用率', value: '72.3%'),
          const InfoField(label: '平均油耗', value: '24.5 L/h'),
        ],
      ),
    ];
  }
}

/// 任务相关回复模板
class _MissionResponse implements _ResponseTemplate {
  @override
  String buildText(String input, List<AgentMessage> history) {
    return '当前任务状态汇总：\n\n📋 进行中：8 个任务（运输 5、装载 2、维修 1）\n⏳ 待接受：3 个任务\n✅ 已完成：45 个任务（今日）\n\n运输任务完成率 88%，平均运输周期 23 分钟。维修任务预计 30 分钟内完成。';
  }

  @override
  List<AgentCard>? buildCards(String input, List<AgentMessage> history) {
    return [
      AgentCard.infoCard(
        title: '任务执行摘要',
        content: '当日任务执行效率',
        iconName: 'success',
        fields: [
          const InfoField(label: '完成率', value: '88%'),
          const InfoField(label: '平均周期', value: '23 分钟'),
          const InfoField(label: '待处理', value: '11 个'),
        ],
      ),
    ];
  }
}

/// 状态相关回复模板
class _StatusResponse implements _ResponseTemplate {
  @override
  String buildText(String input, List<AgentMessage> history) {
    return '系统运行状态正常。\n\n✅ 服务器：正常运行 72 小时\n✅ 数据库：连接正常\n✅ WebSocket：实时推送活跃\n✅ GPS 服务：32 颗卫星锁定\n✅ 传感器网络：56/56 在线\n\n所有核心服务运行稳定，无需人工干预。';
  }

  @override
  List<AgentCard>? buildCards(String input, List<AgentMessage> history) {
    return null;
  }
}

/// 帮助相关回复模板
class _HelpResponse implements _ResponseTemplate {
  @override
  String buildText(String input, List<AgentMessage> history) {
    return '您好！我是 CUSTOM 矿山运营 AI 助手，可以帮您：\n\n📊 查询车队状态 — 输入「车队」或「设备」\n🚨 处理告警 — 输入「告警」\n📋 管理任务 — 输入「任务」\n📈 查看运营数据 — 输入「状态」\n💡 获取运营建议 — 输入「建议」\n\n如需更多帮助，请随时告诉我！';
  }

  @override
  List<AgentCard>? buildCards(String input, List<AgentMessage> history) {
    return [
      AgentCard.actionCard(
        title: '常用操作',
        description: '请选择您需要的服务',
        actions: ['查询车队状态', '查看当前告警', '任务管理', '运营数据分析'],
        status: 'pending',
      ),
    ];
  }
}

/// 建议回复模板
class _SuggestionResponse implements _ResponseTemplate {
  @override
  String buildText(String input, List<AgentMessage> history) {
    return '基于当前矿山运营数据分析，建议如下：\n\n🔧 维护建议：矿卡-003 发动机温度持续偏高，建议安排预防性维护\n⛽ 加油建议：3 辆矿卡油量低于 30%，建议在下一循环安排加油\n📊 调度优化：A 区作业密度较高，建议将 2 个运输任务分流至 B 区\n⚡ 效率提升：当前装卸车等待时间平均 8 分钟，优化后可降至 5 分钟\n\n是否需要我针对以上任一条建议下达操作指令？';
  }

  @override
  List<AgentCard>? buildCards(String input, List<AgentMessage> history) {
    return [
      AgentCard.confirmCard(
        actionId: 'suggest_maintenance',
        title: '预防性维护建议',
        message: '建议为矿卡-003 安排发动机检查维护，预计停机 2 小时。是否确认？',
        confirmLabel: '确认安排',
        cancelLabel: '暂缓处理',
        severity: 'warning',
      ),
      AgentCard.confirmCard(
        actionId: 'suggest_refuel',
        title: '批量加油建议',
        message: '建议安排矿卡-001、002、004 在完成当前任务后返回加油点。是否确认？',
        confirmLabel: '批量安排',
        cancelLabel: '暂缓处理',
        severity: 'warning',
      ),
    ];
  }
}

/// 默认回复模板
class _DefaultResponse implements _ResponseTemplate {
  @override
  String buildText(String input, List<AgentMessage> history) {
    return '收到您的消息：「$input」。\n\n我是 CUSTOM 矿山运营 AI 助手，可以帮您查询车队状态、处理告警、管理任务等。请输入「帮助」查看我支持的功能列表。';
  }

  @override
  List<AgentCard>? buildCards(String input, List<AgentMessage> history) {
    return [
      AgentCard.actionCard(
        title: '我可以帮您做什么？',
        description: '请选择以下服务',
        actions: ['查询车队状态', '查看当前告警', '任务管理', '运营数据分析', '获取运营建议'],
        status: 'pending',
      ),
    ];
  }
}