class AppConstants {
  AppConstants._();

  // API
  static const String apiBaseUrl = 'https://api.nexvs.app';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyOnboardingComplete = 'onboarding_complete';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // App Info
  static const String appName = 'NEXVS';
  static const String appTagline = 'Connect & VS';

  // Supported Hobbies
  static const List<String> supportedHobbies = [
    'beyblade',
    'tamiya',
    'gunpla',
    'hpi',
    'drone_racing',
    'rc_cars',
    'other',
  ];
}

class AppEndpoints {
  AppEndpoints._();

  static const String auth = '/auth';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';

  static const String users = '/users';
  static const String profile = '/users/profile';
  static const String usersById = '/users/';

  static const String events = '/events';
  static const String eventsById = '/events/';
  static const String joinEvent = '/events/';
  static const String leaveEvent = '/events/';

  static const String tournaments = '/tournaments';
  static const String tournamentsById = '/tournaments/';

  static const String builds = '/builds';
  static const String buildsById = '/builds/';

  static const String battles = '/battles';
}
