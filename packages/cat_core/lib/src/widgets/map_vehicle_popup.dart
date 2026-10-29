import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import '../providers/map_provider.dart';
import '../providers/fleet_provider.dart';

/// 地图上点击车辆后弹出的信息卡片
///
/// 展示车辆名称、状态、速度、油量等核心信息。
/// 底部提供「查看详情」「关闭」两个操作按钮。
class MapVehiclePopup extends ConsumerWidget {
  final String vehicleId;
  final VoidCallback onClose;

  const MapVehiclePopup({
    super.key,
    required this.vehicleId,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleAsync = ref.watch(vehicleDetailProvider(vehicleId));

    return vehicleAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (vehicle) {
        if (vehicle == null) return const SizedBox.shrink();

        // 合并 WebSocket 实时数据
        final mapVehicles = ref.watch(liveVehicleMapProvider).valueOrNull ?? [];
        final live = mapVehicles.where((v) => v.vehicleId == vehicleId);
        final speed = live.isNotEmpty ? live.first.speed : vehicle.speed;
        final fuel = live.isNotEmpty ? live.first.fuel : vehicle.fuel;
        final online = live.isNotEmpty ? live.first.online : vehicle.online;
        final status = live.isNotEmpty ? live.first.status : vehicle.status;

        return Card(
          elevation: 6,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题行
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: online ? CatColors.online : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        vehicle.name,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                    ),
                    IconButton(
                      onPressed: onClose,
                      icon: const Icon(Icons.close, size: 16),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const Divider(height: 12),

                // 状态信息
                Row(
                  children: [
                    _InfoChip(label: '速度', value: '${speed.toStringAsFixed(1)} km/h'),
                    const SizedBox(width: 12),
                    _InfoChip(label: '油量', value: '${fuel.toStringAsFixed(0)}%'),
                    const SizedBox(width: 12),
                    _InfoChip(label: '状态', value: _statusText(status)),
                  ],
                ),
                const SizedBox(height: 8),

                // 类型 + 在线状态
                Row(
                  children: [
                    _InfoChip(label: '类型', value: _typeText(vehicle.type)),
                    const SizedBox(width: 12),
                    _InfoChip(
                      label: '连接',
                      value: online ? '在线' : '离线',
                      color: online ? CatColors.online : Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static String _statusText(String status) {
    return switch (status) {
      'moving' => '行驶中',
      'idle' => '怠速',
      'loading' => '装载中',
      'dumping' => '卸载中',
      'charging' => '充电中',
      _ => status,
    };
  }

  static String _typeText(String type) {
    return switch (type) {
      'mining_truck' => '矿卡',
      'excavator' => '挖掘机',
      'bulldozer' => '推土机',
      _ => type,
    };
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _InfoChip({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}