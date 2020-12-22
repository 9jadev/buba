import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buba/views/Loading.dart';
import 'package:get/get.dart';
import "package:get/instance_manager.dart";
import 'package:buba/controllers/UserController.dart';
import 'package:sweetalert/sweetalert.dart';

class MainDrawer extends StatelessWidget {
  final UserController usercontroller = Get.put(UserController());
  logout(context) async {
    SweetAlert.show(context,
        subtitle: "Do you want to logout",
        style: SweetAlertStyle.confirm,
        showCancelButton: true, onPress: (bool isConfirm) {
      if (isConfirm) {
        clearStore();
      }
      // return false to keep dialog
      // return false;
    });
  }

  clearStore() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    authstorage.remove('user');
    authstorage.remove('token');
    // SweetAlert
    Get.to(Loading());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Color(0xFFff9923),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   width: 100.0,
                  //   height: 100.0,
                  //   margin: EdgeInsets.only(top: 30.0),
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     image: DecorationImage(
                  //         image: NetworkImage(
                  //             "https://staff.creditwallet.ng/assets/Profile.png"),
                  //         fit: BoxFit.fill),
                  //   ),
                  // ),
                  Text(
                    "${Get.find<UserController>().user.value.firstname} ${Get.find<UserController>().user.value.lastname}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'Montserrat',
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${Get.find<UserController>().user.value.email}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              // tileColor: Color(0xFFff9923),
              leading: const Icon(
                Icons.home,
                size: 30.0,
                color: Color(0xFF03027f),
              ),
              title: const Text("Home"),
              onTap: () => Get.toNamed('/dashboard/home'),
            ),
            ListTile(
              leading: const Icon(
                Icons.add,
                size: 30.0,
                color: Color(0xFF03027f),
              ),
              title: const Text("Add Customer"),
              onTap: () => Get.toNamed('/dashboard/addcustomer'),
            ),
            ListTile(
              leading: const Icon(
                Icons.payment_outlined,
                size: 30.0,
                color: Color(0xFF03027f),
              ),
              title: const Text("Fund Customer"),
              onTap: () => Get.toNamed('/dashboard/fundcustomer'),
            ),
            ListTile(
              leading: const Icon(
                Icons.wallet_membership,
                size: 30.0,
                color: Color(0xFF03027f),
              ),
              title: const Text("Cash Out"),
              onTap: () => print("ListTile"),
            ),
            ListTile(
              leading: const Icon(
                Icons.bookmarks_rounded,
                size: 30.0,
                color: Color(0xFF03027f),
              ),
              title: const Text("Open Bids"),
              onTap: () => print("ListTile"),
            ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.bookmark_sharp,
            //     size: 30.0,
            //     color: Color(0xFF03027f),
            //   ),
            //   title: const Text("Open Bids"),
            //   onTap: () => print("ListTile"),
            // ),
            ListTile(
              leading: const Icon(
                Icons.collections_bookmark_rounded,
                size: 30.0,
                color: Color(0xFF03027f),
              ),
              title: const Text("Buy Bids"),
              onTap: () => Get.toNamed('/dashboard/bid/buy'),
            ),
            ListTile(
              leading: const Icon(
                Icons.emoji_events,
                size: 30.0,
                color: Color(0xFF03027f),
              ),
              title: const Text("Check Bid Status"),
              onTap: () => print("ListTile"),
            ),
            ListTile(
              leading: const Icon(
                Icons.format_list_bulleted_rounded,
                size: 30.0,
                color: Color(0xFF03027f),
              ),
              title: const Text("Transactions"),
              onTap: () => print("ListTile"),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 30.0,
                color: Color(0xFF03027f),
              ),
              title: const Text("Profile Management"),
              onTap: () => print("ListTile"),
            ),
            ListTile(
              leading: const Icon(
                Icons.arrow_back,
                size: 30.0,
                color: Color(0xFF03027f),
              ),
              title: const Text("Logout"),
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
    );
  }
}
