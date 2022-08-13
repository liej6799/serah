import 'service.dart';

class StorageService {
  void getList() {
    var service = Service();

    Future result = service.getStorage().listFiles(
          bucketId: 'st_maybank',
        );

    result.then((response) {
      print("result : ");
      print(response);
    }).catchError((error) {
      print(error);
    });
  }
}
