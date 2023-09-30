import 'package:ceuk_user_app/shared/form/dropdown_model.dart';
import 'package:intl/intl.dart';

class AppConstant {
  AppConstant._();
  static DateFormat formatDate = DateFormat('yMMMMd');
  static DateFormat formatTime = DateFormat.jm();

  final currency = NumberFormat.currency(name: 'NGN', symbol: 'NGN');

  static List<DropdownModel> analyticsFilterOptions = [
    DropdownModel(name: 'Today', value: 'today'),
    DropdownModel(name: 'Yesterday', value: 'yesterday'),
    DropdownModel(name: 'This Week', value: 'week'),
    DropdownModel(name: 'This Month', value: 'month'),
    DropdownModel(name: 'Year', value: 'year'),
  ];
}
