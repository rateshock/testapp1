import 'package:flutter/material.dart';
import 'package:test_app_1/service/auth-service.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
      child: Text("Logout"),
      onPressed: () {
        authService.signOut();
      },
    )));
  }
}
