import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_data/cat_data.dart';
import '../providers/dashboard_stats_provider.dart';
import '../providers/live_vehicle_provider.dart';
import '../widgets/connectivity_badge.dart';

/// 运营概览 Dashboard 页面
///
/// 展示四个核心统计卡片：设备总数、在线车辆、进行中任务、今日告警。
/// 数据来自 Riverpod Provider，卡片数字带渐进式入场动画。
class DashboardPage extends ConsumerWidget {
  final String title;
  const DashboardPage({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // 离线模式 Badge（网络断开时显示）
        const ConnectivityBadge(),
        // 主内容区
        Expanded(
          child: Center(
            child: statsAsync.when(
              loading: () => _buildLoading(),
              error: (err, stack) {
                print(err);
                return _buildError(err.toString());
              },
              data: (stats) => _buildStatsGrid(context, stats, textTheme, ref),
            ),
          ),
        ),
      ],
    );
  }

  /// 加载中状态 — 显示骨架屏动画
  Widget _buildLoading() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Loading stats...', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  /// 错误状态 — 显示错误信息
  Widget _buildError(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 48, color: Colors.red),
        const SizedBox(height: 16),
        Text('数据加载失败', style: const TextStyle(color: Colors.red, fontSize: 16)),
        const SizedBox(height: 8),
        Text(message, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  /// 统计卡片网格 — 响应式布局，窄屏单列，宽屏两列
  Widget _buildStatsGrid(BuildContext context, DashboardStats stats, TextTheme textTheme, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 2 : 1;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 页面标题
          Text(title, style: textTheme.headlineMedium),
          const SizedBox(height: 4),
          const Text('矿山运营实时统计', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 28),

          // 统计卡片网格
          GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: crossAxisCount == 2 ? 2.5 : 2.8,
            children: [
              _StatCard(
                index: 0,
                icon: Icons.precision_manufacturing,
                label: '设备总数',
                value: stats.totalDevices,
                unit: '台',
                color: CatColors.tabletPrimary,
              ),
              _StatCard(
                index: 1,
                icon: Icons.local_shipping,
                label: '在线车辆',
                value: stats.onlineVehicles,
                unit: '辆',
                color: CatColors.online,
              ),
              _StatCard(
                index: 2,
                icon: Icons.assignment,
                label: '进行中任务',
                value: stats.activeMissions,
                unit: '个',
                color: CatColors.tabletWarning,
              ),
              _StatCard(
                index: 3,
                icon: Icons.warning_amber,
                label: '今日告警',
                value: stats.todayAlerts,
                unit: '条',
                color: CatColors.alertCritical,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // 实时车辆状态列表（WebSocket 驱动）
          _buildLiveVehicleSection(ref, textTheme),

          const SizedBox(height: 20),
          // 提示信息
          Text(
            '数据来源：Mock + WebSocket 实时推送（Step 6 Demo）',
            style: textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// 实时车辆状态区域（WebSocket 驱动刷新）
  ///
  /// 横向滚动列表展示车辆实时状态：名称、速度、油量、在线/离线。
  /// 数据每 3 秒从 MockWebSocketService 推送更新。
  Widget _buildLiveVehicleSection(WidgetRef ref, TextTheme textTheme) {
    final snapshotsAsync = ref.watch(liveVehicleProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.directions_car, size: 18),
            const SizedBox(width: 6),
            Text('车辆实时状态', style: textTheme.titleSmall),
            const Spacer(),
            // 实时更新指示灯
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: CatColors.online,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            const Text('LIVE', style: TextStyle(color: CatColors.online, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 96,
          child: snapshotsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            error: (err, _) => Text('实时数据加载失败', style: TextStyle(color: Colors.grey, fontSize: 12)),
            data: (snapshots) {
              if (snapshots.isEmpty) {
                return const Center(
                  child: Text('等待实时数据推送...', style: TextStyle(color: Colors.grey, fontSize: 12)),
                );
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: snapshots.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final s = snapshots[index];
                  return _LiveVehicleCard(snapshot: s);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// 单个统计卡片组件
///
/// 包含图标、标签、数字，数字带从 0 滚动到目标值的渐进动画。
class _StatCard extends StatefulWidget {
  final int index;         // 卡片序号，用于错开动画延迟
  final IconData icon;     // 图标
  final String label;      // 标签文字
  final int value;         // 统计数值
  final String unit;       // 单位
  final Color color;       // 主题色

  const _StatCard({
    required this.index,
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    // 错开动画延迟：每张卡片比前一张晚 100ms 开始
    final delay = Duration(milliseconds: widget.index * 100);
    Future.delayed(delay, () {
      if (mounted) _controller.forward();
    });
    // 淡入 + 缩放动画曲线
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: CatCard(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // 左侧彩色图标区域
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: widget.color.withAlpha(25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.icon, color: widget.color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  // 右侧数据区域
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.label, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                        const SizedBox(height: 4),
                        // 大数字展示
                        Text(
                          '${widget.value} ${widget.unit}',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: widget.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 实时车辆状态卡片
///
/// 展示单辆车的实时状态：名称、速度、油量、在线状态。
/// 数据来自 [liveVehicleProvider] 订阅的 WebSocket 推送。
class _LiveVehicleCard extends StatelessWidget {
  final LiveVehicleSnapshot snapshot;
  const _LiveVehicleCard({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final isMoving = snapshot.status == 'moving';
    final statusLabel = _statusLabel(snapshot.status);
    final statusColor = _statusColor(snapshot.status);

    return SizedBox(
      width: 150,
      child: CatCard(
        padding: const EdgeInsets.all(10),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 车辆名称 + 状态 Badge
          Row(
            children: [
              Icon(
                Icons.local_shipping,
                size: 14,
                color: isMoving ? CatColors.online : CatColors.offline,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  snapshot.name,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(fontSize: 9, color: statusColor, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // 速度
          Row(
            children: [
              const Icon(Icons.speed, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${snapshot.speed.toStringAsFixed(1)} km/h',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isMoving ? CatColors.online : Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // 油量
          Row(
            children: [
              const Icon(Icons.local_gas_station, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${snapshot.fuel.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: snapshot.fuel < 20 ? CatColors.alertWarning : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: snapshot.fuel / 100,
                        minHeight: 3,
                        backgroundColor: Colors.grey.withAlpha(40),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          snapshot.fuel < 20 ? CatColors.alertWarning : CatColors.online,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'moving':
        return '行驶中';
      case 'idle':
        return '空闲';
      case 'loading':
        return '装载中';
      case 'dumping':
        return '卸料中';
      default:
        return status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'moving':
        return CatColors.online;
      case 'idle':
        return Colors.grey;
      case 'loading':
        return CatColors.alertWarning;
      case 'dumping':
        return CatColors.alertWarning;
      default:
        return Colors.grey;
    }
  }
}