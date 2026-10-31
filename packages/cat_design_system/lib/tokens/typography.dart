import 'package:flutter/material.dart';

/// 设计系统排版令牌
///
/// 定义三端（车载/平板/手机）的全部字体规范和 [TextTheme]。
/// 车载端为大号深色主题字号（大屏远距离阅读），
/// 平板端为标准字号，手机端为紧凑字号。
///
/// 所有文本样式通过 [CatTypography] 引用，禁止业务代码硬编码字号。
class CatTypography {
  CatTypography._();

  // -- Font sizes --
  /// 说明文字 / 辅助信息
  static const double caption = 12.0;
  /// 正文（默认）
  static const double body = 14.0;
  /// 大号正文
  static const double bodyLarge = 16.0;
  /// 副标题
  static const double subtitle = 18.0;
  /// 标题
  static const double title = 20.0;
  /// 大标题
  static const double headline = 24.0;
  /// 展示文字（页面主标题）
  static const double display = 32.0;

  // -- Vehicle typography (dark, large screens) --
  /// 车载端深色主题排版（大屏，适合远距离阅读）
  static TextTheme vehicleTextTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 42, fontWeight: FontWeight.w700, letterSpacing: -1),
    headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  );

  // -- Tablet typography (standard size) --
  /// 平板端标准主题排版
  static TextTheme tabletTextTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -1),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
  );

  // -- Phone typography (compact) --
  /// 手机端紧凑主题排版（节省屏幕空间）
  static TextTheme phoneTextTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.5),
    labelMedium: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
  );
}