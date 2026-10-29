import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import '../providers/fleet_provider.dart';
import '../widgets/vehicle_card.dart';
import 'fleet_detail_page.dart';

/// 车队设备列表页面
///
/// 自适应布局：
/// - 平板宽屏（>900px）：3 列网格
/// - 平板常规（600-900px）：2 列网格
/// - 手机窄屏（<600px）：单列列表
///
/// 支持按车辆名称搜索、按状态/类型/在线状态筛选。
class FleetListPage extends ConsumerStatefulWidget {
  const FleetListPage({super.key});

  @override
  ConsumerState<FleetListPage> createState() => _FleetListPageState();
}

class _FleetListPageState extends ConsumerState<FleetListPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _statusFilter = 'all';
  String _typeFilter = 'all';
  String _onlineFilter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vehiclesAsync = ref.watch(fleetVehiclesProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 900 ? 3 : (screenWidth > 600 ? 2 : 1);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // 顶部标题 + 搜索/筛选栏
        _buildHeader(textTheme),
        // 车辆列表区域
        Expanded(
          child: vehiclesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('加载失败: $e', style: const TextStyle(color: Colors.red))),
            data: (vehicles) => _buildVehicleList(vehicles, crossAxisCount),
          ),
        ),
      ],
    );
  }

  /// 标题栏 + 搜索 + 筛选
  Widget _buildHeader(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('车队设备', style: textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text('共 8 辆矿卡 / 挖掘机 / 推土机在线运行', style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
          const SizedBox(height: 12),

          // 搜索框
          SizedBox(
            height: 36,
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: '搜索车辆名称...',
                hintStyle: const TextStyle(fontSize: 13),
                prefixIcon: const Icon(Icons.search, size: 18),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 16),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.withAlpha(80))),
                filled: true,
                fillColor: Colors.grey.withAlpha(10),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // 筛选 Chips（水平滚动）
          SizedBox(
            height: 32,
            child: Row(
              children: [
                // 状态筛选
                _buildFilterChip('全部', 'all', _statusFilter, (v) => setState(() => _statusFilter = v)),
                const SizedBox(width: 6),
                _buildFilterChip('行驶中', 'moving', _statusFilter, (v) => setState(() => _statusFilter = v)),
                const SizedBox(width: 6),
                _buildFilterChip('空闲', 'idle', _statusFilter, (v) => setState(() => _statusFilter = v)),
                const SizedBox(width: 6),
                _buildFilterChip('装载中', 'loading', _statusFilter, (v) => setState(() => _statusFilter = v)),
                const SizedBox(width: 6),
                _buildFilterChip('卸料中', 'dumping', _statusFilter, (v) => setState(() => _statusFilter = v)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 32,
            child: Row(
              children: [
                // 类型筛选
                _buildFilterChip('全部', 'all', _typeFilter, (v) => setState(() => _typeFilter = v)),
                const SizedBox(width: 6),
                _buildFilterChip('矿卡', 'mining_truck', _typeFilter, (v) => setState(() => _typeFilter = v)),
                const SizedBox(width: 6),
                _buildFilterChip('挖掘机', 'excavator', _typeFilter, (v) => setState(() => _typeFilter = v)),
                const SizedBox(width: 6),
                _buildFilterChip('推土机', 'bulldozer', _typeFilter, (v) => setState(() => _typeFilter = v)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 32,
            child: Row(
              children: [
                // 在线筛选
                _buildFilterChip('全部', 'all', _onlineFilter, (v) => setState(() => _onlineFilter = v)),
                const SizedBox(width: 6),
                _buildFilterChip('在线', 'online', _onlineFilter, (v) => setState(() => _onlineFilter = v)),
                const SizedBox(width: 6),
                _buildFilterChip('离线', 'offline', _onlineFilter, (v) => setState(() => _onlineFilter = v)),
              ],
            ),
          ),

        ],
      ),
    );
  }

  /// 筛选 Chip 组件
  Widget _buildFilterChip(String label, String value, String currentValue, ValueChanged<String> onSelected) {
    final selected = value == currentValue;
    return GestureDetector(
      onTap: () => onSelected(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? CatColors.tabletPrimary : Colors.grey.withAlpha(15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? CatColors.tabletPrimary : Colors.grey.withAlpha(60), width: 0.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  /// 车辆列表主体
  Widget _buildVehicleList(List<Vehicle> vehicles, int crossAxisCount) {
    // 筛选逻辑
    var filtered = vehicles.where((v) {
      if (_searchQuery.isNotEmpty && !v.name.toLowerCase().contains(_searchQuery.toLowerCase())) return false;
      if (_statusFilter != 'all' && v.status != _statusFilter) return false;
      if (_typeFilter != 'all' && v.type != _typeFilter) return false;
      if (_onlineFilter == 'online' && !v.online) return false;
      if (_onlineFilter == 'offline' && v.online) return false;
      return true;
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text('没有找到匹配的车辆', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    final padding = const EdgeInsets.all(20);

    if (crossAxisCount == 1) {
      // 手机端：单列列表
      return ListView.builder(
        padding: padding,
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: VehicleCard(
              vehicle: filtered[index],
              onTap: () => _navigateToDetail(filtered[index].id),
            ),
          );
        },
      );
    }

    // 平板 / 车载端：网格布局
    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1.4,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return VehicleCard(
          vehicle: filtered[index],
          onTap: () => _navigateToDetail(filtered[index].id),
        );
      },
    );
  }

  void _navigateToDetail(String vehicleId) {
    // 使用 Navigator.of(context, rootNavigator: true) 推送详情页（覆盖 Shell）
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FleetDetailPage(vehicleId: vehicleId),
      ),
    );
  }
}