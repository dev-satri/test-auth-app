// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:frontend/src/core/services/logger/logger_service.dart';

// class SecureStorageService {
//   // Singleton instance
//   static final SecureStorageService _instance =
//       SecureStorageService._internal();

//   factory SecureStorageService() => _instance;

//   SecureStorageService._internal();

//   // Instance of FlutterSecureStorage
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   /// Save data securely
//   Future<void> write(String key, String value) async {
//     try {
//       await _secureStorage.write(key: key, value: value);
//       logger.info('Data saved successfully for key: $key');
//     } catch (e) {
//       logger.error('Error saving data for key "$key": $e');
//     }
//   }

//   /// Retrieve data securely
//   Future<String?> read(String key) async {
//     try {
//       final value = await _secureStorage.read(key: key);
//       logger.info('Data retrieved successfully for key: $key');
//       return value;
//     } catch (e) {
//       logger.error('Error retrieving data for key "$key": $e');
//       return null;
//     }
//   }

//   /// Delete data securely
//   Future<void> delete(String key) async {
//     try {
//       await _secureStorage.delete(key: key);
//       logger.info('Data deleted successfully for key: $key');
//     } catch (e) {
//       logger.error('Error deleting data for key "$key": $e');
//     }
//   }

//   /// Check if data exists for a given key
//   Future<bool> check(String key) async {
//     try {
//       final value = await _secureStorage.read(key: key);
//       final exists = value != null;
//       logger.info('Data existence check for key "$key": $exists');
//       return exists;
//     } catch (e) {
//       logger.error('Error checking data existence for key "$key": $e');
//       return false;
//     }
//   }
// }
