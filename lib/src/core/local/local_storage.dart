import 'package:get_storage/get_storage.dart';
import 'package:frontend/src/core/services/logger/logger_service.dart';

/*
DO NOT FORGET TO INITIALIZE GET STORAGE INSIDE OF MAIN

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}
*/

class LocalStorageService {
  // Singleton instance
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  // Instance of GetStorage
  final GetStorage _storage = GetStorage();

  /// Save data
  Future<void> write(String key, dynamic value) async {
    try {
      await _storage.write(key, value);
      logger.info('Data saved successfully for key: $key');
    } catch (e) {
      logger.error('Error saving data for key "$key": $e');
    }
  }

  /// Retrieve data
  T? read<T>(String key) {
    try {
      final value = _storage.read<T>(key);
      logger.info('Data retrieved successfully for key: $key');
      return value;
    } catch (e) {
      logger.error('Error retrieving data for key "$key": $e');
      return null;
    }
  }

  /// Delete data
  Future<void> remove(String key) async {
    try {
      await _storage.remove(key);
      logger.info('Data deleted successfully for key: $key');
    } catch (e) {
      logger.error('Error deleting data for key "$key": $e');
    }
  }

  /// Check if data exists for a given key
  bool check(String key) {
    try {
      final exists = _storage.hasData(key);
      logger.info('Data existence check for key "$key": $exists');
      return exists;
    } catch (e) {
      logger.error('Error checking data existence for key "$key": $e');
      return false;
    }
  }

  /// Clear all stored data
  Future<void> clearAll() async {
    try {
      await _storage.erase();
      logger.info('All data cleared from storage.');
    } catch (e) {
      logger.error('Error clearing storage: $e');
    }
  }
}
