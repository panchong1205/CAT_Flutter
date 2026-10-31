import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';

/// Web 平台数据库连接工厂
///
/// 使用 WebAssembly SQLite 在浏览器内存中运行数据库。
/// 数据仅存在于当前会话，刷新页面后重置（Demo 阶段适用）。
Future<QueryExecutor> createDatabaseConnection() async {
  final sqlite3 = await WasmSqlite3.loadFromUrl(
    Uri.parse('sqlite3.wasm'),
  );
  sqlite3.registerVirtualFileSystem(InMemoryFileSystem(), makeDefault: true);
  return WasmDatabase.inMemory(sqlite3);
}