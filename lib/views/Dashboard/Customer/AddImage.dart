import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:buba/utility/Httpconnect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_overlay/loader_overlay.dart';
// import 'package:buba/views/Dashboard/main_drawer.dart';

class Addimage extends StatefulWidget {
  @override
  _AddimageState createState() => _AddimageState();
}

class _AddimageState extends State<Addimage> {
  String id;
  String _auth;
  String myplaceholder = "assets/images/Profile.png";
  File _image;
  bool loading = false;
  final picker = ImagePicker();
  Httpconnect httpconnect = Httpconnect();

  @override
  void initState() {
    id = Get.parameters['id'];
    // print();
    print(id);
    _checkLogin();
    super.initState();
  }

  _checkLogin() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    _auth = authstorage.getString("token");
    print(_auth);
  }

  void upload() {
    if (loading == true) {
      print("am loading");
      return;
    }
    context.showLoaderOverlay();
    // print(id);
    httpconnect
        .uploadCustomerImage(id, _image)
        .then(
          (res) => {
            context.hideLoaderOverlay(),
            if (res == 200)
              {
                setState(() {
                  loading = false;
                }),
                Get.snackbar(
                  "Successful", "Upload Completed", // message
                  icon: Icon(Icons.close),
                  shouldIconPulse: true,
                  snackPosition: SnackPosition.TOP,
                  barBlur: 20,
                  backgroundColor: Colors.greenAccent,
                  isDismissible: true,
                  duration: Duration(seconds: 3),
                ),
                Get.toNamed('/dashboard/home')
              }
            else
              {
                context.hideLoaderOverlay(),
                setState(() {
                  loading = false;
                }),
                Get.snackbar(
                  "Whopp's",
                  "An error occoured",
                  icon: Icon(Icons.close),
                  shouldIconPulse: true,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.TOP,
                  barBlur: 20,
                  isDismissible: true,
                  duration: Duration(seconds: 3),
                )
              }
          },
        )
        .catchError((error) => {
              context.hideLoaderOverlay(),
              setState(() {
                loading = false;
              }),
              Get.snackbar(
                "Whopp's",
                "An error occoured",
                icon: Icon(Icons.close),
                shouldIconPulse: true,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.TOP,
                barBlur: 20,
                isDismissible: true,
                duration: Duration(seconds: 3),
              )
            });
    // _upload(_image);
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // myplaceholder =
      } else {
        print('No image selected.');
      }
    });
    print(_image);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF03027f),
            title: Text("Add Customer Image"),
          ),
          // drawer: MainDrawer(),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 180.0),
                  Center(
                    child: Text(
                      "Upload Image",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: _image == null
                        ? CircleAvatar(
                            radius: 120,
                            backgroundImage:
                                AssetImage('assets/images/Profile.png'))
                        : MyImage(image: _image),
                  ),
                  _image != null
                      ? RaisedButton(
                          onPressed: upload,
                          color: Colors.blue,
                          textColor: Colors.black,
                          child: Text("Upload Now"),
                        )
                      : SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: getImage,
            child: Icon(Icons.camera),
          ),
        ),
      ),
    );
  }
}

class LoadImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyImage extends StatelessWidget {
  const MyImage({
    Key key,
    @required File image,
  })  : _image = image,
        super(key: key);

  final File _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.file(_image),
    );
  }
}

// class MyImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       chil
//     );
//   }
// }
