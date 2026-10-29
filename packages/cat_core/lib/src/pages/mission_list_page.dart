import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import '../providers/mission_provider.dart';
import '../widgets/mission_card.dart';
import '../widgets/mission_new_dialog.dart';
import 'mission_detail_page.dart';

/// 任务列表页面
///
/// 按任务状态（待接受/进行中/已完成）分组展示所有运输任务。
/// 支持按名称搜索和按优先级筛选功能。
class MissionListPage extends ConsumerStatefulWidget {
  final String title;

  const MissionListPage({super.key, required this.title});

  @override
  ConsumerState<MissionListPage> createState() => _MissionListPageState();
}

class _MissionListPageState extends ConsumerState<MissionListPage> {
  String _searchQuery = '';
  String? _filterPriority; // null 表示显示全部
  bool _showCompleted = false; // 默认收起已完成分组

  /// 按搜索词和优先级过滤任务列表
  List<Mission> _filter(List<Mission> missions) {
    return missions.where((m) {
      // 名称搜索过滤
      if (_searchQuery.isNotEmpty &&
          !m.name.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      // 优先级过滤
      if (_filterPriority != null && m.priority != _filterPriority) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final missionsAsync = ref.watch(missionsProvider);
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Column(
          children: [
            // 搜索 + 筛选栏
            _buildFilterBar(textTheme),

            // 任务列表内容
            Expanded(
              child: missionsAsync.when(
                loading: () => _buildLoading(),
                error: (err, _) => _buildError(err.toString()),
                data: (missions) => _buildGroupedList(missions, textTheme),
              ),
            ),
          ],
        ),
        // 模拟新任务按钮（演示车载端弹窗效果）
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton.extended(
            onPressed: () => _showNewMissionDialog(context),
            icon: const Icon(Icons.campaign),
            label: const Text('模拟新任务'),
            backgroundColor: CatColors.alertWarning,
          ),
        ),
      ],
    );
  }

  /// 显示新任务弹窗（模拟车载终端 TTS 播报效果）
  void _showNewMissionDialog(BuildContext context) {
    // 创建一个模拟的演示任务
    final demoMission = Mission(
      id: 'mission-demo-${DateTime.now().millisecondsSinceEpoch}',
      name: '紧急运输任务 — 铁矿石',
      vehicleId: 'v-003',
      status: 'pending',
      loadPoint: '装载点-A（主矿区）',
      unloadPoint: '卸载点-X（破碎站）',
      targetLoad: 80.0,
      currentLoad: 0.0,
      createdAt: DateTime.now(),
      priority: 'urgent',
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => MissionNewDialog(
        mission: demoMission,
        onAccept: () {
          Navigator.of(ctx).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Flexible(child: Text('任务已接受！开始执行...')),
                ],
              ),
              backgroundColor: CatColors.online,
              behavior: SnackBarBehavior.floating,
            ),
          );
          ref.invalidate(missionsProvider);
        },
        onReject: () {
          Navigator.of(ctx).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.cancel, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Flexible(child: Text('任务已拒绝')),
                ],
              ),
              backgroundColor: CatColors.alertCritical,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
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
                  hintText: '搜索任务...',
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

          // 优先级筛选下拉
          PopupMenuButton<String>(
            tooltip: '优先级筛选',
            icon: Icon(
              Icons.filter_list,
              color: _filterPriority != null ? CatColors.tabletPrimary : Colors.grey,
              size: 20,
            ),
            onSelected: (v) => setState(() => _filterPriority = v),
            itemBuilder: (_) => [
              const PopupMenuItem(value: '', child: Text('全部优先级')),
              const PopupMenuItem(value: 'urgent', child: Text('紧急', style: TextStyle(color: CatColors.alertCritical))),
              const PopupMenuItem(value: 'high', child: Text('高优先级', style: TextStyle(color: CatColors.alertWarning))),
              const PopupMenuItem(value: 'normal', child: Text('普通')),
            ],
          ),

          const SizedBox(width: 4),

          // 刷新按钮
          IconButton(
            icon: const Icon(Icons.refresh, size: 20),
            tooltip: '刷新',
            onPressed: () => ref.invalidate(missionsProvider),
          ),
        ],
      ),
    );
  }

  /// 构建分组列表
  Widget _buildGroupedList(List<Mission> allMissions, TextTheme textTheme) {
    // 按状态分组
    final pending = _filter(allMissions.where((m) => m.status == 'pending').toList());
    final inProgress = _filter(allMissions.where((m) => m.status == 'in_progress').toList());
    final completed = _filter(allMissions.where((m) => m.status == 'completed').toList());
    final cancelled = _filter(allMissions.where((m) => m.status == 'cancelled').toList());

    final hasFilter = _searchQuery.isNotEmpty || _filterPriority != null;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 进行中分组
        _buildGroupHeader(
          icon: Icons.play_circle,
          label: '进行中',
          count: inProgress.length,
          color: CatColors.online,
          textTheme: textTheme,
        ),
        if (inProgress.isEmpty)
          _buildEmptyGroup('暂无进行中任务')
        else
          ...inProgress.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MissionCard(
                  mission: m,
                  onTap: () => _navigateToDetail(m),
                ),
              )),

        const SizedBox(height: 8),

        // 待接受分组
        _buildGroupHeader(
          icon: Icons.schedule,
          label: '待接受',
          count: pending.length,
          color: CatColors.alertWarning,
          textTheme: textTheme,
        ),
        if (pending.isEmpty)
          _buildEmptyGroup('暂无待接受任务')
        else
          ...pending.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MissionCard(
                  mission: m,
                  onTap: () => _navigateToDetail(m),
                ),
              )),

        const SizedBox(height: 8),

        // 已完成分组（可折叠）
        if (completed.isNotEmpty || cancelled.isNotEmpty) ...[
          InkWell(
            onTap: () => setState(() => _showCompleted = !_showCompleted),
            child: _buildGroupHeader(
              icon: Icons.check_circle,
              label: '已完成',
              count: completed.length + cancelled.length,
              color: CatColors.tabletPrimary,
              textTheme: textTheme,
              trailing: Icon(
                _showCompleted ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
          if (_showCompleted) ...[
            ...completed.map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MissionCard(
                    mission: m,
                    onTap: () => _navigateToDetail(m),
                  ),
                )),
            ...cancelled.map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MissionCard(
                    mission: m,
                    onTap: () => _navigateToDetail(m),
                  ),
                )),
          ],
        ],

        // 搜索结果为空提示
        if (hasFilter && pending.isEmpty && inProgress.isEmpty && completed.isEmpty && cancelled.isEmpty)
          _buildEmptyGroup('没有找到匹配的任务'),

        const SizedBox(height: 20),
      ],
    );
  }

  /// 分组标题
  Widget _buildGroupHeader({
    required IconData icon,
    required String label,
    required int count,
    required Color color,
    required TextTheme textTheme,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
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
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  /// 空分组提示
  Widget _buildEmptyGroup(String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(10),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(message, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ),
      ),
    );
  }

  /// 加载中状态
  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 12),
          Text('加载任务数据...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  /// 错误状态
  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          Text('加载失败', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(message, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 12),
          CatButton.text(
            label: '重试',
            onPressed: () => ref.invalidate(missionsProvider),
          ),
        ],
      ),
    );
  }

  /// 导航到任务详情页
  void _navigateToDetail(Mission mission) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProviderScope(
          child: _MissionDetailShell(mission: mission),
        ),
      ),
    );
  }
}

/// 任务详情 Shell（包装 ProviderScope）
class _MissionDetailShell extends StatelessWidget {
  final Mission mission;
  const _MissionDetailShell({required this.mission});

  @override
  Widget build(BuildContext context) {
    return MissionDetailPage(mission: mission);
  }
}