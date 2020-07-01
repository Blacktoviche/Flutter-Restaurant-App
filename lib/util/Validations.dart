import 'package:ecommerce/util/EmailValidator.dart';

class Validations {
  String validateName(String value) {
    if (value.isEmpty) return 'يجب ادخال الاسم الكامل !';
    return null;
  }

  String validatePhone(String value) {
    if (value.isEmpty) return 'يجب ادخال رقم الهاتف  !';
    return null;
  }

  String validateUsername(String value) {
    if (value.isEmpty) return 'يجب ادخال اسم المستخدم!';
    return null;
  }

  String validateAddress(String value) {
    if (value.isEmpty) return 'يجب ادخال اسم العنوان!';
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'يجب ادخال كلمة السر!';
    return null;
  }

  String validateNumber(String value) {
    if (double.tryParse(value) == null) return 'يجب أن ادخال رقم!';
    return null;
  }

  String validateEmail(String value) {
    if (!EmailValidator.validate(value)) return 'يجب ادخال ايميل صحيح!';
    return null;
  }
}
