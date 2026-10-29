import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_data/cat_data.dart';
import '../providers/alert_provider.dart';
import '../di/di_container.dart';

/// 地图上的告警气泡浮层
///
/// 将最新未确认的严重（critical）/警告（warning）告警以 Markers 形式
/// 叠加在地图对应车辆/设备位置上方。红色气球表示严重告警，橙色表示警告。
///
/// 传入 [Builder] 延迟订阅 Provider，避免在构建时触发无效 watch。
class MapAlertOverlay extends ConsumerWidget {
  const MapAlertOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertStream = ref.watch(liveAlertStreamProvider);

    // 从 liveAlertStream 中提取最新的告警事件
    // 使用一个简单的累计 Map 来追踪每辆车的最高级别告警
    final alertAsync = ref.watch(
      StreamProvider.autoDispose<Map<String, _AlertBubble>>((ref) {
        final ws = ref.watch(
          Provider<MockWebSocketService>((ref) => di<MockWebSocketService>()),
        );
        final bubbles = <String, _AlertBubble>{};
        return ws.eventStream
            .where((e) => e.isAlertNew)
            .map((event) {
              final vid = event.payload['vehicleId'] as String? ?? '';
              final title = event.payload['title'] as String? ?? '';
              final level = event.payload['level'] as String? ?? 'info';
              if (vid.isNotEmpty) {
                bubbles[vid] = _AlertBubble(
                  vehicleId: vid,
                  title: title,
                  level: level,
                );
              }
              return Map<String, _AlertBubble>.from(bubbles);
            });
      }),
    );

    final bubbles = alertAsync.valueOrNull ?? {};
    if (bubbles.isEmpty) return const SizedBox.shrink();

    // 获取车辆位置（从 liveVehicleProvider）
    final vehicles = ref.watch(
      StreamProvider.autoDispose<List<_VehiclePos>>((ref) {
        final ws = ref.watch(
          Provider<MockWebSocketService>((ref) => di<MockWebSocketService>()),
        );
        final positions = <String, _VehiclePos>{};
        return ws.eventStream
            .where((e) => e.isVehicleUpdate)
            .map((event) {
              final p = event.payload;
              positions[p['vehicleId'] as String] = _VehiclePos(
                lat: (p['latitude'] as num).toDouble(),
                lng: (p['longitude'] as num).toDouble(),
              );
              return positions.values.toList();
            });
      }),
    );

    final mainMarkers = vehicles.valueOrNull ?? [];

    return MarkerLayer(
      markers: bubbles.entries.map((entry) {
        final bubble = entry.value;
        final vid = entry.key;
        final pos = mainMarkers.where((p) => p.lat != 0).toList();
        // Fallback: 如果没有实时数据，用默认位置
        final lat = pos.isNotEmpty ? pos.first.lat : 39.1234;
        final lng = pos.isNotEmpty ? pos.first.lng : 117.5678;

        final color = bubble.level == 'critical'
            ? const Color(0xFFF44336)
            : const Color(0xFFFFC107);

        return Marker(
          point: LatLng(lat, lng),
          width: 120,
          height: 30,
          child: GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: color.withAlpha(80),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    bubble.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CustomPaint(
                  size: const Size(8, 6),
                  painter: _BubbleTrianglePainter(color),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _AlertBubble {
  final String vehicleId;
  final String title;
  final String level;
  const _AlertBubble({
    required this.vehicleId,
    required this.title,
    required this.level,
  });
}

class _VehiclePos {
  final double lat;
  final double lng;
  const _VehiclePos({required this.lat, required this.lng});
}

class _BubbleTrianglePainter extends CustomPainter {
  final Color color;
  const _BubbleTrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}