import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:traveling_social_app/constants/api_constants.dart';
import 'dart:convert';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  userInfoChanged
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _storage = const FlutterSecureStorage();

  Stream<AuthenticationStatus> get status async* {
    await checkAuthenticated();
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse(baseUrl + "/api/v1/auth/login");
    try {
      final resp = await http.post(
        url,
        body: jsonEncode({"email": username, "password": password}),
        headers: {
          "Content-Type": "application/json",
          'Access-Control-Allow-Origin': '*'
        },
      );
      if (resp.statusCode == 200) {
        final json = jsonDecode(resp.body) as Map<String, dynamic>;
        await saveSuccessAuthToken(
            accessToken: json['accessToken'],
            refreshToken: json['refreshToken']);
        _controller.add(AuthenticationStatus.authenticated);
        return;
      } else {
        throw 'Username or password not correct';
      }
    } on Exception {
      rethrow;
    }
  }

  Future<dynamic> saveSuccessAuthToken(
      {required String accessToken, required String refreshToken}) async {
    await _storage.write(key: "accessToken", value: accessToken);
    await _storage.write(key: "refreshToken", value: refreshToken);
  }

  Future<bool> checkAuthenticated() async {
    String? accessToken = await _storage.read(key: 'accessToken');
    if (accessToken != null) {
      _controller.add(AuthenticationStatus.authenticated);
      return true;
    }
    _controller.add(AuthenticationStatus.unauthenticated);
    return false;
  }

  logOut() async {
    await _storage.deleteAll();
    _controller.add(AuthenticationStatus.unauthenticated);
    return;
  }

  void dispose() async {
    await _controller.close();
  }
}
