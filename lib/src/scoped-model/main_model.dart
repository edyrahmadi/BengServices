import 'package:bengservices/src/scoped-model/user_scoped_model.dart';

import '../scoped-model/services_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with ServicesModel, UserModel {
  void fetchAll() {
    fetchServicess();
    fetchUserInfos();
  }
}
