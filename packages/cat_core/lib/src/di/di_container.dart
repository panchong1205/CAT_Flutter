import 'package:get_it/get_it.dart';
import 'package:cat_domain/cat_domain.dart';
import 'package:cat_data/cat_data.dart';
import '../network/connectivity_service.dart';

final GetIt di = GetIt.instance;

Future<void> initializeDependencies() async {
  // HTTP 客户端（Mock 拦截器）
  final httpClient = CatHttpClient(interceptors: [MockInterceptor()]);
  di.registerLazySingleton<CatHttpClient>(() => httpClient);

  // Drift 数据库
  final appDatabase = AppDatabase(executor: await createDatabaseConnection());
  di.registerLazySingleton<AppDatabase>(() => appDatabase);

  // Repository 实现（离线优先）
  di.registerLazySingleton<FleetRepository>(
    () => FleetRepoImpl(db: appDatabase, httpClient: httpClient),
  );
  di.registerLazySingleton<MissionRepository>(
    () => MissionRepoImpl(db: appDatabase, httpClient: httpClient),
  );
  di.registerLazySingleton<AlertRepository>(
    () => AlertRepoImpl(db: appDatabase, httpClient: httpClient),
  );

  // WebSocket Mock 实时推送服务
  final wsService = MockWebSocketService();
  di.registerLazySingleton<MockWebSocketService>(() => wsService);

  // 网络连接监测服务
  final connectivityService = ConnectivityService();
  di.registerLazySingleton<ConnectivityService>(() => connectivityService);

  // Agent 聊天 Repository
  final agentRepository = AgentRepositoryImpl();
  di.registerLazySingleton<AgentRepositoryImpl>(() => agentRepository);

  // 巡检 Repository
  di.registerLazySingleton<PatrolRepository>(() => PatrolRepoImpl());

  // 审批 Repository
  di.registerLazySingleton<ApprovalRepository>(() => ApprovalRepoImpl());

  // 离线同步引擎
  final syncEngine = SyncEngine(db: appDatabase, httpClient: httpClient);
  syncEngine.bindToConnectivity(connectivityService.onConnectivityChanged);
  di.registerLazySingleton<SyncEngine>(() => syncEngine);
}