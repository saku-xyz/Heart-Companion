import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

User appUser;

List<dynamic> signUpData = new List.filled(5, "");

Future<String> signUp(String userID) async{

  // await FirebaseDatabase.instance.reference().child(userID).set({
  //   'name':signUpData[0].toString(),
  //   'email':signUpData[2].toString(),
  //   'role':'user'
  // });

  return 'successful';
}