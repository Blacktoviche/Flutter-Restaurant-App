
import 'package:ecommerce/modal/Customer.dart';

class CustomerResponse {
  Customer customer;
  CustomerResponse(
      {this.customer});

  CustomerResponse.fromJson(Map<String, dynamic> json) {
    customer = Customer().fromJson(json);
  }
}