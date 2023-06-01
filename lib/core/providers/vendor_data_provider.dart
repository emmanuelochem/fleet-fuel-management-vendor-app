import 'package:flutter/material.dart';

class VendorDataProvider with ChangeNotifier {
  Map _vendor;
  Map get user => _vendor;
  set user(Map data) {
    _vendor = data;
    notifyListeners();
  }
}
