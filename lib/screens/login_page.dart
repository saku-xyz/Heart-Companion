import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_electricity/main.dart';
import 'package:iot_electricity/screens/user_signup.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:iot_electricity/auth_service.dart';
import 'package:iot_electricity/screens/home_page.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../user_data.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<void> loginFunction(String email) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  final formKey = new GlobalKey<FormState>();

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    OutlineInputBorder commonBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
      ),
    );

    progressDialog = new ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      customBody: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Please Wait...",
                style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child:Transform.scale(
                scale: 1.3,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 300,
                        width: 250,
                        child: Image.asset("assets/images/logo2.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10,),
                        child: TextFormField(
                          controller: _email,
                          autofocus: false,
                          decoration: new InputDecoration(
                            border: commonBorder,
                            focusedBorder: commonBorder,
                            enabledBorder: commonBorder,
                            labelText: 'Email Address',
                            labelStyle: Theme.of(context).textTheme.subtitle1,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: PasswordField(
                          controller: _password,
                          color: Colors.grey,
                          inputStyle: Theme.of(context).textTheme.subtitle1,
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          ),
                          hasFloatingPlaceholder: true,
                          //pattern: r'.*[@$#.*].*',
                          border: commonBorder,
                          focusedBorder: commonBorder,
                          errorMessage: 'must contain special character either . * @ # \$',
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          width: double.infinity,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 13),
                              backgroundColor: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                            ),
                            child: Text(
                              'Login',
                              style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).primaryColor),
                            ),
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                progressDialog.show();
                                try {
                                  final form = formKey.currentState;
                                  form.save();
                                  final auth = AuthService();
                                  User user = await auth.signInWithEmailAndPassword(_email.text, _password.text);
                                  if (user.uid.length > 0 && user.uid != null) {
                                    progressDialog.hide();
                                    loginFunction(_email.text.toString()).then((value) => setState(() {
                                      appUser = user;
                                    }));
                                  }
                                } catch (e) {
                                  progressDialog.hide();
                                  setState(() {
                                    _email.clear();
                                    _password.clear();
                                  });
                                  print('Error: $e');
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        'Login Failed',
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Text(
                                        'Invalid E-mail or Password, please try again',
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('close'),
                                          onPressed: () {
                                            progressDialog.hide();
                                            Navigator.pop(context, true);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
