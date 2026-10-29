import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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