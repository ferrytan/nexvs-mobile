import 'package:equatable/equatable.dart';
import '../../core/enums/app_enums.dart';

class Build extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final HobbyType hobbyType;
  final String ownerId;
  final List<String> imageUrls;
  final List<BuildPart> parts;
  final List<String> tags;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Build({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.hobbyType,
    required this.ownerId,
    required this.imageUrls,
    required this.parts,
    required this.tags,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.updatedAt,
  });

  Build copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    HobbyType? hobbyType,
    String? ownerId,
    List<String>? imageUrls,
    List<BuildPart>? parts,
    List<String>? tags,
    int? likesCount,
    int? commentsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Build(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      hobbyType: hobbyType ?? this.hobbyType,
      ownerId: ownerId ?? this.ownerId,
      imageUrls: imageUrls ?? this.imageUrls,
      parts: parts ?? this.parts,
      tags: tags ?? this.tags,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        hobbyType,
        ownerId,
        imageUrls,
        parts,
        tags,
        likesCount,
        commentsCount,
        createdAt,
        updatedAt,
      ];
}

class BuildPart extends Equatable {
  final String name;
  final String? brand;
  final String? model;
  final String? description;

  const BuildPart({
    required this.name,
    this.brand,
    this.model,
    this.description,
  });

  BuildPart copyWith({
    String? name,
    String? brand,
    String? model,
    String? description,
  }) {
    return BuildPart(
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [name, brand, model, description];
}
