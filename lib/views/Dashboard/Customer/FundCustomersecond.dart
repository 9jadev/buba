import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:buba/views/Dashboard/main_drawer.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:buba/MIxins/validate_fund_customer_mixins.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:buba/utility/Httpconnect.dart';
import 'package:buba/models/customer.dart';
import 'package:get/get.dart';
import 'dart:async';

class FundCustomersecond extends StatefulWidget {
  @override
  _FundCustomersecondState createState() => _FundCustomersecondState();
}

class _FundCustomersecondState extends State<FundCustomersecond> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // String firstname = ' ';
  // String lastname = ' ';
  String amount = '';
  bool loading = false;
  var customer;

  void initState() {
    customer = Get.arguments;
    // print();
    print(customer.id);
    // _checkLogin();
    super.initState();
  }

  String validateamount(String value) {
    // value.replaceFirst(0);
    if (value.isEmpty) {
      return 'Amount can`t be empty';
    }
    return null;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  void validate() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();

      // setState(() {
      //   loading = true;
      // });
      context.showLoaderOverlay();

      Httpconnect httpconnect = Httpconnect();
      httpconnect
          .startfundingsecond(amount, customer.authid)
          .then((value) => {
                // print(value["status"]),
                context.hideLoaderOverlay(),
                if (value["status"] == "success")
                  {
                    // customer = customerFromJson(jsonEncode(value["user"])),
                    // print(customer.id)
                    Get.snackbar(
                      "Successful", "Fund Added successful.", // message
                      icon: Icon(Icons.close),
                      shouldIconPulse: true,
                      snackPosition: SnackPosition.TOP,
                      barBlur: 20,
                      backgroundColor: Colors.greenAccent,
                      isDismissible: true,
                      duration: Duration(seconds: 3),
                    ),
                    Timer(Duration(seconds: 3),
                        () => Get.toNamed("/dashboard/home")),
                  }
                else
                  {
                    Get.snackbar(
                      "Whopp's",
                      value["message"],
                      icon: Icon(Icons.close),
                      shouldIconPulse: true,
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.TOP,
                      barBlur: 20,
                      isDismissible: true,
                      duration: Duration(seconds: 3),
                    )
                  }
              })
          .catchError((err) => {
                print(err),
                context.hideLoaderOverlay(),
                Get.snackbar(
                  "Whopp's",
                  'an error occoured.',
                  icon: Icon(Icons.close),
                  shouldIconPulse: true,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.TOP,
                  barBlur: 20,
                  isDismissible: true,
                  duration: Duration(seconds: 3),
                )
              });
      // print(createcustomer).then;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF03027f),
          title: Text(
            "Fund Customer",
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        // drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 90.0),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                      'https://api.buba.ng/app/api/uploads/${customer.picture}'),
                ),
                SizedBox(height: 30.0),
                Text(
                  '${customer.firstname}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '${customer.lastname}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Form(
                  key: formkey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(7.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Amount',
                            hintStyle: TextStyle(color: Colors.grey),
                            // errorText: _errors["nickname"],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            suffix: Icon(Icons.money, color: Colors.grey),
                          ),
                          validator: validateamount,
                          onSaved: (value) {
                            amount = value;
                            // var newphone = value.replaceFirst('+234', '0');
                            // phone = newphone;
                          },
                        ),
                      ),
                      SizedBox(height: 40.0),
                      GestureDetector(
                        onTap: validate,
                        child: Container(
                          height: 70,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xFFff9923),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
