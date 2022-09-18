import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "About SEMS",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Simple solutions for complex connections",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "SEMS builds your need using updated technologies. Our sole objective is provide the best service to the client. We hope you can get comprehensive understanding of what we try to do with this smart electricity meter system. Please  join with us by supporting our efforts to make a successful and effective change in your day-to-day power consumption processes.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      "Our Vision",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "to be successful information technology company trusted by its customers for service excellence, caring  for its employees and collaborating with  our customers to deliver innovative and value driven IT products and services.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: Text(
                      "Our Mission",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "taking every possible step to make a successful and effective change in the day-to-day power consumption processes of the consumer using updated technologies.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
