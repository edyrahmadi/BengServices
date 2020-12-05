import 'package:flutter/material.dart';
import 'package:bengservices/src/pages/services_details_page.dart';

import 'package:bengservices/src/scoped-model/main_model.dart';
import 'package:bengservices/src/widgets/bought_servicess.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/home_top_info.dart';
import '../widgets/services_category.dart';
import '../widgets/search_file.dart';

// Model
import '../models/services_model.dart';

class HomePage extends StatefulWidget {
  // final FoodModel FoodModel;

  // HomePage(this.foodModel);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Services> _servicess = servicess;

  @override
  void initState() {
    // widget.ServicesModel.fetchServicess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: <Widget>[
          HomeTopInfo(),
          ServicesCategory(),
          SizedBox(
            height: 20.0,
          ),
          SearchField(),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Explore BengServices",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("I' pressed");
                },
                child: Text(
                  "View all",
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return Column(
                children: model.services.map(_buildServicesItems).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServicesItems(Services services) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ServicesDetailsPage(
            services: services,
          ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: BoughtServices(
          id: services.id,
          name: services.name,
          imagePath: "assets/images/profile-1.jpeg",
          category: services.category,
          discount: services.discount,
          price: services.price,
          ratings: services.ratings,
        ),
      ),
    );
  }
}
