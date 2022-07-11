import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tesst/Splash.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  late String Email;
  late String Password;

  String? data;

  SecondScreen({Key? key, this.data}) : super(key: key);
  GlobalKey<FormState> gg = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  late String First_Name;
  late String Last_Name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
            child: Text('Sign Up',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    color: Colors.white54))),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: gg,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: TextFormField(
                    onChanged: (value) {
                      First_Name = value;
                    },
                    decoration: InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: TextFormField(
                    onChanged: (value) {
                      Last_Name = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: TextFormField(
                    onChanged: (value) {
                      Email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: TextFormField(
                    onChanged: (value) {
                      Password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: TextButton(
                      onPressed: () async {
                        if (gg.currentState!.validate())
                          await users.add({
                            'FirstName ': First_Name,
                            'LastName': Last_Name,
                          }).then((value) => print('User added'));
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: Email, password: Password);
                        } catch (e) {}
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FirstScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Center(
                  child: Text(data!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
