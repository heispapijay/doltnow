// Import required packages
import 'package:doltnow/app/core/utils/keys.dart'; // Import keys.dart which contains key constants
import 'package:get/get.dart'; // Import the GetX package for state management
import 'package:get_storage/get_storage.dart'; // Import GetStorage for persistent local storage

// Define the StorageService class
class StorageService extends GetxService {
  late GetStorage _box; // Declare a late instance of GetStorage

  // Initialize the storage service asynchronously
  Future<StorageService> init() async {
    _box = GetStorage(); // Initialize the GetStorage instance
    await _box.writeIfNull(
        taskKey, []); // Ensure 'taskKey' is initialized with an empty list
    //await _box.write(taskKey, []); // This line could be used to overwrite 'taskKey' with an empty list
    return this; // Return the initialized StorageService instance
  }

  // Read a value from storage and return it
  T read<T>(String key) {
    return _box.read(
        key); // Use GetStorage to read the value associated with the given key
  }

  // Write a value to storage
  void write(String key, dynamic value) async {
    await _box.write(key,
        value); // Use GetStorage to write a value associated with the given key
  }
}
