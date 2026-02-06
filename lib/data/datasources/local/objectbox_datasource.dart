import 'package:injectable/injectable.dart';

/// Abstract interface for ObjectBox database operations.
abstract class ObjectBoxDataSource {
  /// Initialize the database
  Future<void> init();

  /// Close the database
  Future<void> close();

  /// Get all objects of type T
  Future<List<T>> getAll<T>();

  /// Get object by id
  Future<T?> getById<T>(int id);

  /// Save object
  Future<int> save<T>(T object);

  /// Update object
  Future<bool> update<T>(T object);

  /// Delete object
  Future<bool> delete<T>(int id);

  /// Delete all objects of type T
  Future<bool> deleteAll<T>();

  /// Query objects with predicate
  Future<List<T>> query<T>(bool Function(T) predicate);
}

/// Implementation of ObjectBoxDataSource.
@Injectable(as: ObjectBoxDataSource)
class ObjectBoxDataSourceImpl implements ObjectBoxDataSource {
  @override
  Future<void> close() {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete<T>(int id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAll<T>() {
    throw UnimplementedError();
  }

  @override
  Future<List<T>> getAll<T>() {
    throw UnimplementedError();
  }

  @override
  Future<T?> getById<T>(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  Future<List<T>> query<T>(bool Function(T) predicate) {
    throw UnimplementedError();
  }

  @override
  Future<int> save<T>(T object) {
    throw UnimplementedError();
  }

  @override
  Future<bool> update<T>(T object) {
    throw UnimplementedError();
  }
}
