// import 'dart:io';

// import 'package:marcahoras3/utils/files/file_exist_checker.dart';
// import 'package:marcahoras3/utils/files/file_utils_contract.dart';
// import 'package:path_provider/path_provider.dart';

// class FileUtils with FileExistChecker implements FileUtilsContract {
//   @override
//   Future<String> saveBytes({
//     required String fileName,
//     required List<int> bytes,
//   }) async {
//     final dir = await getApplicationDocumentsDirectory();
//     final path = '${dir.path}/$fileName';
//     await File(path).writeAsBytes(bytes);

//     return path;
//   }
// }
