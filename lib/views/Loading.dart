import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buba/utility/Httpconnect.dart';
import 'package:get/get.dart';
import 'dart:async';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Httpconnect httpconnect = Httpconnect();

  @override
  void initState() {
    // Timer(Duration(seconds: 4), () => Get.toNamed("/login"));
    _checkLogin();
    super.initState();
  }

  Future _checkLogin() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();

    String token = authstorage.getString("token");
    print(authstorage.getString("user"));
    if (token == null) {
      Timer(Duration(seconds: 4), () => Get.offAllNamed("/login"));
    } else {
      // print(token);
      httpconnect
          .reloadhome()
          .then((value) => Get.offAllNamed("/dashboard/home"));
      // Timer(Duration(seconds: 4), () => );
    }
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
                  SpinKitFadingCircle(
                    color: Colors.white,
                    size: 80.0,
                  ),
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
