import 'package:flutter/material.dart';
import 'package:waka_friends/auth/auth_validation.dart';
import 'package:waka_friends/auth/registration.dart';

class UserDataPage extends StatefulWidget {
  UserDataPage({
    Key key,
    @required
    this.receivedUsrData,
  });

  final receivedUsrData;

  @override
  _UserDataPageState createState() => _UserDataPageState(receivedUsrData: receivedUsrData);
}

//TODO make _minmargin

class _UserDataPageState extends State<UserDataPage> {
  _UserDataPageState({
    Key key,
    @required
    this.receivedUsrData,
  });

  final receivedUsrData;
  User _userData = new User();

  final _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var _minMargin = 5.0;

  static var genders = ["  Male", "  Female"];
  var actualGender = genders[0];

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
                      "Fill:",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 80.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "First name"),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                        validator: Validator().validateText,
                        onSaved: (String val){_userData.firstName = val;}
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Last name"),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      validator: Validator().validateText,
                      onSaved: (String val){_userData.lastName = val;},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: 140.0,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Age"),
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            validator: Validator().validateNumber,
                            onSaved: (String val){_userData.age = int.parse(val);},
                          ),
                        ),
                        Expanded(child: Text("")),
                        Container(
//                          decoration: ShapeDecoration(shape: RoundedRectangleBorder(
//                            side: BorderSide(color: Colors.white70),
//                            borderRadius: BorderRadius.circular(40.0),
//                          )),
                          width: 140.0,
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: actualGender,
                                items: genders
                                    .map<DropdownMenuItem<String>>((String val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val,
                                    style: TextStyle(color: Colors.white70),),
                                  );
                                }).toList(),
                                onChanged: (String val) {
                                  setState(() {
                                    actualGender = val;
                                  }
                                  );
                                },
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Text("")),
                  Container(
                    width: 150.0,
                    height: 40.0,
                    margin: EdgeInsets.only(bottom: 55.0),
                    child: RaisedButton(
                        child: const Text("Done"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _userData.email = receivedUsrData.email;
                            _userData.gender = actualGender;
                            _userData.storeNewUser(receivedUsrData, context);
                          }
                        }),
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
