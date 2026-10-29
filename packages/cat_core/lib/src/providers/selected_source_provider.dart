import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 通知中心跳转选中的来源 ID
///
/// 通知中心点击卡片时写入 sourceId，
/// 目标页面 watch 到变化后自动打开对应详情。
final selectedSourceIdProvider = StateProvider<String?>((ref) => null);