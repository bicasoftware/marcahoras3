import 'dart:io';

abstract class FileUtilsContract {
  Future<String> saveBytes({
    required String fileName,
    required List<int> bytes,
  });

  Future<bool> fileExists(String filename);

  Future<File> getFile(String fileName);
}
