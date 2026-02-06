import 'package:equatable/equatable.dart';
import '../../core/enums/app_enums.dart';

class Tournament extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final HobbyType hobbyType;
  final TournamentFormat format;
  final String organizerId;
  final String? location;
  final double? latitude;
  final double? longitude;
  final DateTime startDate;
  final DateTime? endDate;
  final int maxParticipants;
  final int currentParticipants;
  final TournamentStatus status;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tournament({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.hobbyType,
    required this.format,
    required this.organizerId,
    this.location,
    this.latitude,
    this.longitude,
    required this.startDate,
    this.endDate,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.status,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isFull => currentParticipants >= maxParticipants;

  bool get isUpcoming => startDate.isAfter(DateTime.now());

  bool get isOngoing => status == TournamentStatus.ongoing;

  int get availableSpots => maxParticipants - currentParticipants;

  Tournament copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    HobbyType? hobbyType,
    TournamentFormat? format,
    String? organizerId,
    String? location,
    double? latitude,
    double? longitude,
    DateTime? startDate,
    DateTime? endDate,
    int? maxParticipants,
    int? currentParticipants,
    TournamentStatus? status,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Tournament(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      hobbyType: hobbyType ?? this.hobbyType,
      format: format ?? this.format,
      organizerId: organizerId ?? this.organizerId,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      status: status ?? this.status,
      tags: tags ?? this.tags,
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
        format,
        organizerId,
        location,
        latitude,
        longitude,
        startDate,
        endDate,
        maxParticipants,
        currentParticipants,
        status,
        tags,
        createdAt,
        updatedAt,
      ];
}

enum TournamentStatus {
  draft,
  open,
  ongoing,
  completed,
  cancelled,
}
