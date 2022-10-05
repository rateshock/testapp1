// ignore_for_file: prefer_const_constructors

import 'dart:async'; // Add this import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app_1/pages/auth/register_page.dart';
import 'package:test_app_1/pages/home.dart';
import 'package:test_app_1/service/auth-service.dart';
import 'package:test_app_1/service/database_service.dart';
import 'package:test_app_1/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Add this import back
import '../../helper/helper_function.dart';
import '../../src/navigation_controls.dart'; // Add this import
import '../../src/web_view_stack.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../widgets/appbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Completer<WebViewController>();
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 242, 103, 10)),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "TripToShare",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text("Effettua il Login per continuare",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: "Email", prefix: Icon(Icons.email)),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Please enter a valid email";
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Password", prefix: Icon(Icons.lock)),
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        //controlla validazione
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password deve avere almeno 6 caratteri";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 255, 102, 0),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text(
                              "Log In",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              login();
                            },
                          )),
                      const SizedBox(height: 10),
                      Text.rich(TextSpan(
                          text: "Non ho un account: ",
                          style: const TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Registrati",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 102, 0),
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const RegisterPage());
                                  })
                          ]))
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: ReusableWidgets.getBottomNavigationBar(context),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService
          .loginUserWithEmailandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
          //salva values in Shared Preferences (=> prendo i dati dal database e login) ad es per prendere il fullName da database snapshot.docs[0]('fullName')
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
