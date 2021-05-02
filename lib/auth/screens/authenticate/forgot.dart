import 'package:app/auth/services/auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String _warning = '';

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child:Row(
                    children:[
                      Text(
                    'Rest',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Password',
                    style:
                        TextStyle(color:Colors.blue,fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  ]
                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(209.0, 99.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                   validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                    setState(() => email = val);
                   },
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              // fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                SizedBox(height: 10.0),
                Center(
                  child: RaisedButton(
                      elevation: 5.0,
                      splashColor: Colors.white30,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black),
                      ),
                  padding: EdgeInsets.only(left:130.0,right:130),
                  child: Text(
                  'SEND',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'Montserrat'
                  )),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      dynamic result = await _auth.sendPasswordResetEmail(email);
                      if(result == null) {
                      setState(() {
                        error = 'Could not reset password  with those credentials';
                      });
                    }else{
                      showAlert();
                    }
                    }
                  // if(_formKey.currentState.validate()){
                  //   setState(() => loading = true);
                  //   dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                  //   if(result == null) {
                  //     setState(() {
                  //       loading = false;
                  //       error = 'Could not sign in with those credentials';
                  //     });
                  //   }
                  // }
                }
                ),
          ),
          SizedBox(height: 10.0),
              Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: 
                        
                            Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // fontFamily: 'Montserrat'
                              )),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            // Expanded(
            //   child: AutoSizeText(
            //     _warning,
            //     maxLines: 3,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}