import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/viewModels/auth_model.dart';
import 'ui/views/login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athlon Test',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
      },
    );
  }
}
