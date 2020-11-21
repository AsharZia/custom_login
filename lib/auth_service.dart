import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

enum LoginStatus { Authenticated, Authenticating, Unauthenticated }

class LoginState with ChangeNotifier {
  String _password;
  String _email;
  String _token;
  LoginStatus _status = LoginStatus.Unauthenticated;

  LoginStatus get status => _status;
  String get password => _password;
  String get email => _email;
  String get token => _token;

  Future signIn(String email, String password) async {
    try {
      _status = LoginStatus.Authenticating;
      notifyListeners();
      var req = LoginRequest(
        email: email,
        password: password,
      );

      http.post('url', body: req.toJson());

      Future.delayed(Duration(seconds: 3), () {
        var response = LoginResponse(token: '1234567890');
        _token = response.token;
        _email = email;
        _password = password;
        _status = LoginStatus.Authenticated;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      _status = LoginStatus.Authenticating;
      notifyListeners();

      http.post('url', body: {});

      Future.delayed(Duration(seconds: 3), () {
        _status = LoginStatus.Unauthenticated;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }
}

class LoginRequest {
  String email;
  String password;

  LoginRequest({this.email, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class LoginResponse {
  String token;
  LoginResponse({this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
