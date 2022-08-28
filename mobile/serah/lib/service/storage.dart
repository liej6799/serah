import 'dart:typed_data';

import 'package:appwrite/models.dart';

import 'service.dart';

class StorageService {
  Future<FileList> getList() async {
    var service = Service();

    return service.getStorage().listFiles(
          bucketId: 'st_maybank',
        );
  }

  Future<File> getFile(String fileId) async {
    var service = Service();

    return service.getStorage().getFile(bucketId: 'st_maybank', fileId: fileId);
  }

  Future<Uint8List> getFilePreview(String fileId) async {
    var service = Service();

    return service
        .getStorage()
        .getFilePreview(bucketId: 'st_maybank', fileId: fileId);
  }

  Future<Uint8List> getFileDownload(String fileId) async {
    var service = Service();

    return service
        .getStorage()
        .getFileDownload(bucketId: 'st_maybank', fileId: fileId);
  }
}
