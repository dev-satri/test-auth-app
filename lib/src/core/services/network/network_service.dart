import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:frontend/src/core/local/local_storage.dart';
import 'package:frontend/src/core/services/logger/logger_service.dart';
import 'package:frontend/src/core/local/storage_keys.dart';
// import 'package:frontend/src/core/local/secure_storage.dart';
import 'package:frontend/src/core/services/network/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'api_failure.dart';

class NetworkService {
  late final http.Client _client;
  // final _storageService = SecureStorageService();
  final _localStorage = LocalStorageService();
  String? _token;
  bool _disposed = false;
  NetworkService() : _client = http.Client() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    _token ??= _localStorage.read(StorageKeys.authToken);
  }

  Future<void> setToken(String token) async {
    _token = token;
    await _localStorage.write(StorageKeys.authToken, token);
  }

  Future<void> clearToken() async {
    _token = null;
    await _localStorage.remove(StorageKeys.authToken);
  }

  Map<String, String> _createHeaders(Map<String, String>? headers) {
    return {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
      ...?headers,
    };
  }

  String _encodeBody(dynamic body) {
    return jsonEncode(body);
  }

  Future<Either<Failure, T>> get<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    Duration timeout = const Duration(seconds: 10),
    int maxRetries = 3,
  }) async {
    await _loadToken();
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    ).replace(queryParameters: queryParams);
    return _sendRequest<T>(
      () => _client.get(uri, headers: _createHeaders(headers)),
      timeout,
      maxRetries,
    );
  }

  Future<Either<Failure, T>> post<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    dynamic body,
    Duration timeout = const Duration(seconds: 10),
    int maxRetries = 3,
  }) async {
    await _loadToken();
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    ).replace(queryParameters: queryParams);
    return _sendRequest<T>(
      () => _client.post(
        uri,
        headers: _createHeaders(headers),
        body: _encodeBody(body),
      ),
      timeout,
      maxRetries,
    );
  }

  ///File Upload
  Future<Either<Failure, T>> postFile<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    required Map<String, dynamic> files, // { fieldName: File }
    Map<String, String>? fields, // Additional form fields
    Duration timeout = const Duration(seconds: 10),
    int maxRetries = 3,
  }) async {
    await _loadToken();
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    ).replace(queryParameters: queryParams);

    return _sendRequest<T>(
      () async {
        final request = http.MultipartRequest('POST', uri)
          ..headers.addAll(_createHeaders(headers));

        // Add fields if any
        if (fields != null) {
          request.fields.addAll(fields);
        }

        // Add files
        files.forEach((fieldName, file) {
          if (file is File) {
            request.files.add(
              http.MultipartFile(
                fieldName,
                file.openRead(),
                file.lengthSync(),
                filename: file.path.split('/').last,
              ),
            );
          }
        });

        // Send request and handle response
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);
        logger.error('Gallery Response: ${response.body}');
        return response;
      },
      timeout,
      maxRetries,
    );
  }

  ///Multiple Upload
  Future<Either<Failure, T>> postMultipleFile<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    required Map<String, List<File>> files, // { fieldName: [File1, File2] }
    Map<String, String>? fields, // Additional form fields
    Duration timeout = const Duration(seconds: 10),
    int maxRetries = 3,
  }) async {
    await _loadToken();
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    ).replace(queryParameters: queryParams);

    return _sendRequest<T>(
      () async {
        final request = http.MultipartRequest('POST', uri)
          ..headers.addAll(_createHeaders(headers));

        // Add fields if any
        if (fields != null) {
          request.fields.addAll(fields);
        }

        // Add multiple files
        files.forEach((fieldName, fileList) {
          for (var file in fileList) {
            request.files.add(
              http.MultipartFile(
                fieldName,
                file.openRead(),
                file.lengthSync(),
                filename: file.path.split('/').last,
              ),
            );
          }
        });

        // Send request and handle response
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);
        return response;
      },
      timeout,
      maxRetries,
    );
  }

  ///
  Future<Either<Failure, T>> put<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    dynamic body,
    Duration timeout = const Duration(seconds: 10),
    int maxRetries = 3,
  }) async {
    await _loadToken();
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    ).replace(queryParameters: queryParams);
    return _sendRequest<T>(
      () => _client.put(
        uri,
        headers: _createHeaders(headers),
        body: _encodeBody(body),
      ),
      timeout,
      maxRetries,
    );
  }

  Future<Either<Failure, T>> patch<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    dynamic body,
    Duration timeout = const Duration(seconds: 10),
    int maxRetries = 3,
  }) async {
    await _loadToken();
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    ).replace(queryParameters: queryParams);
    return _sendRequest<T>(
      () => _client.patch(
        uri,
        headers: _createHeaders(headers),
        body: _encodeBody(body),
      ),
      timeout,
      maxRetries,
    );
  }

  Future<Either<Failure, T>> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    Duration timeout = const Duration(seconds: 10),
    int maxRetries = 3,
  }) async {
    await _loadToken();
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    ).replace(queryParameters: queryParams);
    return _sendRequest<T>(
      () => _client.delete(uri, headers: _createHeaders(headers)),
      timeout,
      maxRetries,
    );
  }

  Future<Either<Failure, T>> _sendRequest<T>(
    Future<http.Response> Function() request,
    Duration timeout,
    int maxRetries,
  ) async {
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final response = await request().timeout(timeout);
        return _handleResponse<T>(response);
      } catch (e) {
        retryCount++;

        // Handle retries and different types of exceptions
        if (retryCount >= maxRetries) {
          if (e is TimeoutException) {
            return Left(
              NetworkFailure("Request timed out after $maxRetries retries"),
            );
          } else if (e is SocketException) {
            return Left(NetworkFailure("Network error: $e"));
          } else if (e is HttpException) {
            return Left(NetworkFailure("HTTP error: $e"));
          } else {
            return Left(
              ServerFailure("Request failed after $maxRetries retries: $e"),
            );
          }
        }
        // Optionally, you could add a small delay between retries
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    // This point is unreachable, but keeps the method signature consistent.
    return Left(ServerFailure("Request failed after $maxRetries retries"));
  }

  Either<Failure, T> _handleResponse<T>(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return Right(jsonDecode(response.body) as T);
      case 400:
        return Left(ServerFailure('Bad request: ${response.body}'));
      case 401:
      case 403:
        return Left(ServerFailure('Unauthorized access: ${response.body}'));
      case 404:
        return Left(ServerFailure('Resource not found: ${response.body}'));
      default:
        return Left(ServerFailure('Server error: ${response.body}'));
    }
  }

  void dispose() {
    if (!_disposed) {
      _client.close();
      _disposed = true;
    }
  }
}
