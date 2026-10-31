import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_data/cat_data.dart';
import 'package:cat_domain/cat_domain.dart';
import '../providers/fleet_provider.dart';
import '../providers/live_vehicle_provider.dart';

/// 车载终端 — 车辆状态页面
///
/// 驾驶员视角的专属页面，以仪表盘风格实时展示当前矿卡的运行参数：
/// 速度、油量、发动机温度、胎压、GPS 坐标、累计里程等。
///
/// 数据来源：
/// - 静态车辆信息（型号/里程/驾驶员）→ [vehicleDetailProvider]
/// - 实时运行状态（速度/油量/坐标） → [liveVehicleProvider] (WebSocket 推送)
class VehicleStatusPage extends ConsumerWidget {
  final String title;
  final String vehicleId;

  const VehicleStatusPage({
    super.key,
    required this.title,
    required this.vehicleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final vehicleAsync = ref.watch(vehicleDetailProvider(vehicleId));
    final liveSnapshotsAsync = ref.watch(liveVehicleProvider);

    return Scaffold(
      backgroundColor: CatColors.vehicleBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 页头 — 车辆名称 + 驾驶员信息
            _buildHeader(textTheme, colors, vehicleAsync),
            const SizedBox(height: 28),

            // 核心仪表盘 — 速度、油量、发动机温度三个核心指标
            _buildCoreGauges(textTheme, colors, liveSnapshotsAsync, vehicleAsync),
            const SizedBox(height: 28),

            // 运行参数行 — 胎压、GPS 坐标、里程
            _buildExtraParams(textTheme, liveSnapshotsAsync),
          ],
        ),
      ),
    );
  }

  /// 页头：显示当前车辆名称、ID 和驾驶员工号
  Widget _buildHeader(
    TextTheme textTheme,
    ColorScheme colors,
    AsyncValue<Vehicle?> vehicleAsync,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: CatColors.vehicleSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CatColors.vehicleBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colors.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.directions_car, size: 36, color: colors.primary),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: vehicleAsync.when(
              loading: () => _buildSkeletonColumn(),
              error: (_, __) => _buildHeaderTexts(textTheme, colors, '矿卡 $vehicleId', '—'),
              data: (vehicle) {
                if (vehicle == null) {
                  return _buildHeaderTexts(textTheme, colors, '矿卡 $vehicleId', '—');
                }
                // 模拟驾驶员姓名（真实场景中由服务端下发）
                final mockDriver = '李师傅 (工号 D-${vehicleId.hashCode.abs() % 9000 + 1000})';
                return _buildHeaderTexts(textTheme, colors, vehicle.name, mockDriver);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderTexts(TextTheme textTheme, ColorScheme colors, String name, String driver) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: textTheme.headlineMedium?.copyWith(color: CatColors.vehicleOnSurface, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.person, size: 18, color: CatColors.vehicleOnSurface.withAlpha(140)),
            const SizedBox(width: 6),
            Text('驾驶员：$driver', style: textTheme.bodyLarge?.copyWith(color: CatColors.vehicleOnSurface.withAlpha(180))),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: CatColors.online.withAlpha(25),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: CatColors.online.withAlpha(80)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: CatColors.online, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text('CAN 在线', style: textTheme.bodySmall?.copyWith(color: CatColors.online)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 核心仪表盘区域：速度、油量、发动机温度
  Widget _buildCoreGauges(
    TextTheme textTheme,
    ColorScheme colors,
    AsyncValue<LiveVehicleSnapshots> liveAsync,
    AsyncValue<Vehicle?> vehicleAsync,
  ) {
    final snapshot = _findCurrentSnapshot(liveAsync);

    return Row(
      children: [
        // 速度表
        Expanded(
          child: _GaugeCard(
            icon: Icons.speed,
            label: '当前速度',
            value: snapshot?.speed.toStringAsFixed(1) ?? '—',
            unit: 'km/h',
            subLabel: snapshot != null ? _statusLabel(snapshot.status) : '等待数据',
            progress: (snapshot?.speed ?? 0) / 60,
            color: colors.primary,
            textTheme: textTheme,
          ),
        ),
        const SizedBox(width: 20),
        // 油量表
        Expanded(
          child: _GaugeCard(
            icon: Icons.local_gas_station,
            label: '剩余油量',
            value: snapshot?.fuel.toStringAsFixed(0) ?? '—',
            unit: '%',
            subLabel: snapshot != null ? _fuelSubLabel(snapshot.fuel) : '等待数据',
            progress: (snapshot?.fuel ?? 0) / 100,
            color: _fuelColor(snapshot?.fuel ?? 0),
            textTheme: textTheme,
          ),
        ),
        const SizedBox(width: 20),
        // 发动机温度
        Expanded(
          child: _GaugeCard(
            icon: Icons.thermostat,
            label: '发动机温度',
            value: _engineTemp(snapshot),
            unit: '°C',
            subLabel: _engineTempLabel(snapshot),
            progress: _engineTempProgress(snapshot),
            color: _engineTempColor(snapshot),
            textTheme: textTheme,
          ),
        ),
      ],
    );
  }

  /// 运行参数行：胎压、GPS 坐标、累计里程
  Widget _buildExtraParams(
    TextTheme textTheme,
    AsyncValue<LiveVehicleSnapshots> liveAsync,
  ) {
    final snapshot = _findCurrentSnapshot(liveAsync);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: CatColors.vehicleSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CatColors.vehicleBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('运行参数', style: textTheme.titleLarge?.copyWith(color: CatColors.vehicleOnSurface, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              return Wrap(
                spacing: 24,
                runSpacing: 20,
                children: [
                  SizedBox(
                    width: isWide ? 180 : double.infinity,
                    child: _ParamTile(
                      icon: Icons.circle,
                      label: '胎压',
                      value: '${_tirePressure(snapshot).toStringAsFixed(1)}',
                      unit: 'bar',
                      textTheme: textTheme,
                    ),
                  ),
                  SizedBox(
                    width: isWide ? 220 : double.infinity,
                    child: _ParamTile(
                      icon: Icons.gps_fixed,
                      label: 'GPS 坐标',
                      value: snapshot != null ? '${snapshot.latitude.toStringAsFixed(4)}, ${snapshot.longitude.toStringAsFixed(4)}' : '—, —',
                      unit: '',
                      textTheme: textTheme,
                    ),
                  ),
                  SizedBox(
                    width: isWide ? 160 : double.infinity,
                    child: _ParamTile(
                      icon: Icons.route,
                      label: '累计里程',
                      value: '${12500 + vehicleId.hashCode.abs() % 5000}',
                      unit: 'km',
                      textTheme: textTheme,
                    ),
                  ),
                  SizedBox(
                    width: isWide ? 160 : double.infinity,
                    child: _ParamTile(
                      icon: Icons.timer,
                      label: '运行时长',
                      value: '${420 + vehicleId.hashCode.abs() % 800}',
                      unit: 'h',
                      textTheme: textTheme,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // --- 辅助方法 ---

  /// 从实时快照列表中查找当前车辆的数据
  LiveVehicleSnapshot? _findCurrentSnapshot(AsyncValue<LiveVehicleSnapshots> async) {
    return async.whenOrNull(
      data: (list) {
        for (final s in list) {
          if (s.vehicleId == vehicleId) return s;
        }
        return null;
      },
    );
  }

  String _statusLabel(String status) {
    return switch (status) {
      'moving' => '行驶中',
      'idle' => '怠速等待',
      'loading' => '装载中',
      'dumping' => '卸载中',
      _ => status,
    };
  }

  Color _fuelColor(double fuel) {
    if (fuel > 30) return CatColors.online;
    if (fuel > 10) return CatColors.alertWarning;
    return CatColors.alertCritical;
  }

  String _fuelSubLabel(double fuel) {
    if (fuel > 30) return '油量充足';
    if (fuel > 10) return '建议加油';
    return '立即加油！';
  }

  String _engineTemp(LiveVehicleSnapshot? s) {
    // 从速度估算发动机温度（模拟数据 78~102°C）
    if (s == null) return '—';
    final base = 78 + (s.speed * 0.35).clamp(0, 24);
    // 如果状态是 idle/loading，温度偏高
    final hot = (s.status == 'idle' || s.status == 'loading') ? 5.0 : 0.0;
    return (base + hot).toStringAsFixed(0);
  }

  String _engineTempLabel(LiveVehicleSnapshot? s) {
    final t = int.tryParse(_engineTemp(s)) ?? 0;
    if (t > 95) return '温度偏高';
    if (t > 85) return '运行正常';
    if (t > 0) return '预热中';
    return '等待数据';
  }

  double _engineTempProgress(LiveVehicleSnapshot? s) {
    final t = int.tryParse(_engineTemp(s)) ?? 0;
    return (t - 70).clamp(0, 35) / 35;
  }

  Color _engineTempColor(LiveVehicleSnapshot? s) {
    final t = int.tryParse(_engineTemp(s)) ?? 0;
    if (t > 95) return CatColors.alertCritical;
    if (t > 85) return CatColors.online;
    return CatColors.alertWarning;
  }

  double _tirePressure(LiveVehicleSnapshot? s) {
    // 模拟胎压 2.2~3.0 bar
    if (s == null) return 0;
    return 2.2 + ((s.speed / 45) * 0.8).clamp(0, 0.8);
  }

  Widget _buildSkeletonColumn() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 160, height: 24, child: _LoadingShimmer()),
        SizedBox(height: 8),
        SizedBox(width: 120, height: 16, child: _LoadingShimmer()),
      ],
    );
  }
}

// --- 仪表卡片子组件 ---

/// 圆形仪表卡片
///
/// 模拟车载仪表盘风格，居中显示数值 + 单位，
/// 下方显示状态描述标签，外圈带彩色进度环。
class _GaugeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final String subLabel;
  final double progress;
  final Color color;
  final TextTheme textTheme;

  const _GaugeCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.subLabel,
    required this.progress,
    required this.color,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: CatColors.vehicleSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CatColors.vehicleBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 顶部标签
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 6),
              Text(label, style: textTheme.bodyMedium?.copyWith(color: CatColors.vehicleOnSurface.withAlpha(160))),
            ],
          ),
          const SizedBox(height: 16),
          // 进度圆环
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: progress.clamp(0, 1),
                    strokeWidth: 8,
                    backgroundColor: color.withAlpha(25),
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(value, style: textTheme.headlineMedium?.copyWith(color: CatColors.vehicleOnSurface, fontWeight: FontWeight.w800)),
                    Text(unit, style: textTheme.bodySmall?.copyWith(color: CatColors.vehicleOnSurface.withAlpha(120))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 状态标签
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withAlpha(60)),
            ),
            child: Text(subLabel, style: textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

/// 运行参数单行瓦片
class _ParamTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final TextTheme textTheme;

  const _ParamTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CatColors.vehicleBg.withAlpha(100),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CatColors.vehicleBorder.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: CatColors.vehicleOnSurface.withAlpha(140)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: textTheme.bodySmall?.copyWith(color: CatColors.vehicleOnSurface.withAlpha(120))),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(value, style: textTheme.titleMedium?.copyWith(color: CatColors.vehicleOnSurface, fontWeight: FontWeight.w700)),
                    if (unit.isNotEmpty) ...[
                      const SizedBox(width: 4),
                      Text(unit, style: textTheme.bodySmall?.copyWith(color: CatColors.vehicleOnSurface.withAlpha(140))),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 骨架屏占位闪烁条
class _LoadingShimmer extends StatelessWidget {
  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CatColors.vehicleBorder.withAlpha(80),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}