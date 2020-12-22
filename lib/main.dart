import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'views/Loading.dart';
import 'views/Dashboard/home.dart';
import 'views/Dashboard/Customer/AddCustomer.dart';
import 'views/Dashboard/Customer/FundCustomer.dart';
import 'package:buba/views/Dashboard/Customer/FundCustomersecond.dart';
import 'views/Dashboard/Customer/AddImage.dart';
import 'views/Dashboard/Bid/BuyBid.dart';
import 'views/login.dart';
import 'views/Dashboard/ReloadState.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoaderOverlay(
        overlayWidget: Center(
          child: SpinKitFadingCircle(
            color: Color(0xFFff9923),
            size: 50.0,
          ),
        ),
        overlayOpacity: 0.8,
        child: Firstpage(),
      ),
    );
  }
}

class Firstpage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BUBA AGENT',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Loading()),
        // GetPage(name: '/signup', page: () => Signup()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/dashboard/home', page: () => Home()),
        GetPage(name: '/reload', page: () => Myreload()),
        GetPage(name: '/dashboard/addcustomer', page: () => AddCustomer()),
        GetPage(name: '/dashboard/bid/buy', page: () => BuyBid()),
        GetPage(name: '/dashboard/fundcustomer', page: () => FundCustomer()),
        GetPage(
            name: '/dashboard/fundcustomer_second',
            page: () => FundCustomersecond()),
        GetPage(name: '/dashboard/addimage', page: () => Addimage())

        // GetPage(
        //   name: '/third',
        //   page: () => Third(),
        //   transition: Transition.zoom
        // ),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
