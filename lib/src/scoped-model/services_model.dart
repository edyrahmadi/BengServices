import 'dart:convert';

import 'package:bengservices/src/models/services_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class ServicesModel extends Model {
  List<Services> _services = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Services> get services {
    return List.from(_services);
  }

  int get servicesLength {
    return _services.length;
  }

  Future<bool> addServices(Services services) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> servicesData = {
        "title": services.name,
        "description": services.description,
        "category": services.category,
        "price": services.price,
        "discount": services.discount,
      };
      final http.Response response = await http.post(
          "https://bengservices-7e507.firebaseio.com/services.json",
          body: json.encode(servicesData));

      final Map<String, dynamic> responeData = json.decode(response.body);

      Services servicesWithID = Services(
        id: responeData["name"],
        name: services.name,
        description: services.description,
        category: services.category,
        discount: services.discount,
        price: services.price,
      );

      _services.add(servicesWithID);
      _isLoading = false;
      notifyListeners();
      // fetchservices();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
      // print("Connection error: $e");
    }
  }

  Future<bool> fetchServicess() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http
          .get("https://bengservices-7e507.firebaseio.com/services.json");

      // print("Fecthing data: ${response.body}");
      final Map<String, dynamic> fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Services> servicesItems = [];

      fetchedData.forEach((String id, dynamic servicesData) {
        Services servicesItem = Services(
          id: id,
          name: servicesData["title"],
          description: servicesData["description"],
          category: servicesData["category"],
          price: double.parse(servicesData["price"].toString()),
          discount: double.parse(servicesData["discount"].toString()),
        );

        servicesItems.add(servicesItem);
      });

      _services = servicesItems;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      print("The errror: $error");
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> updateServices(
      Map<String, dynamic> servicesData, String servicesId) async {
    _isLoading = true;
    notifyListeners();

    // get the services by id
    Services theServices = getServicesItemById(servicesId);

    // get the index of the services
    int servicesIndex = _services.indexOf(theServices);
    try {
      await http.put(
          "https://bengservices-7e507.firebaseio.com/services/${servicesId}.json",
          body: json.encode(servicesData));

      Services updateServicesItem = Services(
        id: servicesId,
        name: servicesData["title"],
        category: servicesData["category"],
        discount: servicesData['discount'],
        price: servicesData['price'],
        description: servicesData['description'],
      );

      _services[servicesIndex] = updateServicesItem;

      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> deleteServices(String servicesId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.delete(
          "https://bengservices-7e507.firebaseio.com/services/${servicesId}.json");

      // delete item from the list of services items
      _services.removeWhere((Services services) => services.id == servicesId);

      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Services getServicesItemById(String servicesId) {
    Services services;
    for (int i = 0; i < _services.length; i++) {
      if (_services[i].id == servicesId) {
        services = _services[i];
        break;
      }
    }
    return services;
  }
}
