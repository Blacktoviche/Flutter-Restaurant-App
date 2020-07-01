import 'dart:ui';
import 'package:ecommerce/model/ProfileModel.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:ecommerce/util/Validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Validations validations = new Validations();
  bool autovalidate = false;

  bool loginAutovalidate = false;
  final ProfileModel model = ProfileModel();

  @override
  void initState() {
    model.loadCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProfileModel>(
        model: model,
        child: ScopedModelDescendant<ProfileModel>(builder:
            (BuildContext inContext, Widget inChild, ProfileModel model) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Constants.MAIN_COLOR,
            body: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: WaveClipper2(),
                      child: Container(
                        child: Column(),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Constants.SUB_COLOR,
                          Constants.MAIN_COLOR
                        ])),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper3(),
                      child: Container(
                        child: Column(),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Constants.SUB_COLOR,
                          Constants.MAIN_COLOR
                        ])),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper1(),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Icon(
                              Icons.fastfood,
    
                              color: Constants.MAIN_COLOR,
                              size: 60,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "مطعمي",
                              style: TextStyle(
                                  color: Constants.MAIN_COLOR,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Constants.SUB_COLOR,
                          //gradient: LinearGradient(
                          //  colors: [Color(0xffff3a5a), Color(0xfffe494d)]),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                _buildBody()
              ],
            ),
          );
        })
    );
  }

  Widget _buildBody() {
    if (model.loading) {
      return Center(
        child: SpinKitThreeBounce(
          color: Constants.SUB_COLOR,
        ),
      );
    } else if (model.customer == null) {
      return _buildRegisterForm();
    } else {
      return _buildProfile();
    }
  }

  Widget _buildProfile() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        //border: Border.all(width: 10, color: Constants.SUB_COLOR),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 10.0),
          ListTile(
            title: Text(
              "الاسم",
              style: TextStyle(color: Constants.SUB_COLOR),
            ),
            subtitle: Text(model.customer.fullName,
                style: TextStyle(color: Constants.TEXT_COLOR)),
            leading: Icon(
              Icons.person,
              color: Constants.SUB_COLOR,
            ),
          ),
          ListTile(
            title: Text(
              "البريد الإلكتروني",
              style: TextStyle(color: Constants.SUB_COLOR),
            ),
            subtitle: Text(model.customer.email,
                style: TextStyle(color: Constants.TEXT_COLOR)),
            leading: Icon(
              Icons.email,
              color: Constants.SUB_COLOR,
            ),
          ),
          ListTile(
            title: Text(
              "هاتف",
              style: TextStyle(color: Constants.SUB_COLOR),
            ),
            subtitle: Text(model.customer.phone,
                style: TextStyle(color: Constants.TEXT_COLOR)),
            leading: Icon(
              Icons.phone,
              color: Constants.SUB_COLOR,
            ),
          ),
          ListTile(
            title: Text(
              "العنوان",
              style: TextStyle(color: Constants.SUB_COLOR),
            ),
            subtitle: Text(model.customer.address,
                style: TextStyle(color: Constants.TEXT_COLOR)),
            leading: Icon(
              Icons.location_city,
              color: Constants.SUB_COLOR,
            ),
          )
        ],
      ),
      //),
      // ),
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      children: <Widget>[
        Form(
          key: formKey,
          autovalidate: autovalidate,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    onSaved: (String value) {model.fullName = value;},
                    validator: validations.validateName,
                    cursorColor: Constants.SUB_COLOR,
                    decoration: InputDecoration(
                        hintText: "الاسم الكامل",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.person,
                            color: Constants.SUB_COLOR,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String value) {model.email = value;},
                    validator: validations.validateEmail,
                    cursorColor: Constants.SUB_COLOR,
                    decoration: InputDecoration(
                        hintText: "البريد الإلكتروني",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.email,
                            color: Constants.SUB_COLOR,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    onSaved: (String value) {model.password = value;},
                    validator: validations.validatePassword,
                    obscureText: true,
                    cursorColor: Constants.SUB_COLOR,
                    decoration: InputDecoration(
                        hintText: "كلمة السر",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.lock,
                            color: Constants.SUB_COLOR,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    onSaved: (String value) {model.phone = value;},
                    validator: validations.validateName,
                    keyboardType: TextInputType.phone,
                    cursorColor: Constants.SUB_COLOR,
                    decoration: InputDecoration(
                        hintText: "الهاتف",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.phone,
                            color: Constants.SUB_COLOR,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    onSaved: (String value) {model.address = value;},
                    validator: validations.validateAddress,
                    cursorColor: Constants.SUB_COLOR,
                    decoration: InputDecoration(
                        hintText: "العنوان",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.location_city,
                            color: Constants.SUB_COLOR,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Constants.SUB_COLOR),
                    child: model.registering ? SpinKitWave(
                      color: Constants.SUB_COLOR,
                    ): FlatButton(
                      child: Text(
                        "إرسال",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      onPressed: _handleRegister,
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
            child: Text("إذا كان لديك حساب الرجاء تسجيل الدخول", style: TextStyle(color:Constants.SUB_COLOR,fontSize: 12 ,fontWeight: FontWeight.w700),),
            ),
        SizedBox(
          height: 20,
        ),
        Form(
          key: loginFormKey,
          autovalidate: loginAutovalidate,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    onSaved: (String value) {model.email = value;},
                    validator: validations.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Constants.SUB_COLOR,
                    decoration: InputDecoration(
                        hintText: "البريد الإلكتروني",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.email,
                            color: Constants.SUB_COLOR,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    onSaved: (String value) {model.password = value;},
                    validator: validations.validatePassword,
                    obscureText: true,
                    cursorColor: Constants.SUB_COLOR,
                    decoration: InputDecoration(
                        hintText: "كلمة السر",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.lock,
                            color: Constants.SUB_COLOR,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Constants.SUB_COLOR),
                    child: model.logging ? SpinKitWave(
                      color: Constants.SUB_COLOR,
                    ): FlatButton(
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      onPressed: _handleLogin,
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }

  _handleRegister() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showSnack('الرجاء تصحيح الأخطاء أولا!', Colors.redAccent);
    } else {
      form.save();
      model.registerCustomer();
    }
  }

  _handleLogin() {
    final FormState form = loginFormKey.currentState;
    if (!form.validate()) {
      loginAutovalidate = true; // Start validating on every change.
      showSnack('الرجاء تصحيح الأخطاء أولا!', Colors.redAccent);
    } else {
      form.save();
      model.loginCustomer();
    }
  }
  
  showSnack(String msg, Color bgColor) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        content: Text(msg),
      ),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
