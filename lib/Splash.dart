import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'SecondScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// Platform Widget
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  final _auth = FirebaseAuth.instance;

  bool isLoading = true;

  late String Email;
  late String Password;


  GlobalKey<FormState> gg = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: gg,
          child: Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width, child: Image.asset('images/kk.png')),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(.0),
                      child: TextFormField(
                        onChanged: (value){
                          Email = value;
                        },

                        validator: (value){
                          if (value!.isEmpty){
                            return "Enter Email";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(.0),
                      child: TextFormField(
                        onChanged: (value){
                          Password = value;
                        },
                        validator: (value){
                          if (value!.isEmpty){
                            return "Enter Password";
                          }
                          return null ;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(150, 5, 10, 10),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(fontSize: 17, color: Colors.blueAccent),
                      )),
                ),
              ),

              BounceInLeft(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(width: MediaQuery.of(context).size.width,height: 50 ,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.purple, onPrimary: Colors.white),
                      onPressed: () async {
                        if(gg.currentState!.validate())
                          try {
                            final user = await _auth.signInWithEmailAndPassword(email: Email, password: Password);
                            showDialog(
                              context: context,
                              builder: (context){
                                return Center(child: CircularProgressIndicator());
                              },
                            );
                            if (Email != null){

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                    data: '',
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }

                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
              FadeInDown(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 60, 20, 20),
                  child: Row(
                    children: [
                      Text(
                        'Does not have any account ?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(width:150,height: 50 ,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple, onPrimary: Colors.white),
                            onPressed: () {
                              if (gg.currentState!.validate()) {
                              } else {}

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SecondScreen(
                                    data: '',
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 30),
                            ),
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
  }
}
