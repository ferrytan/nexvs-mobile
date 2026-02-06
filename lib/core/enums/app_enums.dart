/// Enum representing various hobby categories supported in NEXVS.
enum HobbyType {
  beyblade('Beyblade', 'beyblade'),
  tamiya('Tamiya', 'tamiya'),
  gunpla('Gunpla', 'gunpla'),
  hpi('HPI', 'hpi'),
  droneRacing('Drone Racing', 'drone_racing'),
  rcCars('RC Cars', 'rc_cars'),
  other('Other', 'other');

  final String displayName;
  final String value;

  const HobbyType(this.displayName, this.value);

  static HobbyType fromValue(String value) {
    return HobbyType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => HobbyType.other,
    );
  }
}

/// Enum representing event status.
enum EventStatus {
  draft('Draft'),
  upcoming('Upcoming'),
  ongoing('Ongoing'),
  completed('Completed'),
  cancelled('Cancelled');

  final String displayName;

  const EventStatus(this.displayName);
}

/// Enum representing tournament format.
enum TournamentFormat {
  singleElimination('Single Elimination'),
  doubleElimination('Double Elimination'),
  roundRobin('Round Robin'),
  swiss('Swiss System'),
  groupStage('Group Stage + Knockout');

  final String displayName;

  const TournamentFormat(this.displayName);
}

/// Enum representing battle status.
enum BattleStatus {
  pending('Pending'),
  inProgress('In Progress'),
  completed('Completed'),
  disputed('Disputed'),
  cancelled('Cancelled');

  final String displayName;

  const BattleStatus(this.displayName);
}

/// Enum representing user role in events/tournaments.
enum ParticipantRole {
  organizer('Organizer'),
  participant('Participant'),
  judge('Judge'),
  spectator('Spectator');

  final String displayName;

  const ParticipantRole(this.displayName);
}

/// Enum for request status (friend requests, join requests, etc.)
enum RequestStatus {
  pending('Pending'),
  accepted('Accepted'),
  rejected('Rejected'),
  cancelled('Cancelled');

  final String displayName;

  const RequestStatus(this.displayName);
}

/// Enum for sorting options.
enum SortOption {
  newest('Newest'),
  oldest('Oldest'),
  popular('Most Popular'),
  upcoming('Upcoming'),
  nearby('Nearby');

  final String displayName;

  const SortOption(this.displayName);
}

/// Enum for distance units.
enum DistanceUnit {
  kilometers('km'),
  miles('mi');

  final String unit;

  const DistanceUnit(this.unit);
}
