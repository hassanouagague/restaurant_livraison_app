import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class StorageController extends GetxController {
  GetStorage storage = GetStorage();

  // set data to local storage
  void setData({required data, required String key}) =>
      storage.write(key, data);
  // Get data to local storage
  getData({required String key}) {
    var data = storage.read(key);
    return data;
  }
  // Delete data to local storage
  Future<void> updateData({required data, required String key}) async {
    await deleteData(key:key);
    setData(data: data, key:key);
  }
  // Delete data to local storage
  Future<void> deleteData({required String key}) async {
    await storage.remove(key);
  }

  // check if has value with key or not
  bool hasData({required String key}) {
    return storage.hasData(key);
  }

  // fromJson({required UserModel user}) {
  //   setData(data: user.id!, key: "id");
  //   setData(data: user.email!, key: "email");
  //   // setData(
  //   //   data: "Password",key:json['id']
  //   // );
  // }
}
