import 'package:get/state_manager.dart';
import 'package:buba/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  // UserController() {
  //   getusers();
  // }

  var user = User().obs;
  var account = 0.obs;
  // int get balance => int.parse(user.value.balance);

  @override
  void onInit() {
    getusers();
    print(user.value);
    super.onInit();
  }

  Future getusers() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    String userdata = authstorage.getString('user');
    // print(userdata);
    user.value = userFromJson(userdata);
    print(user.value.balance);
    // user.update((val) {
    //   val = userFromJson(userdata);
    // });
    // print(user.value.nickname);
  }

  int accountbalance() {
    return int.parse(user.value.balance);
  }

  updatebalace(newbac) {
    int acountb = accountbalance();
    print(acountb);
    String newb = (acountb - int.parse(newbac)).toString();
    user.update((value) {
      value.balance = newb;
    });
  }
}
