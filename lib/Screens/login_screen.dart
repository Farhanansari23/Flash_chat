import 'package:chatapp/Screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import 'package:chatapp/constrants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  // User? loggedInUser;
  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUser();
  // }
  //
  // void getCurrentUser() async{
  //   try {
  //     final user = await _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //       print(loggedInUser!.email);
  //     }
  //   }catch(e){
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/wp.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kMessageTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 25.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kMessageTextFieldDecoration.copyWith(hintText: 'Enter your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
             RoundedButton(colour: Colors.lightBlueAccent,
                 title: 'Log In',
                 onPressed: () async{
               setState(() {
                 showSpinner = true;
               });
               try {
                 final User = await _auth.signInWithEmailAndPassword(
                     email: email!, password: password!);
                 if (User != null) {
                   Navigator.pushNamed(context, ChatScreen.id);
                 }
                 setState(() {
                   showSpinner =  false;
                 });
               }catch(e){
                 print(e);
               }

                 })
            ],
          ),
        ),
      ),
    );
  }
}



// Padding(
// padding: EdgeInsets.symmetric(vertical: 16.0),
// child: Material(
// color: Colors.lightBlueAccent,
// borderRadius: BorderRadius.all(Radius.circular(30.0)),
// elevation: 5.0,
// child: MaterialButton(
// onPressed: () {
// //Implement login functionality.
// },
// minWidth: 200.0,
// height: 42.0,
// child: Text(
// 'Log In',
// ),
// ),
// ),
// ),