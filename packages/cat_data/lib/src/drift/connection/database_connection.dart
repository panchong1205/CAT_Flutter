/// 跨平台数据库连接入口
///
/// 根据编译平台自动选择原生（文件）或 Web（内存）数据库连接。
export 'database_connection_web.dart'
    if (dart.library.io) 'database_connection_io.dart';