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
  String userId;
  String username;

  LoginResponse({this.userId, this.username});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    return data;
  }
}
