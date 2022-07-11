import 'package:firebase_tesst/Splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
      home: First(),
    );
  }
}

class First extends StatefulWidget {
  @override
  State<First> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<First> {

  bool isLoading = true;


  GlobalKey<FormState> gg = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'images/1.jpeg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstScreen(),
        ),
      ),
    );
  }
}
