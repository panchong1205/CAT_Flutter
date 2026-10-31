import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_data/cat_data.dart';
import '../providers/alert_provider.dart';

/// 车载终端 Shell
///
/// 提供左侧侧边栏 + 右侧内容区的横屏布局。
/// Step 9 新增全屏告警弹窗 — 监听 WebSocket 推送的 alert_new 事件，
/// critical 级别告警以全屏弹窗形式最高优先级中断当前操作。
class VehicleShell extends ConsumerStatefulWidget {
  final Widget child;
  const VehicleShell({super.key, required this.child});

  @override
  ConsumerState<VehicleShell> createState() => _VehicleShellState();
}

class _VehicleShellState extends ConsumerState<VehicleShell> {
  /// 驾驶员专属导航项（精简为 5 项核心功能）
  ///
  /// 与平板/手机的全功能导航不同，车载终端仅展示驾驶员角色所需的功能：
  /// 矿区地图、我的任务、车辆状态、告警、AI 助手。
  static const _navItems = [
    (Icons.map, '矿区地图', '/map'),
    (Icons.assignment, '我的任务', '/missions'),
    (Icons.directions_car, '车辆状态', '/vehicle-status'),
    (Icons.warning_amber, '告警', '/alerts'),
    (Icons.smart_toy, 'AI 助手', '/agent'),
  ];

  /// 当前是否正在显示全屏告警弹窗
  bool _alertPopupVisible = false;
  /// 当前全屏告警的数据
  LiveEvent? _currentAlertEvent;

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    super.dispose();
  }

  /// 处理键盘快捷键事件
  ///
  /// 全屏告警弹窗期间：Enter/Space 确认，Escape 关闭。
  /// 非告警期间：Escape 返回上一页，F1-F5 快速导航 5 个菜单项。
  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      // 全屏告警弹窗时的快捷键处理
      if (_alertPopupVisible) {
        if (event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.space) {
          _acknowledgeCurrentAlert();
          return true;
        }
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          _dismissCurrentAlert();
          return true;
        }
        return true; // 告警弹窗期间屏蔽其他按键
      }

      if (event.logicalKey == LogicalKeyboardKey.escape) {
        Navigator.of(context).maybePop();
        return true;
      }
      final keyMap = {
        LogicalKeyboardKey.f1: 0,
        LogicalKeyboardKey.f2: 1,
        LogicalKeyboardKey.f3: 2,
        LogicalKeyboardKey.f4: 3,
        LogicalKeyboardKey.f5: 4,
      };
      final idx = keyMap[event.logicalKey];
      if (idx != null) {
        _onNavigate(_navItems[idx].$3);
        return true;
      }
    }
    return false;
  }

  String _currentRoute() {
    return GoRouterState.of(context).uri.toString();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final currentRoute = _currentRoute();

    // 监听实时告警推送，critical 级别自动弹出
    ref.listen<AsyncValue<LiveEvent>>(liveAlertStreamProvider, (_, next) {
      next.whenData((event) {
        final level = event.payload['level'] as String? ?? 'info';
        if (level == 'critical' && !_alertPopupVisible) {
          _showFullScreenAlert(event);
        }
      });
    });

    return Scaffold(
      body: Stack(
        children: [
          // 主布局
          Row(
            children: [
              Container(
                width: 280,
                color: CatColors.vehicleSurface,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Icon(Icons.precision_manufacturing, size: 48, color: colors.primary),
                      const SizedBox(height: 12),
                      Text('CUSTOM Vehicle', style: textTheme.headlineMedium?.copyWith(color: colors.primary)),
                      const SizedBox(height: 4),
                      Text('车载终端', style: textTheme.bodyLarge?.copyWith(color: CatColors.vehicleOnSurface)),
                      const SizedBox(height: 20),
                      Divider(color: CatColors.vehicleBorder, indent: 32, endIndent: 32),
                      const SizedBox(height: 12),
                      for (var i = 0; i < _navItems.length; i++)
                        _SidebarItem(
                          icon: _navItems[i].$1,
                          label: _navItems[i].$2,
                          selected: currentRoute == _navItems[i].$3,
                          onTap: () => _onNavigate(_navItems[i].$3),
                        ),
                      const SizedBox(height: 12),
                      _buildBottomStatus(textTheme),
                    ],
                  ),
                ),
              ),
              Expanded(child: widget.child),
            ],
          ),

          // 全屏告警弹窗叠加层
          if (_alertPopupVisible && _currentAlertEvent != null)
            _buildFullScreenAlert(context),
        ],
      ),
    );
  }

  /// 显示全屏告警弹窗
  void _showFullScreenAlert(LiveEvent event) {
    setState(() {
      _alertPopupVisible = true;
      _currentAlertEvent = event;
    });

    // 60 秒后自动消失（如果未确认）
    Timer(const Duration(seconds: 60), () {
      if (mounted && _alertPopupVisible) {
        _dismissCurrentAlert();
      }
    });
  }

  /// 确认当前告警（操作员确认）
  ///
  /// 关闭弹窗，刷新告警列表，并显示确认成功 SnackBar。
  void _acknowledgeCurrentAlert() {
    setState(() => _alertPopupVisible = false);
    _currentAlertEvent = null;

    // 刷新告警列表
    ref.invalidate(alertsProvider);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Flexible(child: Text('告警已确认，正在调度处置方案...')),
          ],
        ),
        backgroundColor: CatColors.online,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 关闭当前告警弹窗
  void _dismissCurrentAlert() {
    setState(() => _alertPopupVisible = false);
    _currentAlertEvent = null;
  }

  /// 构建全屏告警弹窗
  ///
  /// 模拟紧急停车场景，红色闪烁背景 + 大号警告图标 + 告警详情。
  /// 支持键盘操作：Enter/空格 = 确认，Esc = 关闭。
  Widget _buildFullScreenAlert(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final event = _currentAlertEvent!;
    final title = event.payload['title'] as String? ?? '紧急告警';
    final message = event.payload['message'] as String? ?? '';
    final vehicleId = event.payload['vehicleId'] as String?;

    return Container(
      color: CatColors.alertCritical.withAlpha(220),
      child: Center(
        child: Container(
          width: 560,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: CatColors.vehicleBg,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: CatColors.alertCritical, width: 3),
            boxShadow: [
              BoxShadow(
                color: CatColors.alertCritical.withAlpha(80),
                blurRadius: 60,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 闪烁警告图标
              _PulsingWarningIcon(),
              const SizedBox(height: 28),

              // 告警标题
              Text(
                title,
                style: textTheme.headlineMedium?.copyWith(
                  color: CatColors.alertCritical,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // 告警详情
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: CatColors.vehicleSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: CatColors.vehicleBorder),
                ),
                child: Column(
                  children: [
                    Text(
                      message,
                      style: textTheme.bodyLarge?.copyWith(
                        color: CatColors.vehicleOnSurface,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (vehicleId != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_shipping, size: 16, color: CatColors.vehicleOnSurface),
                          const SizedBox(width: 6),
                          Text(
                            '关联车辆：$vehicleId',
                            style: textTheme.bodyMedium?.copyWith(
                              color: CatColors.vehicleOnSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 操作按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 确认按钮
                  ElevatedButton.icon(
                    onPressed: _acknowledgeCurrentAlert,
                    icon: const Icon(Icons.check_circle_outline, size: 22),
                    label: const Text('确认 (Enter)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CatColors.online,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // 关闭按钮
                  OutlinedButton.icon(
                    onPressed: _dismissCurrentAlert,
                    icon: const Icon(Icons.close, size: 22),
                    label: const Text('关闭 (Esc)'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: CatColors.vehicleOnSurface,
                      side: const BorderSide(color: CatColors.vehicleBorder),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text(
                '按 Enter 确认处置 · 按 Esc 关闭 · 60s 后自动关闭',
                style: textTheme.bodySmall?.copyWith(
                  color: CatColors.vehicleOnSurface.withAlpha(120),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomStatus(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Divider(color: CatColors.vehicleBorder),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: CatColors.online, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text('CAN 已连接', style: textTheme.bodySmall?.copyWith(color: CatColors.vehicleOnSurface)),
            ],
          ),
          const SizedBox(height: 8),
          Text('F1-F5 快捷切换 | Esc 返回', style: textTheme.bodySmall?.copyWith(color: CatColors.vehicleOnSurface, fontSize: 10)),
        ],
      ),
    );
  }

  void _onNavigate(String route) {
    if (_currentRoute() != route) {
      GoRouter.of(context).go(route);
    }
  }
}

/// 脉冲闪烁警告图标
///
/// 使用 AnimationController 实现图标尺寸的周期性缩放动画，
/// 模拟紧急告警时的视觉闪烁效果。
class _PulsingWarningIcon extends StatefulWidget {
  const _PulsingWarningIcon();

  @override
  State<_PulsingWarningIcon> createState() => _PulsingWarningIconState();
}

class _PulsingWarningIconState extends State<_PulsingWarningIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: CatColors.alertCritical.withAlpha(50),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: CatColors.alertCritical.withAlpha(100),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: CatColors.alertCritical,
            ),
          ),
        );
      },
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarItem({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: selected ? colors.primary.withAlpha(25) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: selected ? Border.all(color: colors.primary.withAlpha(60)) : null,
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: selected ? colors.primary : CatColors.vehicleOnSurface),
                const SizedBox(width: 12),
                Text(label, style: TextStyle(color: selected ? colors.primary : CatColors.vehicleOnSurface, fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}