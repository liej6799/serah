import 'package:appwrite/appwrite.dart';

class Service {
  late Client client;
  late Storage storage;

  Service() {
    Client localClient = Client();
    Storage localStorage = Storage(localClient);
    localClient
        .setEndpoint('http://192.168.100.33/v1') // Your API Endpoint
        .setProject('62ef2658c28be8ff5d4b') // Your project ID
        .setSelfSigned(status: true);

    client = localClient;
    storage = localStorage;
  }

  Client getClient() {
    return client;
  }

  Storage getStorage() {
    return storage;
  }
}
