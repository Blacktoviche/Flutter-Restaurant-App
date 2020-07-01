import 'package:ecommerce/model/ProfileModel.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:ecommerce/util/Validations.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = new ScrollController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Validations validations = new Validations();
  bool autovalidate = false;

  final ProfileModel model = ProfileModel();
  int currentPosition = 0;

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
            backgroundColor: Constants.MAIN_COLOR,
            body: Stack(
              children: <Widget>[
                Container(
                  foregroundDecoration: BoxDecoration(color: Colors.black26),
                  height: 400,
                  child: Image.asset("assets/images/noImage.png",
                      fit: BoxFit.fill),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 250),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "item.title",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 16.0),
                          Chip(
                            label: Text(model.fullName),
                            labelStyle: TextStyle(color: Constants.LIGHT_COLOR),
                            backgroundColor: Constants.MAIN_COLOR,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Form(
                              key: formKey,
                              autovalidate: autovalidate,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: validations.validateNumber,
                                      decoration: InputDecoration(
                                          hintText: "الاسم و الكنية"),
                                      initialValue: model.fullName,
                                      onSaved: (String value) {
                                        model.fullName = value;
                                      }),
                                  TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: validations.validateEmail,
                                      decoration: InputDecoration(
                                          hintText: "البريد الالكتروني"),
                                      initialValue: model.email,
                                      onSaved: (String value) {
                                        model.fullName = value;
                                      }),
                                  TextFormField(
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: validations.validatePassword,
                                      decoration: InputDecoration(
                                          hintText: "كلمة السر"),
                                      initialValue: model.password,
                                      onSaved: (String value) {
                                        model.password = value;
                                      }),
                                  TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: validations.validateName,
                                      decoration: InputDecoration(
                                          hintText: "رقم الهاتف"),
                                      initialValue: model.phone,
                                      onSaved: (String value) {
                                        model.phone = value;
                                      }),
                                  TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: validations.validateNumber,
                                      decoration:
                                          InputDecoration(hintText: "العنوان"),
                                      initialValue: model.address,
                                      onSaved: (String value) {
                                        model.address = value;
                                      }),
                                  RaisedButton(
                                      onPressed: _handleSubmit,
                                      elevation: 5,
                                      color: Constants.DARK_COLOR,
                                      textColor: Constants.LIGHT_COLOR,
                                      child: Text("إرسال")),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }

  _handleSubmit() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showSnack('الرجاء تصحيح الأخطاء أولا!', Colors.redAccent);
    } else {
      form.save();
      model.registerCustomer();
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
