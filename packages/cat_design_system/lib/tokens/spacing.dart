/// 设计系统间距令牌
///
/// 基于 4pt 基准网格的间距体系，从 xs(4) 到 xxxl(48)。
/// 所有组件 padding/margin 统一由此令牌层取值，确保三端视觉一致性。
class CatSpacing {
  CatSpacing._();

  /// 最小间距 - 4pt
  static const xs = 4.0;
  /// 小间距 - 8pt（卡片内元素间隔）
  static const sm = 8.0;
  /// 中间距 - 12pt
  static const md = 12.0;
  /// 大间距 - 16pt（标准卡片 padding）
  static const lg = 16.0;
  /// 加大间距 - 24pt（页面 padding）
  static const xl = 24.0;
  /// 很大间距 - 32pt
  static const xxl = 32.0;
  /// 最大间距 - 48pt（区块间距）
  static const xxxl = 48.0;
}