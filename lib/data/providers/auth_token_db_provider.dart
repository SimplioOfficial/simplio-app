import 'package:hive_flutter/adapters.dart';
import 'package:simplio_app/data/http_clients/secured_http_client.dart';
import 'package:simplio_app/data/model/auth_token.dart';
import 'package:simplio_app/data/providers/box_provider.dart';

class AuthTokenDbProvider extends BoxProvider<AuthToken>
    implements AuthTokenStorage {
  static final AuthTokenDbProvider _instance = AuthTokenDbProvider._();

  @override
  final String boxName = 'authTokenBox';

  AuthTokenDbProvider._();

  factory AuthTokenDbProvider() {
    return _instance;
  }

  final _cache = _AuthTokenCache();

  @override
  void registerAdapters() {
    Hive.registerAdapter(AuthTokenAdapter());
  }

  @override
  AuthToken get() {
    final cached = _cache.read();
    if (cached != null) {
      return cached;
    }

    if (box.isNotEmpty) {
      return box.values.first;
    }

    throw Exception('Auth token not found.');
  }

  @override
  Future<void> save(AuthToken authToken) async {
    await box.clear();
    box.add(authToken);

    _cache.cache(authToken);
  }
}

class _AuthTokenCache {
  AuthToken? _authToken;
  _AuthTokenCache();

  AuthToken cache(AuthToken authToken) {
    _authToken = authToken;
    return authToken;
  }

  AuthToken? read() {
    return _authToken;
  }

  void clear() {
    _authToken = null;
  }
}
