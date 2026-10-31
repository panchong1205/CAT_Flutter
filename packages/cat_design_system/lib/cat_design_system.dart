/// CAT Design System — 跨端统一设计语言
///
/// 提供：
/// - 设计令牌（颜色/间距/排版）
/// - 三端主题（车载/平板/手机）
/// - 原子组件（按钮/卡片/徽章/导航栏/AppBar）
/// - 布局工具（设备感知/响应式 Padding/自适应布局）
library cat_design_system;

export 'tokens/colors.dart';
export 'tokens/spacing.dart';
export 'tokens/typography.dart';
export 'theme/cat_themes.dart';
export 'components/cat_button.dart';
export 'components/cat_card.dart';
export 'components/cat_badge.dart';
export 'components/cat_app_bar.dart';
export 'components/cat_bottom_bar.dart';
export 'layout/device_class_provider.dart';
export 'layout/responsive_padding.dart';
export 'layout/adaptive_layout.dart';