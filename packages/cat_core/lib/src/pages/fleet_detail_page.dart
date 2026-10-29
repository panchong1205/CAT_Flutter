import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import '../providers/fleet_provider.dart';
import '../widgets/vehicle_status_badge.dart';

/// 车辆详情页
///
/// 展示单个车辆的完整信息：基本数据、运行状态、位置信息、在线状态。
/// 通过 [vehicleId] 从 Provider 获取数据。
class FleetDetailPage extends ConsumerWidget {
  final String vehicleId;

  const FleetDetailPage({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleAsync = ref.watch(vehicleDetailProvider(vehicleId));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(vehicleAsync.valueOrNull?.name ?? '车辆详情'),
        centerTitle: true,
      ),
      body: vehicleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败: $e', style: const TextStyle(color: Colors.red))),
        data: (vehicle) {
          if (vehicle == null) {
            return const Center(child: Text('车辆不存在', style: TextStyle(color: Colors.grey)));
          }
          return _buildDetail(context, vehicle, textTheme);
        },
      ),
    );
  }

  Widget _buildDetail(BuildContext context, Vehicle v, TextTheme textTheme) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 700;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: isWide ? _buildWideLayout(v, textTheme) : _buildNarrowLayout(v, textTheme),
    );
  }

  /// 宽屏布局：左右双栏
  Widget _buildWideLayout(Vehicle v, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildInfoSection(v, textTheme)),
        const SizedBox(width: 24),
        Expanded(child: _buildStatusSection(v, textTheme)),
      ],
    );
  }

  /// 窄屏布局：单栏堆叠
  Widget _buildNarrowLayout(Vehicle v, TextTheme textTheme) {
    return Column(
      children: [
        _buildInfoSection(v, textTheme),
        const SizedBox(height: 20),
        _buildStatusSection(v, textTheme),
      ],
    );
  }

  /// 基本信息区域
  Widget _buildInfoSection(Vehicle v, TextTheme textTheme) {
    return CatCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            children: [
              Icon(_typeIcon(v.type), size: 28, color: CatColors.tabletPrimary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(v.name, style: textTheme.headlineMedium),
                    const SizedBox(height: 2),
                    Text(_typeLabel(v.type), style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  ],
                ),
              ),
              VehicleStatusBadge(status: v.status, online: v.online, fontSize: 11),
            ],
          ),
          const SizedBox(height: 24),
          _infoRow('车辆 ID', v.id),
          _infoRow('车辆类型', _typeLabel(v.type)),
          _infoRow('经度', v.longitude.toStringAsFixed(4)),
          _infoRow('纬度', v.latitude.toStringAsFixed(4)),
          _infoRow('海拔', '${v.altitude.toStringAsFixed(1)} 米'),
          _infoRow('最后更新', _formatTime(v.lastUpdated)),
        ],
      ),
    );
  }

  /// 运行状态区域
  Widget _buildStatusSection(Vehicle v, TextTheme textTheme) {
    final isMoving = v.status == 'moving';

    return Column(
      children: [
        // 运行指标卡片
        CatCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('运行状态', style: textTheme.titleMedium),
              const SizedBox(height: 20),

              // 速度仪表
              Center(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: v.speed / 60,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey.withAlpha(30),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isMoving ? CatColors.online : Colors.grey,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            v.speed.toStringAsFixed(1),
                            style: textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isMoving ? CatColors.online : Colors.grey,
                            ),
                          ),
                          Text('km/h', style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 油量
              _labelValueRow('油量', '${v.fuel.toStringAsFixed(1)}%'),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: v.fuel / 100,
                  minHeight: 8,
                  backgroundColor: Colors.grey.withAlpha(40),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    v.fuel < 20 ? CatColors.alertWarning : CatColors.online,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 在线状态
              _labelValueRow(
                '在线状态',
                v.online ? '在线' : '离线',
                valueColor: v.online ? CatColors.online : CatColors.offline,
              ),
              _labelValueRow('运行状态', _statusLabel(v.status), valueColor: _statusColor(v.status, v.online)),
              _labelValueRow('数据更新时间', _formatTime(v.lastUpdated)),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 位置信息卡片
        CatCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('位置信息', style: textTheme.titleMedium),
              const SizedBox(height: 16),
              _infoRow('经度', v.longitude.toStringAsFixed(6)),
              _infoRow('纬度', v.latitude.toStringAsFixed(6)),
              _infoRow('海拔', '${v.altitude.toStringAsFixed(1)} 米'),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: CatColors.alertCritical),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '矿区 C 区作业面',
                      style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // 辅助方法
  // ============================================================

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _labelValueRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

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
      case 'charging':
        return '充电中';
      default:
        return status;
    }
  }

  Color _statusColor(String status, bool online) {
    if (!online) return CatColors.offline;
    switch (status) {
      case 'moving':
        return CatColors.online;
      case 'loading':
      case 'dumping':
        return CatColors.alertWarning;
      default:
        return Colors.grey;
    }
  }

  String _formatTime(DateTime dt) {
    return '${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}