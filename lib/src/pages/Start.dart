import 'package:flutter/material.dart';
import 'package:bengservices/src/pages/sigin_page.dart';
import 'package:bengservices/src/widgets/button.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0),
                Container(
                  height: 150,
                  child: Image(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 80.0),
                RichText(
                    text: TextSpan(
                        text: 'Welcome to ',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        children: <TextSpan>[
                      TextSpan(
                          text: 'BengServices',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[400]))
                    ])),
                SizedBox(height: 10.0),
                Text(
                  'Aplikasi penyedia berbagai layanan Jasa',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 100.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SignInPage()));
                  },
                  child: Button(btnText: "Next"),
                ),
                SizedBox(height: 210.0),
                Text(
                  'Version 1.1.0',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
