import 'package:custom_login/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Assuming 3 states of profile
enum Profile { fetched, fetching, notFetched }

class ProfileState with ChangeNotifier {
  String _name;
  String _designation;
  Profile _status = Profile.notFetched;

  Profile get status => _status;
  String get name => _name;
  String get designation => _designation;

  Future getUser(String userID) async {
    try {
      // Get user information by changing profile state from not-fetched to fetching
      _status = Profile.fetching;
      notifyListeners();

      http.post('url', body: {'id': userID});

      Future.delayed(Duration(milliseconds: 3), () {
        var user = User(name: 'John David', designation: 'Flutter Developer');
        _name = user.name;
        _designation = user.designation;
        // After successful response, profile state changes from fetching to fetched
        _status = Profile.fetched;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }
}
