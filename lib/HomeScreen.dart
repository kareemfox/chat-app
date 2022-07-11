import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tesst/Splash.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  String? data;

  HomeScreen({Key? key, this.data}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User = FirebaseAuth.instance.currentUser!;

  late String First_Name;
  late String Last_Name;

  // int a = int.parse(First_Name.trim());

  final NameController = TextEditingController();

  final Stream<QuerySnapshot> Users =
  FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    final users = FirebaseFirestore.instance.collection('users');
    int pageIndex = 0;

    return DefaultTabController(
      initialIndex: pageIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(
            'Welcome',
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.w900),
          ),
          centerTitle: true,
          bottom: TabBar(
            onTap: (newVal) {
              setState(() {
                pageIndex = newVal;
              });
            },
            tabs: [
              Tab(text: 'User Data', icon: Icon(Icons.person)),
              Tab(
                text: 'Browsing',
                icon: Icon(Icons.home),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(115, 20, 115, 20),
                child: Column(
                  children: [
                    Text(
                      'Signed in as :',
                      style: TextStyle(fontSize: 23),
                    ),
                    SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Text(
                            User.email!,
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Container(
                        width: 600,
                        height: 300,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Users,
                          builder: (
                              BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot,
                              ) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong.');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text('Loading...');
                            }
                            final data = snapshot.requireData;
                            print('@@@@@@@@@@@@@@@@@@@22 ${snapshot.data!.docs.length}');
                            return ListView.builder(
                              itemCount: data.size,
                              itemBuilder: (context, index) {
                                return Text(
                                  'First Name: ${data.docs[index]['FirstName']} .. Last Name: ${data.docs[index]['LastName']} ',
                                  style: TextStyle(fontSize: 15),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                      child: TextFormField(
                        onChanged: (value) {
                          First_Name = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Update First Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),

                    /// text
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: TextFormField(
                        onChanged: (value) {
                          Last_Name = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Update Last Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue, onPrimary: Colors.white),
                        onPressed: () async {
                          await users.add({
                            'FirstName': First_Name,
                            'LastName': Last_Name,
                          }).then((value) => print('User added'));
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              border:
                              Border.all(width: 1.0, color: Colors.blue)),
                          child: SizedBox(
                            width: 400,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FirstScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign Out",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Text('...')
          ],
        ),
      ),
    );
  }
}
