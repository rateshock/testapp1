import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_app_1/pages/auth/logout_page.dart';
import 'package:test_app_1/pages/chats_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../pages/home.dart';
import '../src/navigation_controls.dart';

class ReusableWidgets {
  static getAppBar() {
    final controller = Completer<WebViewController>();
    return AppBar(
      centerTitle: true,
      leading: NavigationControls(controller: controller),
      title: Image.asset("assets/banner1.png", width: 200, height: 50),
      backgroundColor: Colors.white, //<-- SEE HERE
    );
  }

  static getBottomNavigationBar(context) {
    return Stack(
      // we will have a custom container and bottom navigation bar on top of each other
      children: [
        Container(
          // this is the decoration of the container for gradient look
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Colors.orange,
              ],
            ),
          ),
          // i have found out the height of the bottom navigation bar is roughly 60
          height: 90,
        ),
        BottomAppBar(
          color: Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            StadiumBorder(),
          ),
          child: IconTheme(
            data: IconThemeData(color: Colors.white),
            child: Row(
              children: <Widget>[
                Spacer(),
                IconButton(
                  tooltip: 'Impostazioni',
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
                Spacer(),
                IconButton(
                  tooltip: 'Notifiche',
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {},
                ),
                Spacer(),
                IconButton(
                  tooltip: 'Aggiungi',
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {},
                ),
                Spacer(),
                IconButton(
                  tooltip: 'Chat',
                  icon: const Icon(Icons.chat),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatsPage()),
                    );
                  },
                ),
                Spacer(),
                IconButton(
                  tooltip: 'Account Page',
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogOut()),
                    );
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
