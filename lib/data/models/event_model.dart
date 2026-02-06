import 'package:objectbox/objectbox.dart';
import '../../core/enums/app_enums.dart';
import '../../domain/entities/event.dart';

@Entity()
class EventModel {
  @Id()
  int? id;

  final String uuid;
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

  EventModel({
    this.id,
    required this.uuid,
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

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      uuid: json['uuid'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String?,
      hobbyType: HobbyType.fromValue(json['hobby_type'] as String),
      status: EventStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => EventStatus.draft,
      ),
      organizerId: json['organizer_id'] as String,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      eventDate: DateTime.parse(json['event_date'] as String),
      maxParticipants: json['max_participants'] as int,
      currentParticipants: json['current_participants'] as int,
      tags: List<String>.from(json['tags'] as List? ?? []),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'hobby_type': hobbyType.value,
      'status': status.name,
      'organizer_id': organizerId,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'event_date': eventDate.toIso8601String(),
      'max_participants': maxParticipants,
      'current_participants': currentParticipants,
      'tags': tags,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Event toEntity() {
    return Event(
      id: uuid,
      title: title,
      description: description,
      imageUrl: imageUrl,
      hobbyType: hobbyType,
      status: status,
      organizerId: organizerId,
      location: location,
      latitude: latitude,
      longitude: longitude,
      eventDate: eventDate,
      maxParticipants: maxParticipants,
      currentParticipants: currentParticipants,
      tags: tags,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory EventModel.fromEntity(Event event) {
    return EventModel(
      uuid: event.id,
      title: event.title,
      description: event.description,
      imageUrl: event.imageUrl,
      hobbyType: event.hobbyType,
      status: event.status,
      organizerId: event.organizerId,
      location: event.location,
      latitude: event.latitude,
      longitude: event.longitude,
      eventDate: event.eventDate,
      maxParticipants: event.maxParticipants,
      currentParticipants: event.currentParticipants,
      tags: event.tags,
      createdAt: event.createdAt,
      updatedAt: event.updatedAt,
    );
  }
}
