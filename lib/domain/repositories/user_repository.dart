import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  /// Get current user profile
  Future<Either<Failure, User>> getProfile();

  /// Update user profile
  Future<Either<Failure, User>> updateProfile(Map<String, dynamic> data);

  /// Get user by ID
  Future<Either<Failure, User>> getUserById(String id);

  /// Search users by username or name
  Future<Either<Failure, List<User>>> searchUsers(String query);

  /// Follow a user
  Future<Either<Failure, void>> followUser(String userId);

  /// Unfollow a user
  Future<Either<Failure, void>> unfollowUser(String userId);

  /// Get user's followers
  Future<Either<Failure, List<User>>> getFollowers(String userId);

  /// Get user's following
  Future<Either<Failure, List<User>>> getFollowing(String userId);
}
