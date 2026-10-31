import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// 原生平台（iOS/Android/Desktop）数据库连接工厂
///
/// 在应用文档目录下创建 `cat_db/cat_app.db` 文件，
/// 使用 [NativeDatabase] 提供 Drift 所需的 [QueryExecutor]。
Future<QueryExecutor> createDatabaseConnection() async {
  final dir = await getApplicationDocumentsDirectory();
  final dbFolder = p.join(dir.path, 'cat_db');

  return LazyDatabase(() async {
    final folder = Directory(dbFolder);
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    return NativeDatabase(File(p.join(dbFolder, 'cat_app.db')));
  });
}