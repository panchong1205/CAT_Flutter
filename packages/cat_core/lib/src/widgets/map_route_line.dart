import 'dart:math';
import 'package:flutter/material.dart';

/// 地图上的任务路线绘制
///
/// 使用 [CustomPainter] 在地图上叠加几条模拟的矿区运输路线。
/// Actual route data 应从 Mission 实体动态加载，当前为 Mock 静态绘制。
class MapRouteLine extends CustomPainter {
  /// Mock 路线端点（矿区坐标范围内）
  static final _routes = [
    ([39.1234, 117.5678], [39.1278, 117.5734]),
    ([39.1256, 117.5710], [39.1290, 117.5750]),
    ([39.1210, 117.5650], [39.1278, 117.5734]),
  ];

  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  /// 在给定 [canvas] 和 [positions] 上绘制路线
  ///
  /// [offsets] 为像素坐标列表（由调用方完成经纬度→像素转换）
  static void drawRouteOnCanvas(
    Canvas canvas,
    List<Offset> offsets, {
    Color color = const Color(0xFF2196F3),
    double width = 3.0,
  }) {
    if (offsets.length < 2) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // 虚线效果
    final dashPaint = Paint()
      ..color = color.withAlpha(180)
      ..strokeWidth = width + 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // 先画底层加粗虚线（半透明）
    for (int i = 0; i < offsets.length - 1; i++) {
      final start = offsets[i];
      final end = offsets[i + 1];
      _drawDashedLine(canvas, start, end, dashPaint, 8, 4);
    }

    // 再画上层实线
    for (int i = 0; i < offsets.length - 1; i++) {
      canvas.drawLine(offsets[i], offsets[i + 1], paint);
    }

    // 起点圆点
    canvas.drawCircle(offsets.first, 6, Paint()..color = const Color(0xFF4CAF50));
    // 终点标记
    canvas.drawCircle(
      offsets.last,
      6,
      Paint()
        ..color = const Color(0xFFF44336)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  /// 绘制虚线
  static void _drawDashedLine(
    Canvas canvas,
    Offset start,
    Offset end,
    Paint paint,
    double dashLength,
    double gapLength,
  ) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = sqrt(dx * dx + dy * dy);
    if (distance == 0) return;

    final unitX = dx / distance;
    final unitY = dy / distance;
    double drawn = 0;

    while (drawn < distance) {
      final segmentEnd = min(drawn + dashLength, distance);
      canvas.drawLine(
        Offset(start.dx + unitX * drawn, start.dy + unitY * drawn),
        Offset(start.dx + unitX * segmentEnd, start.dy + unitY * segmentEnd),
        paint,
      );
      drawn = segmentEnd + gapLength;
    }
  }
}