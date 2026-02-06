import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/event.dart';

abstract class EventRepository {
  /// Get all events with optional filters
  Future<Either<Failure, List<Event>>> getEvents({
    int? page,
    int? limit,
    String? hobbyType,
    String? search,
  });

  /// Get event by ID
  Future<Either<Failure, Event>> getEventById(String id);

  /// Create a new event
  Future<Either<Failure, Event>> createEvent(Map<String, dynamic> data);

  /// Update an event
  Future<Either<Failure, Event>> updateEvent({
    required String id,
    required Map<String, dynamic> data,
  });

  /// Delete an event
  Future<Either<Failure, void>> deleteEvent(String id);

  /// Join an event
  Future<Either<Failure, void>> joinEvent(String id);

  /// Leave an event
  Future<Either<Failure, void>> leaveEvent(String id);

  /// Get events near user's location
  Future<Either<Failure, List<Event>>> getNearbyEvents({
    required double latitude,
    required double longitude,
    double radiusKm = 50,
  });
}
