import 'package:injectable/injectable.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/local_datasource.dart';
import '../datasources/remote/remote_datasource.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AuthResult>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      final data = response.data;
      final authResult = AuthResult(
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String,
        user: data['user'] as Map<String, dynamic>,
      );

      // Save tokens locally
      await localDataSource.set('access_token', authResult.accessToken);
      await localDataSource.set('refresh_token', authResult.refreshToken);

      return Right(authResult);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> register({
    required String email,
    required String username,
    required String password,
    String? fullName,
  }) async {
    try {
      final response = await remoteDataSource.register(
        email: email,
        username: username,
        password: password,
        fullName: fullName,
      );

      final data = response.data;
      final authResult = AuthResult(
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String,
        user: data['user'] as Map<String, dynamic>,
      );

      // Save tokens locally
      await localDataSource.set('access_token', authResult.accessToken);
      await localDataSource.set('refresh_token', authResult.refreshToken);

      return Right(authResult);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.delete('access_token');
      await localDataSource.delete('refresh_token');
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> refreshToken() async {
    try {
      final refreshToken = await localDataSource.get('refresh_token');
      if (refreshToken == null) {
        return const Left(AuthenticationFailure(message: 'No refresh token found'));
      }

      final response = await remoteDataSource.refreshToken(
        refreshToken: refreshToken,
      );

      final newAccessToken = response.data['access_token'] as String;
      await localDataSource.set('access_token', newAccessToken);

      return Right(newAccessToken);
    } catch (e) {
      return Left(AuthenticationFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final token = await localDataSource.get('access_token');
      return Right(token != null);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
