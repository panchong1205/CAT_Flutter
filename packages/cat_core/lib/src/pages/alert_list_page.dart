import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import 'package:cat_data/cat_data.dart';
import '../providers/alert_provider.dart';
import '../providers/agent_provider.dart';
import '../widgets/alert_severity_indicator.dart';
import 'alert_detail_page.dart';

/// 告警列表页面
///
/// 按严重程度（严重/警告/提示）分组展示所有告警，
/// 每行以不同颜色标识级别，支持按确认状态筛选和搜索。
/// 实时订阅 WebSocket 推送的新告警事件。
class AlertListPage extends ConsumerStatefulWidget {
  final String title;

  const AlertListPage({super.key, required this.title});

  @override
  ConsumerState<AlertListPage> createState() => _AlertListPageState();
}

class _AlertListPageState extends ConsumerState<AlertListPage> {
  String _searchQuery = '';
  bool? _filterAcknowledged; // null = 全部, true = 已确认, false = 未确认

  /// 按搜索词和确认状态过滤告警
  List<Alert> _filter(List<Alert> alerts) {
    return alerts.where((a) {
      // 标题/消息搜索过滤
      if (_searchQuery.isNotEmpty &&
          !a.title.toLowerCase().contains(_searchQuery.toLowerCase()) &&
          !a.message.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      // 确认状态过滤
      if (_filterAcknowledged != null && a.acknowledged != _filterAcknowledged) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final alertsAsync = ref.watch(alertsProvider);
    final textTheme = Theme.of(context).textTheme;

    // 订阅实时告警推送，有新的告警到达时自动刷新列表并触发 Agent 建议
    ref.listen<AsyncValue<LiveEvent>>(liveAlertStreamProvider, (_, next) {
      next.whenData((event) {
        ref.invalidate(alertsProvider);
        // 当新的严重或警告告警到达时，自动触发 Agent 建议
        if (event.type == 'alert_new') {
          final alertData = event.payload;
          final level = alertData['level'] as String? ?? '';
          if (level == 'critical' || level == 'warning') {
            ref.read(agentChatProvider.notifier).handleAlertSuggestion(alertData);
          }
        }
      });
    });

    return Column(
      children: [
        // 搜索 + 筛选栏
        _buildFilterBar(textTheme),

        // 告警列表内容
        Expanded(
          child: alertsAsync.when(
            loading: () => _buildLoading(),
            error: (err, _) => _buildError(err.toString()),
            data: (alerts) => _buildGroupedList(alerts, textTheme),
          ),
        ),
      ],
    );
  }

  /// 搜索和筛选栏
  Widget _buildFilterBar(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // 搜索框
          Expanded(
            child: SizedBox(
              height: 36,
              child: TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: '搜索告警...',
                  hintStyle: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, size: 18),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.withAlpha(50)),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                style: textTheme.bodySmall,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // 确认状态筛选下拉
          PopupMenuButton<bool?>(
            tooltip: '确认状态筛选',
            icon: Icon(
              Icons.filter_list,
              color: _filterAcknowledged != null ? CatColors.tabletPrimary : Colors.grey,
              size: 20,
            ),
            onSelected: (v) => setState(() => _filterAcknowledged = v),
            itemBuilder: (_) => [
              const PopupMenuItem(value: null, child: Text('全部告警')),
              const PopupMenuItem(value: false, child: Text('未确认', style: TextStyle(color: CatColors.alertCritical))),
              const PopupMenuItem(value: true, child: Text('已确认', style: TextStyle(color: CatColors.online))),
            ],
          ),

          const SizedBox(width: 4),

          // 刷新按钮
          IconButton(
            icon: const Icon(Icons.refresh, size: 20),
            tooltip: '刷新',
            onPressed: () => ref.invalidate(alertsProvider),
          ),
        ],
      ),
    );
  }

  /// 构建分组列表
  Widget _buildGroupedList(List<Alert> allAlerts, TextTheme textTheme) {
    // 按严重级别分组
    final critical = _filter(allAlerts.where((a) => a.level == 'critical').toList());
    final warning = _filter(allAlerts.where((a) => a.level == 'warning').toList());
    final info = _filter(allAlerts.where((a) => a.level == 'info').toList());

    final hasFilter = _searchQuery.isNotEmpty || _filterAcknowledged != null;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 严重告警分组
        _buildGroupHeader(
          icon: Icons.report,
          label: '严重告警',
          count: critical.length,
          color: CatColors.alertCritical,
          textTheme: textTheme,
        ),
        if (critical.isEmpty)
          _buildEmptyGroup('暂无严重告警')
        else
          ...critical.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AlertRow(
                  alert: a,
                  onTap: () => _navigateToDetail(a),
                ),
              )),

        const SizedBox(height: 8),

        // 警告分组
        _buildGroupHeader(
          icon: Icons.warning_amber,
          label: '警告',
          count: warning.length,
          color: CatColors.alertWarning,
          textTheme: textTheme,
        ),
        if (warning.isEmpty)
          _buildEmptyGroup('暂无警告')
        else
          ...warning.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AlertRow(
                  alert: a,
                  onTap: () => _navigateToDetail(a),
                ),
              )),

        const SizedBox(height: 8),

        // 提示信息分组
        _buildGroupHeader(
          icon: Icons.info_outline,
          label: '提示信息',
          count: info.length,
          color: CatColors.alertInfo,
          textTheme: textTheme,
        ),
        if (info.isEmpty)
          _buildEmptyGroup('暂无提示信息')
        else
          ...info.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AlertRow(
                  alert: a,
                  onTap: () => _navigateToDetail(a),
                ),
              )),

        // 空结果提示
        if (hasFilter && critical.isEmpty && warning.isEmpty && info.isEmpty)
          _buildNoResults(textTheme),
      ],
    );
  }

  /// 分组标题栏
  Widget _buildGroupHeader({
    required IconData icon,
    required String label,
    required int count,
    required Color color,
    required TextTheme textTheme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha(100),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(label, style: textTheme.titleSmall?.copyWith(color: color, fontWeight: FontWeight.w700)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 空分组提示
  Widget _buildEmptyGroup(String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(60),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 18, color: CatColors.online.withAlpha(150)),
          const SizedBox(width: 8),
          Text(message, style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  /// 无匹配结果
  Widget _buildNoResults(TextTheme textTheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey.withAlpha(100)),
            const SizedBox(height: 12),
            Text('没有找到匹配的告警', style: textTheme.bodyMedium?.copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  /// 加载中状态
  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  /// 错误状态
  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          const Text('告警数据加载失败', style: TextStyle(color: Colors.red, fontSize: 16)),
          const SizedBox(height: 8),
          Text(message, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  /// 导航到告警详情页
  void _navigateToDetail(Alert alert) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AlertDetailPage(alert: alert),
      ),
    );
  }
}

/// 单个告警行组件
///
/// 展示告警摘要：严重级别指示器、标题、时间、确认状态。
/// 左侧有明显颜色条标明告警级别。
class _AlertRow extends StatelessWidget {
  final Alert alert;
  final VoidCallback onTap;

  const _AlertRow({required this.alert, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final severityColor = AlertSeverityIndicator.colorForLevel(alert.level);

    return CatCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          children: [
            // 左侧颜色条
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: severityColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),

            // 内容区
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 第一行：严重级别 + 确认状态
                    Row(
                      children: [
                        AlertSeverityIndicator(
                          level: alert.level,
                          iconSize: 16,
                          fontSize: 12,
                        ),
                        const Spacer(),
                        // 确认状态标签
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: alert.acknowledged
                                ? CatColors.online.withAlpha(20)
                                : CatColors.alertWarning.withAlpha(20),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                alert.acknowledged ? Icons.check_circle : Icons.schedule,
                                size: 12,
                                color: alert.acknowledged ? CatColors.online : CatColors.alertWarning,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                alert.acknowledged ? '已确认' : '未确认',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: alert.acknowledged ? CatColors.online : CatColors.alertWarning,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // 告警标题
                    Text(
                      alert.title,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // 告警摘要
                    Text(
                      alert.message,
                      style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // 底部信息行
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 13, color: Colors.grey.withAlpha(150)),
                        const SizedBox(width: 4),
                        Text(
                          _formatDateTime(alert.createdAt),
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (alert.source == 'vehicle' && alert.vehicleId != null) ...[
                          Icon(Icons.local_shipping, size: 13, color: Colors.grey.withAlpha(150)),
                          const SizedBox(width: 4),
                          Text(
                            alert.vehicleId!,
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ],
                        const Spacer(),
                        Icon(Icons.chevron_right, size: 16, color: Colors.grey.withAlpha(100)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 格式化时间
  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return '刚刚';
    if (diff.inMinutes < 60) return '${diff.inMinutes} 分钟前';
    if (diff.inHours < 24) return '${diff.inHours} 小时前';
    if (diff.inDays < 7) return '${diff.inDays} 天前';

    return '${dt.month}/${dt.day} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}