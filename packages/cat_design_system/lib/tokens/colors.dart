import 'package:flutter/material.dart';

/// 设计系统颜色令牌
///
/// 定义三端（车载/平板/手机）的全部语义色令牌，同时包含：
/// - 通用状态色（在线/离线/告警）
/// - 三套主题色板（车载深色高对比 / 平板标准浅色 / 手机紧凑浅色）
///
/// 所有组件通过 [CatColors] 引用颜色，而非硬编码。
class CatColors {
  CatColors._();

  // -- Vehicle (Dark / High Contrast) --
  static const vehicleBg = Color(0xFF0D1117);
  static const vehicleSurface = Color(0xFF161B22);
  static const vehicleSurfaceVariant = Color(0xFF21262D);
  static const vehiclePrimary = Color(0xFF58A6FF);
  static const vehicleSecondary = Color(0xFF3FB950);
  static const vehicleError = Color(0xFFF85149);
  static const vehicleWarning = Color(0xFFD29922);
  static const vehicleOnBg = Color(0xFFF0F6FC);
  static const vehicleOnSurface = Color(0xFFC9D1D9);
  static const vehicleBorder = Color(0xFF30363D);
  static const vehicleDivider = Color(0xFF21262D);

  // -- Tablet (Standard Light) --
  static const tabletBg = Color(0xFFF6F8FA);
  static const tabletSurface = Color(0xFFFFFFFF);
  static const tabletSurfaceVariant = Color(0xFFEBEDF0);
  static const tabletPrimary = Color(0xFF0969DA);
  static const tabletSecondary = Color(0xFF1A7F37);
  static const tabletError = Color(0xFFCF222E);
  static const tabletWarning = Color(0xFF9A6700);
  static const tabletOnBg = Color(0xFF1F2328);
  static const tabletOnSurface = Color(0xFF656D76);
  static const tabletBorder = Color(0xFFD0D7DE);
  static const tabletDivider = Color(0xFFEBEDF0);

  // -- Phone (Compact Light) --
  static const phoneBg = Color(0xFFFBFBFD);
  static const phoneSurface = Color(0xFFFFFFFF);
  static const phoneSurfaceVariant = Color(0xFFF2F2F7);
  static const phonePrimary = Color(0xFF007AFF);
  static const phoneSecondary = Color(0xFF34C759);
  static const phoneError = Color(0xFFFF3B30);
  static const phoneWarning = Color(0xFFFF9500);
  static const phoneOnBg = Color(0xFF1C1C1E);
  static const phoneOnSurface = Color(0xFF8E8E93);
  static const phoneBorder = Color(0xFFE5E5EA);
  static const phoneDivider = Color(0xFFF2F2F7);

  // -- Semantic colors (used in components) --
  static const online = Color(0xFF34C759);
  static const offline = Color(0xFF8E8E93);
  static const alertCritical = Color(0xFFFF3B30);
  static const alertWarning = Color(0xFFFF9500);
  static const alertInfo = Color(0xFF5AC8FA);
}