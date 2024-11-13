import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Mixin that helps checking if files exists
mixin FileExistChecker {
  /// Check if the file exists based on the app directory location
  Future<bool> fileExists(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();

    final path = "${dir.path}/$fileName";
    final file = File(path);
    return file.exists();
  }

  /// Return the file by the path provided
  Future<File> getFile(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();

    final path = '${dir.path}/$fileName';
    return File(path);
  }
}
