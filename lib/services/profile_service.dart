import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      _status = Profile.fetching;
      notifyListeners();

      http.post('url', body: {'id': userID});

      Future.delayed(Duration(milliseconds: 3), () {
        var user = User(name: 'John David', designation: 'Flutter Developer');
        _name = user.name;
        _designation = user.designation;
        _status = Profile.fetched;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }
}

class User {
  String name;
  String designation;
  User({this.name, this.designation});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['designation'] = this.designation;
    return data;
  }
}
