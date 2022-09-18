import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_electricity/main.dart';
import 'package:iot_electricity/user_data.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:iot_electricity/auth_service.dart';
import 'package:iot_electricity/screens/home_page.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _mobileNumber = new TextEditingController();
  final TextEditingController _address = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _matchPassword = new TextEditingController();

  final formKey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldSignUpKey = GlobalKey();

  signUpFunction() async {
    progressDialog.show();
    try {
      final form = formKey.currentState;
      form.save();
      final auth = AuthService();
      User user = await auth.createUserWithEmailAndPassword(_email.text, _password.text, _name.text);
      if (user.uid.length > 0 && user.uid != null) {
        setState(() {
          appUser = user;
        });
        signUp(user.uid);

        progressDialog.hide();

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      progressDialog.hide();
      print('Error: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'SignUp Failed',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Invalid E-mail or Password or user already exists, please try with different details',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('close'),
              onPressed: () {
                progressDialog.hide();
                Navigator.pop(context, false);
              },
            ),
          ],
        ),
      );
    }
  }

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

    TextStyle commonTextStyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
        key: _scaffoldSignUpKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Get Started',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              )),
                          Text('Please enter your correct information.',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                height: 1.5,
                              )),
                          Text('* Required',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                  height: 1.5,
                                  color: Colors.red)),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(25, 5, 25, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Name
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  paste: true,
                                  cut: true,
                                  selectAll: false),
                              validator: (value) {
                                String namePattern = r'^[A-Za-z ]{3,40}$';
                                RegExp regExpName = new RegExp(namePattern);

                                if (value.isEmpty) {
                                  return 'Name is Missing';
                                } else if (!regExpName.hasMatch(value)) {
                                  return 'Please enter a appropriate name';
                                }
                                return null;
                              },
                              controller: _name,
                              decoration: InputDecoration(
                                border: commonBorder,
                                focusedBorder: commonBorder,
                                enabledBorder: commonBorder,
                                labelText: 'Name *',
                                labelStyle: commonTextStyle,
                              ),
                              maxLines: 1,
                            ),
                          ),

                          // Mobile Number
                          /*Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  paste: true,
                                  cut: true,
                                  selectAll: false),
                              validator: (value) {
                                String numberPattern = r'^[0-9]{9}$';
                                RegExp regExpNumber = new RegExp(numberPattern);
                                if (value.isEmpty) {
                                  return 'Mobile Number is Missing';
                                } else if (!regExpNumber.hasMatch(value)) {
                                  return 'Please enter a valid mobile number';
                                }
                                return null;
                              },
                              controller: _mobileNumber,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: commonBorder,
                                focusedBorder: commonBorder,
                                prefixText: '+94',
                                labelText: 'Mobile Number *',
                                labelStyle: commonTextStyle,
                              ),
                              maxLines: 1,
                            ),
                          ),*/

                          //number

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _email,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'E-Mail is Missing';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: commonBorder,
                                focusedBorder: commonBorder,
                                enabledBorder: commonBorder,
                                labelText: 'Email',
                                labelStyle: commonTextStyle,
                              ),
                              maxLines: 1,
                            ),
                          ), //email

                          /*Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _address,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Address is Missing';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: commonBorder,
                                focusedBorder: commonBorder,
                                helperStyle: TextStyle(color: Colors.red),
                                labelText: 'Address',
                                labelStyle: commonTextStyle,
                              ),
                              maxLines: 1,
                            ),
                          ),*/

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: PasswordField(
                              controller: _password,
                              color: Colors.grey,
                              suffixIcon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              ),
                              inputStyle: Theme.of(context).textTheme.subtitle1,
                              hasFloatingPlaceholder: true,
                              pattern: r'^[A-Za-z0-9_@.]{6,20}$',
                              border: commonBorder,
                              focusedBorder: commonBorder,
                              hintStyle: commonTextStyle,
                              errorMessage: 'minimum length is 6 charcters',
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _matchPassword,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'empty field..!';
                                } else if (value != _password.text.toString()) {
                                  return 'password do not match';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: commonBorder,
                                focusedBorder: commonBorder,
                                enabledBorder: commonBorder,
                                labelText: 'Confirm password',
                                labelStyle: commonTextStyle,
                              ),
                              maxLines: 1,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            width: double.infinity,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(15),
                                shape: StadiumBorder(),
                                backgroundColor: Theme.of(context).accentColor,
                              ),
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: deviceRatio + 18.0,
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing...'),));
                                  signUpData[0] = _name.text;
                                  signUpData[1] = _mobileNumber.text;
                                  signUpData[2] = _email.text;
                                  signUpData[3] = _address.text;
                                  signUpData[4] = _password.text;

                                  signUpFunction();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
