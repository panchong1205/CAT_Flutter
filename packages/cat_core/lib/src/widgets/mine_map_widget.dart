import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_data/cat_data.dart';
import '../di/di_container.dart';
import '../providers/map_provider.dart';
import '../providers/alert_provider.dart';
import 'vehicle_marker.dart';
import 'map_vehicle_popup.dart';

/// 矿区地图基础组件
///
/// 基于 [FlutterMap] + OpenStreetMap 瓦片，叠加车辆位置标记、告警气泡、
/// 任务路线、点击交互弹窗。通过 WebSocket 驱动车辆标记实时更新。
///
/// 支持 [showFleetPanel] 在左侧嵌入车辆列表面板（车载端全屏模式使用）。
class MineMapWidget extends ConsumerStatefulWidget {
  /// 是否紧凑模式（用于车载端与任务面板共享空间时缩小地图控制）
  final bool compact;

  /// 是否显示顶部工具栏（搜索/筛选等）
  final bool showToolbar;

  /// 是否在内部渲染车辆列表侧边栏
  final bool showFleetPanel;

  const MineMapWidget({
    super.key,
    this.compact = false,
    this.showToolbar = false,
    this.showFleetPanel = false,
  });

  @override
  ConsumerState<MineMapWidget> createState() => _MineMapWidgetState();
}

class _MineMapWidgetState extends ConsumerState<MineMapWidget> {
  /// OpenStreetMap 中心点（矿区所在区域，对应 Mock 数据的坐标范围）
  static const _mineCenter = LatLng(39.1234, 117.571);
  static const _defaultZoom = 13.0;

  final _mapController = MapController();

  /// 当前选中的车辆 ID（用于点击弹窗）
  String? _selectedMarkerId;

  @override
  Widget build(BuildContext context) {
    final vehiclesAsync = ref.watch(liveVehicleMapProvider);
    final textTheme = Theme.of(context).textTheme;

    final mapBody = vehiclesAsync.when(
      loading: () => _buildMap(const []),
      error: (_, __) => _buildMap(const []),
      data: (vehicles) => _buildMap(vehicles),
    );

    if (!widget.showFleetPanel) return mapBody;

    // 车载端全屏模式：左侧车辆列表面板 + 右侧地图
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: _buildFleetSidePanel(vehiclesAsync, textTheme),
        ),
        Expanded(child: mapBody),
      ],
    );
  }

  Widget _buildMap(List<MapVehicleSnapshot> vehicles) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _mineCenter,
            initialZoom: _defaultZoom,
            minZoom: 10,
            maxZoom: 18,
            onTap: (_, __) => _clearSelection(),
          ),
          children: [
            // OpenStreetMap 瓦片
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.cat.flutter',
            ),

            // 车辆位置 + 告警气泡标记层
            MarkerLayer(
              markers: [
                ..._buildMarkers(vehicles),
                ..._buildAlertBubbles(),
              ],
            ),
          ],
        ),

        // 点击车辆后的弹出信息卡片
        if (_selectedMarkerId != null)
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: MapVehiclePopup(
              vehicleId: _selectedMarkerId!,
              onClose: _clearSelection,
            ),
          ),

        // 左上角缩放控件
        if (!widget.compact)
          Positioned(
            top: 12,
            right: 12,
            child: Column(
              children: [
                _ZoomButton(
                  icon: Icons.add,
                  onTap: () => _zoomIn(),
                ),
                const SizedBox(height: 4),
                _ZoomButton(
                  icon: Icons.remove,
                  onTap: () => _zoomOut(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// 构建车辆标记列表
  List<Marker> _buildMarkers(List<MapVehicleSnapshot> vehicles) {
    return vehicles.map((v) {
      final isSelected = v.vehicleId == _selectedMarkerId;
      return VehicleMarker(
        vehicle: v,
        isSelected: isSelected,
        onTap: () => _onVehicleTap(v),
      );
    }).toList();
  }

  void _onVehicleTap(MapVehicleSnapshot vehicle) {
    setState(() {
      _selectedMarkerId = _selectedMarkerId == vehicle.vehicleId
          ? null
          : vehicle.vehicleId;
    });
    ref.read(selectedVehicleIdProvider.notifier).state =
        _selectedMarkerId;
  }

  void _clearSelection() {
    setState(() => _selectedMarkerId = null);
    ref.read(selectedVehicleIdProvider.notifier).state = null;
  }

  void _zoomIn() => _mapController.move(
      _mapController.camera.center, _mapController.camera.zoom + 1);
  void _zoomOut() => _mapController.move(
      _mapController.camera.center, _mapController.camera.zoom - 1);

  /// 构建告警气泡标记（地图上叠加在车辆上方的红色/橙色标签）
  List<Marker> _buildAlertBubbles() {
    final alertAsync = ref.watch(liveAlertStreamProvider);
    final event = alertAsync.valueOrNull;
    if (event == null) return [];

    final vid = event.payload['vehicleId'] as String? ?? '';
    final title = event.payload['title'] as String? ?? '';
    final level = event.payload['level'] as String? ?? 'info';
    if (vid.isEmpty) return [];

    // 从车辆快照中获取最新位置
    final vehicles = ref.watch(liveVehicleMapProvider).valueOrNull ?? [];
    final vehicle = vehicles.where((v) => v.vehicleId == vid);
    final lat = vehicle.isNotEmpty ? vehicle.first.latitude : 39.1234;
    final lng = vehicle.isNotEmpty ? vehicle.first.longitude : 117.5678;

    final color = level == 'critical'
        ? const Color(0xFFF44336)
        : const Color(0xFFFFC107);

    return [
      Marker(
        point: LatLng(lat + 0.001, lng),
        width: title.length * 10.0,
        height: 24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  /// 左侧车辆列表面板（车载端全屏模式专用）
  Widget _buildFleetSidePanel(
    AsyncValue<List<MapVehicleSnapshot>> vehiclesAsync,
    TextTheme textTheme,
  ) {
    return Container(
      color: CatColors.vehicleSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('车辆列表', style: textTheme.titleMedium),
          ),
          const Divider(height: 1),
          Expanded(
            child: vehiclesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('加载失败')),
              data: (vehicles) => ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (_, i) => _buildVehicleItem(vehicles[i], textTheme),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleItem(MapVehicleSnapshot v, TextTheme textTheme) {
    final selectedId = ref.watch(selectedVehicleIdProvider);
    final isSelected = v.vehicleId == selectedId;
    final color = Color(statusColorForVehicle(v).value);

    return InkWell(
      onTap: () {
        ref.read(selectedVehicleIdProvider.notifier).state =
            isSelected ? null : v.vehicleId;
        setState(() {
          _selectedMarkerId = isSelected ? null : v.vehicleId;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: isSelected ? color.withAlpha(30) : null,
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(v.name, style: textTheme.bodyMedium),
                  Text(
                    '${v.speed.toStringAsFixed(1)} km/h · 油量 ${v.fuel.toStringAsFixed(0)}%',
                    style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              v.online ? '在线' : '离线',
              style: TextStyle(
                fontSize: 11,
                color: v.online ? CatColors.online : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 缩放按钮
class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ZoomButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: Colors.black87),
        ),
      ),
    );
  }
}