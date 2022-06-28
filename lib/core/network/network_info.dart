import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfoContract {
  Future<bool> isConnected();
}

class NetworkInfo implements NetworkInfoContract {
  final InternetConnectionChecker connectionChecker;

  NetworkInfo({required this.connectionChecker});
  @override
  Future<bool> isConnected() async {
    return await connectionChecker.hasConnection;
  }
}
