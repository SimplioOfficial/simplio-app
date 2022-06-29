import 'package:chopper/chopper.dart';

abstract class HttpClient {
  ChopperClient get client;

  T service<T extends ChopperService>() => client.getService<T>();
}
