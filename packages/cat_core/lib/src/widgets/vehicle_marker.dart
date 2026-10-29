import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../providers/map_provider.dart';

/// 地图上的车辆位置标记
///
/// 带方向箭头和状态颜色（绿=在线，黄=低油量告警，红=严重，灰=离线）。
/// 选中状态下放大并显示脉冲动画。
class VehicleMarker extends Marker {
  VehicleMarker({
    super.key,
    required MapVehicleSnapshot vehicle,
    required bool isSelected,
    required VoidCallback onTap,
  }) : super(
          point: LatLng(vehicle.latitude, vehicle.longitude),
          width: isSelected ? 48 : 36,
          height: isSelected ? 48 : 36,
          child: _VehicleMarkerWidget(
            vehicle: vehicle,
            isSelected: isSelected,
            onTap: onTap,
          ),
        );
}

class _VehicleMarkerWidget extends StatefulWidget {
  final MapVehicleSnapshot vehicle;
  final bool isSelected;
  final VoidCallback onTap;

  const _VehicleMarkerWidget({
    required this.vehicle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_VehicleMarkerWidget> createState() => _VehicleMarkerWidgetState();
}

class _VehicleMarkerWidgetState extends State<_VehicleMarkerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    if (widget.isSelected) _pulseController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant _VehicleMarkerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isSelected && _pulseController.isAnimating) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = Color(statusColorForVehicle(widget.vehicle).value);

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final pulse = widget.isSelected
              ? 1.0 + 0.15 * _pulseController.value
              : 1.0;

          return Transform.scale(
            scale: pulse,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 方向箭头 + 车辆图标
                Icon(
                  Icons.arrow_drop_up,
                  color: statusColor,
                  size: widget.isSelected ? 20 : 14,
                ),
                // 圆形标记主体
                Container(
                  width: widget.isSelected ? 32 : 24,
                  height: widget.isSelected ? 32 : 24,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: widget.isSelected ? 2.5 : 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: statusColor.withAlpha(100),
                        blurRadius: widget.isSelected ? 12 : 4,
                        spreadRadius: widget.isSelected ? 2 : 0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.directions_car_filled,
                    color: Colors.white,
                    size: 14,
                  ),
                ),

                // 选中时显示名称标签
                if (widget.isSelected)
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.vehicle.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}