import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';
// import 'package:http/http.dart' as http;

class RefreshTokenAuthenticator extends Authenticator {
  final String baseUrl;
  final AccountDbProvider storage;

  RefreshTokenAuthenticator(
    this.baseUrl, {
    required this.storage,
  });

  @override
  FutureOr<Request?> authenticate(
    Request request,
    Response response, [
    Request? originalRequest,
  ]) async {
    try {
      print("Hi from the Authenticator");
      return request;
    } catch (e) {
      print("Hi from the Authenticator catch with $e");
      return null;
    }
  }

  // TODO - make a http request with timeout for refreshing token.
  // Future<void> _refreshToken() async {
  //   try {
  //     final url = Uri.http(baseUrl, '/users/token/refresh');
  //     http.post(url, body: {});
  //   } catch (e) {
  //     throw Exception();
  //   }
  // }

  String loadRefreshToken() {
    final acc = storage.last();
    if (acc == null) {
      throw Exception("");
    }

    return acc.refreshToken;
  }

  void storeRefreshToken(Account acc, String token) {
    final updated = acc.copyWith(refreshToken: token);
    storage.save(updated);
  }
}
