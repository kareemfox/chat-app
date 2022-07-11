
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  String? data;
  Login({Key? key,this.data}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: TextButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login(data: "",),
            ),
          );
        }, child: Text("Sign Up",style: TextStyle(fontSize: 20),)),
      ),
    );
  }
}
