import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot_electricity/screens/about_page.dart';
import 'package:iot_electricity/screens/bills.dart';
import 'package:iot_electricity/screens/get_started_page.dart';
import 'package:iot_electricity/screens/login_page.dart';
import 'package:iot_electricity/main.dart';
import 'package:iot_electricity/auth_service.dart';
import 'package:iot_electricity/screens/usage_graph.dart';
import 'package:iot_electricity/user_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> userLogOut() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStartedPage()),);
  }

  List users = [];

  getUsers() async {
    await FirebaseDatabase.instance.reference().once().then((snapshot) async {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        if(key!='kS2EBNCiqkZkQTJfj5HMTUXkwla2'){
          users.add(key);
        }
      });
    }).then((value){
      setState((){});
    });
  }

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: (){},
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.message_outlined, color: Theme.of(context).accentColor,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'SEMS',
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.notifications,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[800],
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 90,
                  child: CircleAvatar(
                    radius: 85,
                    backgroundColor: Color.fromARGB(255, 100, 100, 100),
                    child: Padding(
                      padding: EdgeInsets.all(20),

                    ),
                  ),
                ),
                accountName: Text("${appUser.displayName}", style: TextStyle(color: Theme.of(context).accentColor),),
                accountEmail: Text("${appUser.email}", style: TextStyle(color: Theme.of(context).accentColor),),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()),);
                },
                title: Text(
                  'About',
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: Icon(
                  Icons.person_outline_rounded,
                  color: Theme.of(context).accentColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: Icon(
                  Icons.settings,
                  color: Theme.of(context).accentColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: Text(
                  'Lodge Complaint',
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: Icon(
                  Icons.file_copy_outlined,
                  color: Theme.of(context).accentColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: Text(
                  'Contact Us',
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: Icon(
                  Icons.message_rounded,
                  color: Theme.of(context).accentColor,
                ),
              ),
              ListTile(
                onTap: () async {
                  try {
                    final auth = AuthService();
                    await auth.signOut();
                    userLogOut();
                  } catch (e) {
                    print('Error: $e');
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Logout Failed',
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          'Something went wrong..!, please try again',
                          textAlign: TextAlign.center,
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('close'),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                title: Text(
                  'Log Out',
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
            ),
        ),
        ),
      body: Stack(
        children: [
          // Positioned(
          //   bottom: 0,
          //   left: 5,
          //   right: 5,
          //   child: Container(
          //     height: 140,
          //     child: Row(
          //       children: [
          //         Image.asset(
          //           'assets/images/asset1.png',
          //         ),
          //       ],
          //     ),
          //   )
          // ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25,),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    appUser != null ? "Hi ${appUser.displayName.toString().split(" ")[0]} !" : "Hi !",
                    style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).accentColor, fontSize: 34),
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, bottom: 10),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Simple Solutions For Complex Connections",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.grey[500]),
                  ),
                ),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: StreamBuilder(
                  stream: FirebaseDatabase.instance.reference().child("Power").onValue,
                  builder: (context, snapshot){
                    var data = snapshot.data.snapshot.value;
                    if(snapshot.hasData){
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Container(
                          height: 110,
                          child: Card(
                            color: Colors.grey[800],
                            elevation: 4.0,
                            clipBehavior: Clip.antiAlias,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15,),
                                    child: Image.network('https://www.clipartmax.com/png/middle/1-10735_flash-lightning-bolt-clipart.png'),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15,),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            'Power',
                                            style: Theme.of(context).textTheme.headline3,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            '$data  kW',
                                            style: TextStyle(
                                              fontSize: 32,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }else {
                      return Container();
                    }
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: StreamBuilder(
                  stream: FirebaseDatabase.instance.reference().child("Usage").onValue,
                  builder: (context, snapshot){
                    var data = snapshot.data.snapshot.value;
                    if(snapshot.hasData){
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Container(
                          height: 110,
                          child: Card(
                            color: Colors.grey[800],
                            elevation: 4.0,
                            clipBehavior: Clip.antiAlias,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15,),
                                    child: Image.network('https://i.pinimg.com/originals/1f/75/74/1f7574268b182ba5fc59816d4400389c.png'),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15,),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            'Usage',
                                            style: Theme.of(context).textTheme.headline3,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            '$data  kWh',
                                            style: TextStyle(
                                              fontSize: 32,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }else {
                      return Container();
                    }
                  },
                ),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: StreamBuilder(
                  stream: FirebaseDatabase.instance.reference().child("Bill").onValue,
                  builder: (context, snapshot) {
                    var data = snapshot.data.snapshot.value;
                    if(snapshot.hasData){
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Container(
                          height: 150,
                          child: Card(
                              color: Colors.grey[800],
                              clipBehavior: Clip.antiAlias,
                              elevation: 4.0,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 5,),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5.0),
                                                  child: Text(
                                                    'Estimated Bill',
                                                    style: Theme.of(context).textTheme.headline6,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5.0),
                                                  child: Text(
                                                    '$data',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Bill()),);
                                      },
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        color: Colors.grey[600],
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'View My Bills',
                                                style: Theme.of(context).textTheme.headline4,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 10,),
                                                child: Transform.scale(
                                                  scale: 1.5,
                                                  child: Icon(Icons.arrow_forward_rounded, color: Colors.white,),
                                                ),
                                              )
                                            ],
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      );
                    }else {
                      return Container();
                    }
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Container(
                    height: 200,
                    child: Card(
                      elevation: 10.0,
                        color: Colors.grey[800],
                      clipBehavior: Clip.antiAlias,
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UsageGraph()));
                        },
                        padding: EdgeInsets.zero,
                        splashColor: Colors.blue,
                        child: Stack(
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Image.asset('assets/images/button.png'),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, top: 25),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        child: Text(
                                          "Analyze Your Usage\nOver Time",
                                          style: Theme.of(context).textTheme.headline3,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
