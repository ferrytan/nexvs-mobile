import 'package:equatable/equatable.dart';
import '../../core/enums/app_enums.dart';

class Event extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final HobbyType hobbyType;
  final EventStatus status;
  final String organizerId;
  final String? location;
  final double? latitude;
  final double? longitude;
  final DateTime eventDate;
  final int maxParticipants;
  final int currentParticipants;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.hobbyType,
    required this.status,
    required this.organizerId,
    this.location,
    this.latitude,
    this.longitude,
    required this.eventDate,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isFull => currentParticipants >= maxParticipants;

  bool get isUpcoming => eventDate.isAfter(DateTime.now());

  int get availableSpots => maxParticipants - currentParticipants;

  Event copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    HobbyType? hobbyType,
    EventStatus? status,
    String? organizerId,
    String? location,
    double? latitude,
    double? longitude,
    DateTime? eventDate,
    int? maxParticipants,
    int? currentParticipants,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      hobbyType: hobbyType ?? this.hobbyType,
      status: status ?? this.status,
      organizerId: organizerId ?? this.organizerId,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      eventDate: eventDate ?? this.eventDate,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
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
        status,
        organizerId,
        location,
        latitude,
        longitude,
        eventDate,
        maxParticipants,
        currentParticipants,
        tags,
        createdAt,
        updatedAt,
      ];
}
