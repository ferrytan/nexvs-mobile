import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:injectable/injectable.dart';

/// Abstract interface for network connectivity checking.
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<InternetStatus> get onStatusChange;
}

/// Implementation of NetworkInfo using internet_connection_checker.
@Injectable(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Stream<InternetStatus> get onStatusChange => connectionChecker.onStatusChange;
}
