import 'package:injectable/injectable.dart';

/// Abstract interface for local data source operations.
abstract class LocalDataSource {
  /// Get cached data by key
  Future<String?> get(String key);

  /// Set cached data by key
  Future<bool> set(String key, String value);

  /// Delete cached data by key
  Future<bool> delete(String key);

  /// Clear all cached data
  Future<bool> clear();

  /// Check if key exists
  Future<bool> containsKey(String key);
}

/// Implementation of LocalDataSource using shared_preferences.
@Injectable(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  // Will be implemented with shared_preferences
  @override
  Future<bool> clear() {
    throw UnimplementedError();
  }

  @override
  Future<bool> containsKey(String key) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String key) {
    throw UnimplementedError();
  }

  @override
  Future<String?> get(String key) {
    throw UnimplementedError();
  }

  @override
  Future<bool> set(String key, String value) {
    throw UnimplementedError();
  }
}
