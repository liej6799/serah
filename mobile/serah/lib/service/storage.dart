import 'package:appwrite/models.dart';

import 'service.dart';

class StorageService {
  Future<FileList> getList() async {
    return Service().getStorage().listFiles(
          bucketId: 'st_maybank',
        );
  }
}
