import 'package:ecommerce/modal/Customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage _singleton = Storage._internal();

  factory Storage() {
    return _singleton;
  }

  Storage._internal();

  saveCustomer(Customer customer) async {
    SharedPreferences _ref = await SharedPreferences.getInstance();
    await _ref.setInt("id", customer.id);
    await _ref.setString("username", customer.username);
    await _ref.setString("email", customer.email);
    await _ref.setString("fullName", customer.fullName);
    await _ref.setString("address", customer.address);
    await _ref.setString("token", customer.token);
    await _ref.setString("phone", customer.phone);
  }

  Future<Customer> getCustomer() async {
    SharedPreferences _ref = await SharedPreferences.getInstance();
    if (_ref.containsKey("email")) {
      return Customer().fromJson({
        "id": _ref.getInt("id"),
        "email": _ref.getString("email"),
        "username": _ref.getString("username"),
        "fullName": _ref.getString("fullName"),
        "address": _ref.getString("address"),
        "token": _ref.getString("token"),
        "phone": _ref.getString("phone"),
      });
    } else {
      return Future.value(null);
    }
  }
}
