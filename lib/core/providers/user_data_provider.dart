import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class UserDataProvider with ChangeNotifier {
  Map _user;
  Map get user => _user;
  set user(Map data) {
    _user = data;
    notifyListeners();
  }
}
