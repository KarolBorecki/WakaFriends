import 'package:flutter/material.dart';
import 'package:waka_friends/auth/login.dart';
import 'package:waka_friends/auth/registration.dart';

//TODO make _minmargin

class Menu extends StatelessWidget {
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
        Center(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 120.0),
                  child: Text(
                    "Waka Friends",
                    style: Theme.of(context).textTheme.display1,
                  )),
              Expanded(child: Text("")),
              Container(
                width: 190.0,
                height: 40.0,
                margin: EdgeInsets.only(bottom: 20.0),
                child: OutlineButton(
                    child: const Text("Login"),
                    color: Colors.transparent,
                    borderSide: BorderSide(color: Colors.white54),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }),
              ),
              Container(
                width: 200.0,
                height: 40.0,
                margin: EdgeInsets.only(bottom: 100.0),
                child: RaisedButton(
                    child: Text("Register"),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    }),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
