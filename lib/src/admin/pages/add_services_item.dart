import 'package:flutter/material.dart';
import 'package:bengservices/src/models/services_model.dart';
import 'package:bengservices/src/scoped-model/main_model.dart';
import 'package:bengservices/src/widgets/button.dart';
import 'package:bengservices/src/widgets/show_dailog.dart';
import 'package:scoped_model/scoped_model.dart';

class AddServicesItem extends StatefulWidget {
  final Services services;

  AddServicesItem({this.services});

  @override
  _AddServicesItemState createState() => _AddServicesItemState();
}

class _AddServicesItemState extends State<AddServicesItem> {
  String title;
  String category;
  String description;
  String price;
  String discount;

  GlobalKey<FormState> _servicesItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop(false);
          return Future.value(false);
        },
        child: Scaffold(
          key: _scaffoldStateKey,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text(
              widget.services != null ? "Update Jasa" : "Tambah Jasa",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Form(
                key: _servicesItemFormKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      width: MediaQuery.of(context).size.width,
                      height: 170.0,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/noimage.png"),
                        ),
                      ),
                    ),
                    _buildTextFormField("Nama"),
                    _buildTextFormField("Kategori Jasa"),
                    _buildTextFormField("Deskripsi", maxLine: 5),
                    _buildTextFormField("Harga/Jam"),
                    _buildTextFormField("Diskon"),
                    SizedBox(
                      height: 70.0,
                    ),
                    ScopedModelDescendant(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return GestureDetector(
                          onTap: () {
                            onSubmit(model.addServices, model.updateServices);
                            if (model.isLoading) {
                              // show loading progess indicator
                              showLoadingIndicator(
                                  context,
                                  widget.services != null
                                      ? "Updating services..."
                                      : "Adding services...");
                            }
                          },
                          child: Button(
                              btnText: widget.services != null
                                  ? "Update Jasa"
                                  : "Tambah Jasa"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(Function addServices, Function updateServices) async {
    if (_servicesItemFormKey.currentState.validate()) {
      _servicesItemFormKey.currentState.save();

      if (widget.services != null) {
        // I want to update the services item
        Map<String, dynamic> updatedServicesItem = {
          "title": title,
          "category": category,
          "description": description,
          "price": price,
          "discount": discount,
        };

        final bool response =
            await updateServices(updatedServicesItem, widget.services.id);
        if (response) {
          Navigator.of(context).pop(); // to remove the alert Dialog
          Navigator.of(context).pop(response); // to the previous page
        } else if (!response) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text(
              "Failed to update services item",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          );
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }
      } else if (widget.services == null) {
        // I wnat to add new Item
        final Services services = Services(
          name: title,
          category: category,
          description: description,
          price: double.parse(price),
          discount: double.parse(discount),
        );
        bool value = await addServices(services);
        if (value) {
          Navigator.of(context).pop();
          SnackBar snackBar =
              SnackBar(content: Text("Services item successfully added."));
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        } else if (!value) {
          Navigator.of(context).pop();
          SnackBar snackBar =
              SnackBar(content: Text("Failed to add services item"));
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }
      }
    }
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      initialValue: widget.services != null && hint == "Nama"
          ? widget.services.name
          : widget.services != null && hint == "Deskripsi"
              ? widget.services.description
              : widget.services != null && hint == "Kategori Jasa"
                  ? widget.services.category
                  : widget.services != null && hint == "Harga/Jam"
                      ? widget.services.price.toString()
                      : widget.services != null && hint == "Diskon"
                          ? widget.services.discount.toString()
                          : "",
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      keyboardType: hint == "Harga/Jam" || hint == "Diskon"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        // String error
        if (value.isEmpty && hint == "Nama") {
          return "The services title is required";
        }
        if (value.isEmpty && hint == "Deskripsi") {
          return "The description is required";
        }

        if (value.isEmpty && hint == "Kategori Jasa") {
          return "The category is required";
        }

        if (value.isEmpty && hint == "Harga/Jam") {
          return "The price is required";
        }
        // return "";
      },
      onSaved: (String value) {
        if (hint == "Nama") {
          title = value;
        }
        if (hint == "Kategori Jasa") {
          category = value;
        }
        if (hint == "Deskripsi") {
          description = value;
        }
        if (hint == "Harga/Jam") {
          price = value;
        }
        if (hint == "Diskon") {
          discount = value;
        }
      },
    );
  }

  Widget _buildCategoryTextFormField() {
    return TextFormField();
  }
}
