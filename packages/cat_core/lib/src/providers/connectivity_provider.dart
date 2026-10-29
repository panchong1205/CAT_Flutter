import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/connectivity_service.dart';
import '../di/di_container.dart';

/// 网络连接状态 Provider
///
/// 对外暴露 [ConnectivityService] 实例以及 [isOnline] 派生状态。
/// 所有 UI 组件通过此 Provider 获取实时网络状态。

/// 底层 ConnectivityService 单例 Provider
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = di<ConnectivityService>();
  ref.onDispose(() => service.dispose());
  return service;
});

/// 网络在线状态（派生 Provider，方便 watch）
final isOnlineProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  final controller = StreamController<bool>();
  controller.add(service.isOnline);
  final subscription = service.onConnectivityChanged.listen(controller.add);
  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });
  return controller.stream;
});