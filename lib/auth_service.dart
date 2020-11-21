import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

enum LoginStatus { authenticated, authenticating, unAuthenticated }

class LoginState with ChangeNotifier {
  String _password;
  String _email;
  String _token;
  String _id;
  LoginStatus _status = LoginStatus.unAuthenticated;

  LoginStatus get status => _status;
  String get password => _password;
  String get email => _email;
  String get token => _token;
  String get id => _id;

  Future signIn(String email, String password) async {
    try {
      _status = LoginStatus.authenticating;
      notifyListeners();
      var req = LoginRequest(
        email: email,
        password: password,
      );

      http.post('url', body: req.toJson());

      Future.delayed(Duration(seconds: 3), () {
        var response = LoginResponse(token: '1234567890', id: '1');
        _token = response.token;
        _id = response.id;
        _email = email;
        _password = password;
        _status = LoginStatus.authenticated;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      _status = LoginStatus.authenticating;
      notifyListeners();

      http.post('url', body: {});

      _status = LoginStatus.unAuthenticated;
      notifyListeners();
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
  String id;
  LoginResponse({this.token, this.id});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    return data;
  }
}
