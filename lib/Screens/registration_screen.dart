import 'package:chatapp/Screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import 'package:chatapp/constrants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black
                ),
                decoration: kMessageTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
                const SizedBox(
                height: 25.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                textAlign: TextAlign.center,
                decoration: kMessageTextFieldDecoration.copyWith(hintText: 'Enter your Password'),
              ),
              const SizedBox(
                height: 24.0,
              ),
             RoundedButton(colour: Colors.blueAccent,
                 title: 'Register',
                 onPressed: () async{
               setState(() {
                 showSpinner = true;
               });
               try {
                     final newUser = await _auth.createUserWithEmailAndPassword(
                         email: email!, password: password!);
                     if(newUser.user !=  null){
                       Navigator.pushNamed(context, ChatScreen.id);
                     }
                     setState(() {
                       showSpinner = false;
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
// padding: const EdgeInsets.symmetric(vertical: 16.0),
// child: Material(
// color: Colors.blueAccent,
// borderRadius: const BorderRadius.all(Radius.circular(30.0)),
// elevation: 5.0,
// child: MaterialButton(
// onPressed: () {
// //Implement registration functionality.
// },
// minWidth: 200.0,
// height: 42.0,
// child: const Text(
// 'Register',
// style: TextStyle(color: Colors.white),
// ),
// ),
// ),
// ),