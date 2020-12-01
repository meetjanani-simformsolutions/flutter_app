import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageDemo {
  final storage = FlutterSecureStorage();

  Future writeSecureData(String key, dynamic value) async {
    var writeData = await storage.write(key: key, value: value);
    return writeData;
  }

  Future readSecureData(String key) async {
    var readData = await storage.read(key: key);
    return readData;
  }

  Future deleteSecureData(String key) async {
    var deleteData = await storage.delete(key: key);
    return deleteData;
  }
}
