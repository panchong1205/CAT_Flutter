import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import 'vehicle_status_badge.dart';

/// 车辆信息卡片组件（可复用）
///
/// 在车队列表网格/列表中展示单辆车辆的摘要信息，
/// 包含车辆名称、类型、状态 Badge、速度、油量和在线状态指示灯。
class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback? onTap;

  const VehicleCard({super.key, required this.vehicle, this.onTap});

  String _typeLabel(String type) {
    switch (type) {
      case 'mining_truck':
        return '矿用卡车';
      case 'excavator':
        return '挖掘机';
      case 'bulldozer':
        return '推土机';
      default:
        return type;
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'mining_truck':
        return Icons.local_shipping;
      case 'excavator':
        return Icons.construction;
      case 'bulldozer':
        return Icons.agriculture;
      default:
        return Icons.precision_manufacturing;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMoving = vehicle.status == 'moving';

    return CatCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 顶部：车型图标 + 名称 + 在线指示灯
          Row(
            children: [
              Icon(_typeIcon(vehicle.type), size: 18, color: CatColors.tabletPrimary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  vehicle.name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: vehicle.online ? CatColors.online : CatColors.offline,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 中间：类型标签 + 状态 Badge
          Row(
            children: [
              Text(
                _typeLabel(vehicle.type),
                style: textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(width: 8),
              VehicleStatusBadge(status: vehicle.status, online: vehicle.online),
            ],
          ),
          const SizedBox(height: 10),

          // 底部：速度 + 油量 进度条
          Row(
            children: [
              // 速度
              const Icon(Icons.speed, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${vehicle.speed.toStringAsFixed(1)} km/h',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isMoving ? CatColors.online : Colors.grey,
                ),
              ),
              const SizedBox(width: 14),

              // 油量
              const Icon(Icons.local_gas_station, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      '${vehicle.fuel.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: vehicle.fuel < 20 ? CatColors.alertWarning : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: vehicle.fuel / 100,
                          minHeight: 3,
                          backgroundColor: Colors.grey.withAlpha(40),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            vehicle.fuel < 20 ? CatColors.alertWarning : CatColors.online,
                          ),
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
    );
  }
}