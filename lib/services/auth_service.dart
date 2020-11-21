import 'package:custom_login/models/auth_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

// Assuming 3 states of login
enum LoginStatus { authenticated, authenticating, unAuthenticated }

// This class is responsible for state management of authentication
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
      // Start signing by changing login state from un-authenticated to authenticating
      _status = LoginStatus.authenticating;
      // Notifying state changes
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
        // After successful response, changing its state from authenticating to authenticated
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
