import 'package:objectbox/objectbox.dart';
import '../../domain/entities/user.dart';

@Entity()
class UserModel {
  @Id()
  int? id;

  final String uuid;
  final String username;
  final String email;
  final String? fullName;
  final String? bio;
  final String? avatarUrl;
  final String? location;
  final List<String> hobbies;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    this.id,
    required this.uuid,
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

  /// Convert JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uuid: json['uuid'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      location: json['location'] as String?,
      hobbies: List<String>.from(json['hobbies'] as List? ?? []),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'username': username,
      'email': email,
      'full_name': fullName,
      'bio': bio,
      'avatar_url': avatarUrl,
      'location': location,
      'hobbies': hobbies,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Convert to Domain Entity
  User toEntity() {
    return User(
      id: uuid,
      username: username,
      email: email,
      fullName: fullName,
      bio: bio,
      avatarUrl: avatarUrl,
      location: location,
      hobbies: hobbies,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Convert from Domain Entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      uuid: user.id,
      username: user.username,
      email: user.email,
      fullName: user.fullName,
      bio: user.bio,
      avatarUrl: user.avatarUrl,
      location: user.location,
      hobbies: user.hobbies,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  UserModel copyWith({
    int? id,
    String? uuid,
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
    return UserModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
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
}
