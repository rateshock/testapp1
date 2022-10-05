import 'dart:async'; // Add this import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app_1/pages/home.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Add this import back
import '../src/navigation_controls.dart'; // Add this import
import '../src/web_view_stack.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar(),
      body: WebViewStack(controller: controller),
      bottomNavigationBar: ReusableWidgets.getBottomNavigationBar(context),
    );
  }
}
