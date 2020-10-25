import 'package:custom_login/bloc/models/login.dart';
import 'package:flutter/foundation.dart';

enum ViewState { Idle, Busy }

class AuthModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  _setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future doLogin(LoginRequest request) async {
    _setState(ViewState.Busy);

    try {
      _setState(ViewState.Idle);
      return LoginResponse(userId: '1', username: 'Ashar');
    } catch (e) {
      print(e);
      _setState(ViewState.Idle);
    }
  }
}
