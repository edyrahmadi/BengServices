import 'package:flutter/material.dart';
import 'package:bengservices/src/pages/sigin_page.dart';
import 'package:bengservices/src/scoped-model/main_model.dart';
import 'package:bengservices/src/screens/main_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class App extends StatelessWidget {
  final MainModel mainModel = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bengservices",
        theme: ThemeData(primaryColor: Colors.blueAccent),
        routes: {
          "/": (BuildContext context) => SignInPage(),
          "/mainscreen": (BuildContext context) => MainScreen(
                model: mainModel,
              ),
        },
      ),
    );
  }
}
