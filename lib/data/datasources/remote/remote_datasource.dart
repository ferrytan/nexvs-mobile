import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'remote_datasource.g.dart';

/// Abstract interface for remote API calls.
@RestApi()
abstract class RemoteDataSource {
  @factoryMethod
  factory RemoteDataSource(Dio dio) = _RemoteDataSource;

  // Auth endpoints
  @POST('/auth/login')
  Future<HttpResponse<Map<String, dynamic>>> login({
    @Field('email') required String email,
    @Field('password') required String password,
  });

  @POST('/auth/register')
  Future<HttpResponse<Map<String, dynamic>>> register({
    @Field('email') required String email,
    @Field('username') required String username,
    @Field('password') required String password,
    @Field('full_name') String? fullName,
  });

  @POST('/auth/refresh')
  Future<HttpResponse<Map<String, dynamic>>> refreshToken({
    @Field('refresh_token') required String refreshToken,
  });

  @POST('/auth/logout')
  Future<HttpResponse<Map<String, dynamic>>> logout();

  // User endpoints
  @GET('/users/profile')
  Future<HttpResponse<Map<String, dynamic>>> getProfile();

  @PUT('/users/profile')
  Future<HttpResponse<Map<String, dynamic>>> updateProfile({
    @Field() required Map<String, dynamic> data,
  });

  // Event endpoints
  @GET('/events')
  Future<HttpResponse<Map<String, dynamic>>> getEvents({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('hobby_type') String? hobbyType,
  });

  @GET('/events/{id}')
  Future<HttpResponse<Map<String, dynamic>>> getEventById({
    @Path('id') required String id,
  });

  @POST('/events')
  Future<HttpResponse<Map<String, dynamic>>> createEvent({
    @Field() required Map<String, dynamic> data,
  });

  // Tournament endpoints
  @GET('/tournaments')
  Future<HttpResponse<Map<String, dynamic>>> getTournaments({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('hobby_type') String? hobbyType,
  });

  @GET('/tournaments/{id}')
  Future<HttpResponse<Map<String, dynamic>>> getTournamentById({
    @Path('id') required String id,
  });

  // Build endpoints
  @GET('/builds')
  Future<HttpResponse<Map<String, dynamic>>> getBuilds({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('hobby_type') String? hobbyType,
  });

  @POST('/builds')
  Future<HttpResponse<Map<String, dynamic>>> createBuild({
    @Field() required Map<String, dynamic> data,
  });
}
