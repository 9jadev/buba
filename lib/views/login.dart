import 'package:flutter/material.dart';
import 'package:buba/MIxins/validation_mixins.dart';
import 'package:http/http.dart';
// import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:buba/views/Loading.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buba/utility/utility_variable.dart';
import 'dart:async';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with ValidationMixin {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String email = ' ';
  String password = ' ';
  bool loading = false;
  Envariable envariable = Envariable();

  Future _apilogin(String param, String password) async {
    print(param);
    // print();
    String baseurl = envariable.baseurl;
    // print(baseurl);

    String url = '$baseurl/agent/account/login';
    Map<String, String> headers = {"Accept": "application/json"};
    Map<String, String> json = {
      "param": param,
      "password": password,
    };

    Response response =
        await post(url, headers: headers, body: jsonEncode(json));
    var body = jsonDecode(response.body);
    // print(body["message"]);
    // print(response.statusCode);
    if (response.statusCode == 400 || response.statusCode == 401) {
      SweetAlert.show(context,
          title: "Login Error",
          subtitle: body["message"],
          style: SweetAlertStyle.error);
    }
    if (response.statusCode == 200) {
      // print(body["user"]);
      _loginstorage(body["user"], body["token"]);
    }
    // print(body);
    context.hideLoaderOverlay();
    setState(() {
      loading = false;
    });
  }

  void validate() {
    // EasyLoading.('Use in initState');
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      // print('your $email and $password');
      print(loading);
      if (loading == false) {
        setState(() {
          loading = true;
        });
        context.showLoaderOverlay();
        _apilogin(email, password);
      } else {
        print(5678);
      }

      // print(
      // 'validated $email and $nickname and $password and $confirmpassword');
      // EasyLoading.show(status: 'loading...');
      // _loginmember(nickname, password);
    } else {
      print("not validated");
    }
    // setState(() => _enabled = true);
    // EasyLoading.dismiss();
  }

  _loginstorage(Map user, String token) async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    authstorage.setString('user', json.encode(user));
    authstorage.setString('token', token);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Loading()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.0),
                Center(
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFF03027f),
                        fontWeight: FontWeight.w500,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.all(20.0),
                  // decoration: ,
                  child: Form(
                    key: formkey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.0),
                              // decoration: BoxDecoration(
                              //   border: Border(
                              //     bottom: BorderSide(color: Colors.white[200]),
                              //   ),
                              // ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Email',
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
                                  suffix: Icon(Icons.account_box,
                                      color: Colors.grey),
                                ),
                                validator: validateEmail,
                                // onChanged: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Nick Name is requred';
                                //   } else {
                                //     // setState(() {
                                //     //   // _errors["nickname"] = null;
                                //     // });
                                //     return null;
                                //   }
                                // },
                                onSaved: (value) {
                                  email = value;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              // decoration: BoxDecoration(
                              //   border: Border(
                              //     bottom: BorderSide(color: Colors.white[200]),
                              //   ),
                              // ),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Enter Password',
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
                                  suffix: Icon(Icons.lock, color: Colors.grey),
                                ),
                                validator: validatePassword,

                                // onChanged: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Password is requred';
                                //   } else {
                                //     // setState(() {
                                //     //   // _errors["password"] = null;
                                //     // });
                                //     return null;
                                //   }
                                // },
                                onSaved: (value) {
                                  password = value;
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
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(height: 10.0),
                            // GestureDetector(
                            //   // onTap: _enabled ? validate : null,
                            //   child: Container(
                            //     height: 70,
                            //     margin: EdgeInsets.all(10.0),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5.0),
                            //       color: Colors.redAccent,
                            //     ),
                            //     child: Center(
                            //       child: Text(
                            //         'Forgot password ?',
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
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
