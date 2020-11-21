import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginStatus { Authenticated, Authenticating, Unauthenticated }

class LoginState with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  LoginStatus _status = LoginStatus.Unauthenticated;

  LoginState.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  LoginStatus get status => _status;
  User get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = LoginStatus.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = LoginStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = LoginStatus.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(User user) async {
    if (user == null) {
      _status = LoginStatus.Unauthenticated;
    } else {
      _user = user;
      _status = LoginStatus.Authenticated;
    }
    notifyListeners();
  }
}
