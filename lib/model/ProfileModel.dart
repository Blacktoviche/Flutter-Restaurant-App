import 'dart:convert';

import 'package:ecommerce/backend/AppResponse.dart';
import 'package:ecommerce/backend/CustomerResponse.dart';
import 'package:ecommerce/backend/NewtworkUtils.dart';
import 'package:ecommerce/backend/PostResponse.dart';
import 'package:ecommerce/util/Storage.dart';
import 'package:ecommerce/util/Utils.dart';
import 'package:scoped_model/scoped_model.dart';
import '../modal/Customer.dart';

class ProfileModel extends Model {

  int id;
  String fullName = " ";
  String phone = " ";
  String address = " ";
  String email = " ";
  String username = " ";
  String password = " ";


  Customer customer;
  bool loading = false;
  bool registering = false;
  bool logging = false;
  Storage storage = Storage();

  loadCustomer() async {
    loading = true;
    customer = await storage.getCustomer();
    if (customer == null) {
      customer = null;
    }else{
      fillProperties();
    }
    loading = false;
    notifyListeners();
  }

  registerCustomer() async {
    registering = true;
    CustomerResponse response = await register();
    if(response != null){
      storage.saveCustomer(response.customer);
      customer = response.customer;
      fillProperties();
      Utils.sendSuccessMessage("تم إنشاء الحساب بنجاح");
    }
    registering = false;
    notifyListeners();
  }

  loginCustomer() async {
    logging = true;
    CustomerResponse response = await login();
    if(response != null){
      storage.saveCustomer(response.customer);
      customer = response.customer;
      fillProperties();
      Utils.sendSuccessMessage("تم تسجيل الدخول بنجاح");
    }
    logging = false;
    notifyListeners();
  }

  Future<CustomerResponse> register() async {
    try {
      final response = await send(
          "customers/register",
          jsonEncode(Customer(fullName: fullName, email: email, password: password, phone: phone, address: address).toJson()));
      return CustomerResponse.fromJson(response);
    } catch (e) {
      print("exceptionC: $e");
      Utils.sendErrorMessage(e.message);
      //PostResponse _response = new PostResponse(message: e.message);
      return Future.value(null);
    }
  }

  Future<CustomerResponse> login() async {
    try {
      final response = await send(
          "customers/login",
          jsonEncode(Customer(email: email, password: password).toJson()));
      return CustomerResponse.fromJson(response);
    } catch (e) {
      //print("exceptionC: ${e.runtimeType}");
      Utils.sendErrorMessage(e.message);
      //PostResponse _response = new PostResponse(message: e.message);
      return Future.value(null);
    }
  }

  fillProperties(){
    id = customer.id;
    fullName = customer.fullName;
    phone = customer.phone;
    address = customer.address;
    email = customer.email;
    username = customer.username;
  }
}
