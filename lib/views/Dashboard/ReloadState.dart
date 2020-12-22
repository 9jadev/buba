import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:buba/utility/Httpconnect.dart';

class Myreload extends StatefulWidget {
  @override
  _MyreloadState createState() => _MyreloadState();
}

class _MyreloadState extends State<Myreload> {
  Httpconnect httpconnect = Httpconnect();
  @override
  void initState() {
    // Timer(Duration(seconds: 4), () => Get.toNamed("/login"));
    _checkLogin();
    // httpconnect.reloadhome();
    super.initState();
  }

  _checkLogin() async {
    context.showLoaderOverlay();
    httpconnect.reloadhome().then((value) =>
        {context.hideLoaderOverlay(), Get.toNamed("/dashboard/home")});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF14317F),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    "Buba Agent",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
