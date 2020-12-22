import 'package:flutter/material.dart';
import 'package:buba/views/Dashboard/main_drawer.dart';
// import 'package:money2/money2.dart';
import 'package:get/get.dart';
import "package:get/instance_manager.dart";
import 'package:buba/utility/Httpconnect.dart';
import 'package:buba/controllers/UserController.dart';
import 'package:buba/utility/widget_utility.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserController usercontroller = Get.put(UserController());
  Httpconnect httpconnect = Httpconnect();

  @override
  void initState() {
    httpconnect.reloadhome();
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF03027f),
          title: Text(
            "HOME",
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              height: 280.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF03027f),
                // border: Border.all(color: Colors.blueAccent),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.0),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "welcom back",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: GetX<UserController>(
                      init: UserController(),
                      initState: (_) {},
                      builder: (_) {
                        return Text(
                          '${_.user.value.firstname} ${_.user.value.lastname}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontSize: 30.0,
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          GetX<UserController>(
                            init: UserController(),
                            initState: (_) {},
                            builder: (controller) {
                              return AgentAccount(
                                accountbalance:
                                    '${controller.user.value.balance}',
                              );
                            },
                          ),
                          Agentcreted(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/dashboard/addcustomer');
                        },
                        child: Container(
                          height: 250.0,
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_box_rounded,
                                  color: Color(0xFF03027f),
                                  size: 150.0,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Add Customer',
                                  style: TextStyle(
                                      color: Color(0xFF03027f),
                                      fontSize: 20.0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          // color: Colors.amber,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/dashboard/fundcustomer');
                        },
                        child: Container(
                          height: 250.0,
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.money_off_csred_rounded,
                                  color: Color(0xFF03027f),
                                  size: 150.0,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Fund Customer',
                                  style: TextStyle(
                                      color: Color(0xFF03027f),
                                      fontSize: 20.0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          // color: Colors.amber,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
            // Container(
            //   height: 200.0,
            //   color: Colors.grey,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       // Text("sdijsd"),
            // Container(
            //   height: 100.0,
            //   width: 100.0,
            //   color: Colors.amber,
            // )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
