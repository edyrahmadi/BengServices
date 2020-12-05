import 'package:flutter/material.dart';
import 'package:bengservices/src/models/user_info_model.dart';
import 'package:bengservices/src/scoped-model/main_model.dart';
import 'package:bengservices/src/widgets/custom_list_tile.dart';
import 'package:bengservices/src/widgets/small_button.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bengservices/src/admin/pages/add_services_item.dart';
import 'package:bengservices/src/widgets/button.dart';
import 'package:bengservices/src/widgets/add_button.dart';
import 'package:bengservices/src/pages/sigin_page.dart';
import 'package:bengservices/src/pages/Start.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnNotification = false;
  bool turnOnLocation = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        UserInfo userInfo = model.getUserDetails(model.authtenticatedUser.id);

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.0),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3.0,
                                offset: Offset(0, 4.0),
                                color: Colors.black38),
                          ],
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/profile.jpeg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${userInfo.username}",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "${userInfo.email}",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SmallButton(btnText: "Edit"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Akun",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          CustomListTile(
                            icon: Icons.location_on,
                            text: "Lokasi",
                          ),
                          Divider(
                            height: 10.0,
                            color: Colors.grey,
                          ),
                          CustomListTile(
                            icon: Icons.visibility,
                            text: "Ubah Password",
                          ),
                          Divider(
                            height: 10.0,
                            color: Colors.grey,
                          ),
                          CustomListTile(
                            icon: Icons.shopping_cart,
                            text: "History",
                          ),
                          Divider(
                            height: 10.0,
                            color: Colors.grey,
                          ),
                          CustomListTile(
                            icon: Icons.payment,
                            text: "Pembayaran",
                          ),
                          Divider(
                            height: 10.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Notifikasi",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Notifikasi Aplikasi",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Switch(
                                value: turnOnNotification,
                                onChanged: (bool value) {
                                  // print("The value: $value");
                                  setState(() {
                                    turnOnNotification = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Divider(
                            height: 10.0,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Lacak Lokasi",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Switch(
                                value: turnOnLocation,
                                onChanged: (bool value) {
                                  // print("The value: $value");
                                  setState(() {
                                    turnOnLocation = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Divider(
                            height: 10.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Lainnya",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Bahasa", style: TextStyle(fontSize: 16.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Add Jasa
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddServicesItem()));
                    },
                    child: AddButton(btnText: "Tambah Jasa"),
                  ),
                  //logout
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Start()));
                    },
                    child: Button(btnText: "Keluar"),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
