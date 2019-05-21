import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waka_friends/app/home.dart';
import 'package:waka_friends/auth/login.dart';
import 'package:waka_friends/auth/user_data_collector.dart';

import 'auth_validation.dart';

class User {
  var uid;
  String email;
  String firstName;
  String lastName;
  int age;
  String gender;

  storeNewUser(user, context) {
    formatData();
    Firestore.instance.collection('/users').add({
      'uid': user.uid,
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'age': this.age,
      'gender': this.gender
    }).then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage(userAuth: user)));
    }).catchError((e) {
      print(e);
    });
  }

  formatData() {
    firstName[0].toUpperCase();
    lastName[0].toUpperCase();
    gender[0].toUpperCase();
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

//TODO make _minmargin

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  var _minMargin = 5.0;

  LoginData _data = new LoginData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          )),
          Container(
            margin: EdgeInsets.only(right: 50.0, left: 50.0),
            child: Center(
                child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 120.0),
                    child: Text(
                      "Sign up",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 120.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: Validator().validateEmail,
                      onSaved: (String val) => this._data.email = val,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Password"),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      autocorrect: false,
                      validator: Validator().validatePassword,
                      onSaved: (String val) => this._data.password = val,
                    ),
                  ),
                  Expanded(child: Text("")),
                  Container(
                    width: 150.0,
                    height: 40.0,
                    child: RaisedButton(
                        child: const Text("Register"), onPressed: registerUser),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50.0),
                    child: FlatButton(
                      child: Text("Login"),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    ),
                  )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  void registerUser() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _data.email, password: _data.password)
          .then((user) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserDataPage(receivedUsrData: user,)));
      }).catchError((e) {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("User with that email already exists")));
      });
    }
  }
}
