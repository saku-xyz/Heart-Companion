import 'package:flutter/material.dart';
import 'package:iot_electricity/widgets/HomeSliderWidget.dart';
import 'package:iot_electricity/widgets/VisionMissionSlider.dart';

import 'login_page.dart';
import 'user_signup.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you really want to exit the app?'),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(80, 20, 80, 0),
                  child: Container(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 8,),
                        backgroundColor: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        'Continue to LOGIN',
                        style: Theme.of(context).textTheme.headline4.copyWith(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white60,
                          fontSize: 14.0,
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Register Now',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline4.copyWith(color: Theme.of(context).accentColor),
                        ),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,),
                  child: Text(
                    'SEMS © 2021',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 25,),
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Hi !",
                        style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).accentColor, fontSize: 34),
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, bottom: 10),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Welcome to SEMS.",
                      style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),

                HomeSliderWidget(),

                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: VisionMissionSlider(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
