import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/mine_map_widget.dart';

/// 车载端全屏地图模式
///
/// 左侧显示车辆列表，右侧全屏地图。
/// 通过 SystemChrome 隐藏状态栏实现沉浸式体验。
class VehicleFullscreenMapPage extends StatelessWidget {
  const VehicleFullscreenMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const MineMapWidget(showFleetPanel: true),

            // 右上角关闭按钮
            Positioned(
              top: 12,
              right: 12,
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.close, size: 20, color: Colors.black87),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}