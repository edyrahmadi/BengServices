import 'package:flutter/material.dart';
import 'package:bengservices/src/admin/pages/add_services_item.dart';
import 'package:bengservices/src/scoped-model/main_model.dart';
import 'package:bengservices/src/widgets/services_item_card.dart';
import 'package:bengservices/src/widgets/show_dailog.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritePage extends StatefulWidget {
  final MainModel model;

  FavoritePage({this.model});
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // the scaffold global key
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchServicess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _explorePageScaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext sctx, Widget child, MainModel model) {
          //model.fetchServicess(); // this will fetch and notifylisteners()
          // List<Services> services = model.services;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RefreshIndicator(
              onRefresh: model.fetchServicess,
              child: ListView.builder(
                itemCount: model.servicesLength,
                itemBuilder: (BuildContext lctx, int index) {
                  return GestureDetector(
                    onTap: () async {
                      final bool response = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AddServicesItem(
                                    services: model.services[index],
                                  )));

                      // if (response) {
                      //   SnackBar snackBar = SnackBar(
                      //     duration: Duration(seconds: 2),
                      //     backgroundColor: Theme.of(context).primaryColor,
                      //     content: Text(
                      //       "Services item successfully updated.",
                      //       style:
                      //           TextStyle(color: Colors.white, fontSize: 16.0),
                      //     ),
                      //   );
                      //   _explorePageScaffoldKey.currentState
                      //       .showSnackBar(snackBar);
                      // }
                    },
                    onDoubleTap: () {
                      // delete services item
                      showLoadingIndicator(
                          context, "Deleting services item...");
                      model
                          .deleteServices(model.services[index].id)
                          .then((bool response) {
                        Navigator.of(context).pop();
                      });
                    },
                    child: ServicesItemCard(
                      model.services[index].name,
                      model.services[index].description,
                      model.services[index].price.toString(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// Container(
//         color: Colors.white,
//         padding: EdgeInsets.symmetric(horizontal: 16.0),
//         child: ScopedModelDescendant<MainModel>(
//           builder: (BuildContext context, Widget child, MainModel model) {
//             model.fetchServicess();
//             List<Services> services = model.services;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: services.map((Services services){
//                 return ServicesItemCard(
//                   services.name,
//                   services.description,
//                   services.price.toString(),
//                 );
//               }).toList(),
//             );
//           },
//         ),
//       )
