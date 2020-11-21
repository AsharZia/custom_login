import 'package:custom_login/profile_service.dart';
import 'package:custom_login/ui/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'ui/views/login.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athlon Test',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginState(),
      child: Consumer(
        builder: (context, LoginState state, _) {
          switch (state.status) {
            case LoginStatus.unAuthenticated:
              return LoginScreen();
            case LoginStatus.authenticated:
              return ChangeNotifierProvider(
                create: (_) => ProfileState(),
                child: ProfileScreen(),
              );
            default:
              return LoginScreen();
          }
        },
      ),
    );
  }
}
