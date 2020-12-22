import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buba/controllers/UserController.dart';
import 'utility_variable.dart';
import 'package:get/get.dart';
import 'dart:async';
// import 'da'

class Httpconnect {
  String auth;
  Envariable envariable = Envariable();
  final UserController c = Get.put(UserController());
  Httpconnect() {
    _checkLogin();
    reloadhome();
  }

  Future _checkLogin() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    auth = authstorage.getString("token");
    // print(auth);
    return auth;
  }

  Future createcustomer(String firstname, String lastname, String phone) async {
    // print(auth);
    auth = await _checkLogin();
    String url = '${envariable.baseurl}/agent/customer/account/create';
    // print(url);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": auth
    };
    Map<String, String> json = {
      "firstname": firstname,
      "lastname": lastname,
      "phone_number": phone
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(json));
    var body = jsonDecode(response.body);
    if (response.statusCode == 400 || response.statusCode == 401) {
      return body["message"];
    }
    if (response.statusCode == 200) {
      return body["user"]["id"];
    }
  }

  uploadCustomerImage(String id, File image) async {
    // print(id);
    // print(image.path);
    auth = await _checkLogin();

    var request = http.MultipartRequest(
        'POST', Uri.parse('${envariable.baseurl}agent/profile/picture/$id'));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    http.StreamedResponse response = await request.send();
    // var body = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return response.statusCode;
      // print(await response.stream.bytesToString());
    } else {
      return response.statusCode;
      // print(response.reasonPhrase);
    }
  }

  Future startfunding(String phone) async {
    // print(param);
    // print(password);
    auth = await _checkLogin();
    // print(auth)
    String url = '${envariable.baseurl}agent/customer/funding/start';
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": auth
    };
    Map<String, String> json = {
      "phone_number": phone,
    };

    http.Response response =
        await http.post(url, headers: headers, body: jsonEncode(json));
    var body = jsonDecode(response.body);
    // print(body["message"]);
    // print(response.statusCode);
    if (response.statusCode == 400 || response.statusCode == 401) {
      // SweetAlert.show(context,
      return body;
      //     title: "Login Error",
      //     subtitle: body["message"],
      //     style: SweetAlertStyle.error);
    }
    if (response.statusCode == 200) {
      return body;
      // print(body["user"]);
      // _loginstorage(body["user"], body["token"]);
    }
    // print(body);
    // context.hideLoaderOverlay();
    // setState(() {
    //   loading = false;
    // });
  }

  Future reloadhome() async {
    auth = await _checkLogin();
    var headers = {'Authorization': auth, 'Content-Type': 'application/json'};
    String url = '${envariable.baseurl}agent/dashboard/daily';
    http.Response response = await http.get(url, headers: headers);
    var body = jsonDecode(response.body);
    if (response.statusCode == 400 || response.statusCode == 401) {
      // SweetAlert.show(context,
      return body;
    }
    if (response.statusCode == 200) {
      // return 1223424;
      print(body["user"]["balance"]);
      // c.updatebalace(body["user"]["balance"]);
    }
  }
  // Future reloadhome() async {
  //   auth = await _checkLogin();
  //   var headers = {'Authorization': auth, 'Content-Type': 'application/json'};
  //   var request = http.Request(
  //       'GET', Uri.parse('https://api.buba.ng/public/agent/dashboard/daily'));
  //   request.body = '''''';
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //     return response.stream.bytesToString();
  //   } else {
  //     // print(response.reasonPhrase);
  //     // return  response.reasonPhrase;
  //   }
  // }

  updateprefrence(Map user) async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    authstorage.setString('user', json.encode(user));
    // authstorage.setString('token', token);
  }

  Future startfundingsecond(String amount, String id) async {
    // print(param);
    // print(amount);
    auth = await _checkLogin();
    String url = '${envariable.baseurl}agent/customer/funding/complete';
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": auth
    };
    Map<String, String> json = {"amount": amount, "reciever": id};

    http.Response response =
        await http.post(url, headers: headers, body: jsonEncode(json));
    var body = jsonDecode(response.body);
    if (response.statusCode == 400 || response.statusCode == 401) {
      // SweetAlert.show(context,
      // updateprefrence(body["user"]);
      return body;
    }
    if (response.statusCode == 200) {
      print(body);
      c.updatebalace(amount);
      return body;
    }
  }
}
