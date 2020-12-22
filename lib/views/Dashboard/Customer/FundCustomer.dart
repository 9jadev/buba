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

class FundCustomer extends StatefulWidget {
  @override
  _FundCustomerState createState() => _FundCustomerState();
}

class _FundCustomerState extends State<FundCustomer>
    with FundCustomerValidationMixin {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // String firstname = ' ';
  // String lastname = ' ';
  String phone = '';
  bool loading = false;
  var customer;

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
          .startfunding(phone)
          .then((value) => {
                context.hideLoaderOverlay(),
                if (value["status"] == "success")
                  {
                    // Get.snackbar(
                    //   "Successful", "Upload Completed", // message
                    //   icon: Icon(Icons.close),
                    //   shouldIconPulse: true,
                    //   snackPosition: SnackPosition.TOP,
                    //   barBlur: 20,
                    //   backgroundColor: Colors.greenAccent,
                    //   isDismissible: true,
                    //   duration: Duration(seconds: 3),
                    // )

                    // print(value["user"]),

                    customer = customerFromJson(jsonEncode(value["user"])),
                    // print(customer.id)
                    Get.toNamed("/dashboard/fundcustomer_second",
                        arguments: customer)
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
                // print(value["status"]),
                // var body = jsonDecode(value),
                //
              })
          .catchError((err) => {
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
          child: Column(
            children: [
              SizedBox(height: 110.0),
              Center(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Fund Customer",
                        style: TextStyle(
                          color: Color(0xFF03027f),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        "credit customer",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
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
                          suffix: Icon(Icons.account_box, color: Colors.grey),
                        ),
                        initialCountryCode: 'NG',
                        validator: validatePhone,
                        onChanged: (phone) {
                          print(phone.number);
                          // print(phone.countryCode);
                        },
                        onSaved: (value) {
                          phone = '0' + value.number;
                        },
                      ),
                    ),

                    // Container(
                    //   padding: EdgeInsets.all(10.0),
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //       hintText: 'Enter Last Name',
                    //       hintStyle: TextStyle(color: Colors.grey),
                    //       // errorText: _errors["nickname"],
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       suffix: Icon(Icons.account_box, color: Colors.grey),
                    //     ),
                    //     validator: validatelastname,
                    //     onSaved: (value) {
                    //       lastname = value;
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.all(10.0),
                    //   child: IntlPhoneField(
                    //     decoration: InputDecoration(
                    //       hintText: 'Enter Phone Number',
                    //       hintStyle: TextStyle(color: Colors.grey),
                    //       // errorText: _errors["nickname"],
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       suffix: Icon(Icons.account_box, color: Colors.grey),
                    //     ),
                    //     initialCountryCode: 'NG',
                    //     validator: validatephone,
                    //     onChanged: (phone) {
                    //       // print(phone.completeNumber);
                    //     },
                    //     onSaved: (value) {
                    //       phone = value.completeNumber;
                    //     },
                    //   ),
                    // ),
                  ],
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
        ),
      ),
    );
  }
}
