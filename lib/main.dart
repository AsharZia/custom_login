import 'package:custom_login/ui/views/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_model.dart';
import 'ui/views/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      create: (_) => LoginState.instance(),
      child: Consumer(
        builder: (context, LoginState user, _) {
          switch (user.status) {
            case LoginStatus.Unauthenticated:
            case LoginStatus.Authenticating:
              return LoginScreen();
            case LoginStatus.Authenticated:
              return ProfileScreen(user: user.user);
          }
        },
      ),
    );
  }
}
