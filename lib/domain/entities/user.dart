import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String? bio;
  final String? avatarUrl;
  final String? location;
  final List<String> hobbies;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.bio,
    this.avatarUrl,
    this.location,
    required this.hobbies,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? fullName,
    String? bio,
    String? avatarUrl,
    String? location,
    List<String>? hobbies,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      location: location ?? this.location,
      hobbies: hobbies ?? this.hobbies,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        fullName,
        bio,
        avatarUrl,
        location,
        hobbies,
        createdAt,
        updatedAt,
      ];
}
