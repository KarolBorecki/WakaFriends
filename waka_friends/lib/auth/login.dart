import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waka_friends/app/home.dart';
import 'package:waka_friends/auth/registration.dart';

import 'auth_validation.dart';

class LoginData {
  String email = "";
  String password = "";
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

//TODO make _minmargin

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  var _minMargin = 5.0;

  LoginData _data = new LoginData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      "Sign in",
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
                        child: const Text("Login"), onPressed: authorizeUser),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50.0),
                    child: FlatButton(
                      child: Text("Register"),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
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

  void authorizeUser() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _data.email, password: _data.password)
          .then((user) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage(userAuth: user)));
      }).catchError((e) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text("Problem while logging in.", style: TextStyle(color: Colors.deepOrange),textAlign: TextAlign.center,), backgroundColor: Colors.transparent,));
      });
    }
  }
}
