import 'package:get_storage/get_storage.dart';

class FLocalStorage {
  // Single instance
  static FLocalStorage? _instance;

  FLocalStorage._internal();

  late final GetStorage _storage;

  // To avoid storing null values to the local storage
  factory FLocalStorage.instance() {
    _instance ??= FLocalStorage._internal();
    return _instance!;
  }

  // Initialize the local storage
  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = FLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  // static final FLocalStorage _instance = FLocalStorage._internal();
  // factory FLocalStorage(){
  //   return _instance;
  // }

  // Generic method to save data
  Future<void> writeData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }

  /// *** *** *** *** *** Example *** *** *** *** *** ///

// LocalStorage localStorage = LocalStorage();
//
// // Save data
// localStorage.saveData('username', 'JohnDoe');
//
// // Read data
// String? username = localStorage.readData<String>('username');
// print('Username: $username'); // Output: Username: JohnDoe
//
// // Remove data
// localStorage.removeData('username');
//
// // Clear all data
// localStorage.clearAll();
}
