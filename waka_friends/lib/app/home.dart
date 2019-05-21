import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waka_friends/auth/registration.dart';
import 'package:waka_friends/menu/menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
    @required this.userAuth,
  }) : super(key: key);

  final FirebaseUser userAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .where('uid', isEqualTo: userAuth.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Text("Loading data...");
          else {
            User user = new User();
            user.uid = snapshot.data.documents[0]['uid'].toString();
            user.email = snapshot.data.documents[0]['email'].toString();
            user.firstName = snapshot.data.documents[0]['firstName'].toString();
            user.lastName = snapshot.data.documents[0]['lastName'].toString();
            user.age = snapshot.data.documents[0]['age'];
            user.gender = snapshot.data.documents[0]['gender'].toString();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(user.firstName.toString() +
                      " " +
                      user.lastName.toString()),
                  RaisedButton(
                    child: Text("LOGOUT"),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Menu()));
                      }).catchError((e) {
                        print(e);
                      });
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
