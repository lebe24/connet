
import '../../services/auth.dart';
import '../../shared/loading.dart';
import 'package:flutter/material.dart';

class  SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class  _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool _isHidden = true;


  // text field state
  String email = '';
  String password = '';

  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                            fontSize: 50.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(58.0, 155.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(
                          color: Colors.blue,
                            fontSize: 40.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(158.0, 125.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  )
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children:[
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
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,

                    onChanged: (val) {
                     setState(() => password = val);
                  },
                      decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _toggleVisibility,
                        icon: _isHidden ?Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              // fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                      obscureText: _isHidden,
                    ),
                ]
              ),
            ),
          ),
          SizedBox(height: 40.0),
          
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
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'Montserrat'
                  ),),
                  onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Could not sign in with those credentials';
                      });
                    }
                  }
                }
                ),
          ),
          SizedBox(height: 15.0),
          Center(
            child: InkWell(
                     onTap: () =>Navigator.of(context).pushNamed('/forgot'),
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          // fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  ),
          ),
          SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to Spotify ?',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                   onTap: () =>Navigator.of(context).pushNamed('/signup'),
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        // fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          SizedBox(height: 12.0),
            Center(
              child: Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ),
        ]
      ),
    );
  }

  Widget showAlert() {
    var _warning;
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

// @override
//   Widget build(BuildContext context) {
//     return loading ? Loading() : Scaffold(
//       backgroundColor: Colors.brown[100],
//       appBar: AppBar(
//         backgroundColor: Colors.brown[400],
//         elevation: 0.0,
//         title: Text('Sign in to Brew Crew'),
//         actions: <Widget>[
//           FlatButton.icon(
//             icon: Icon(Icons.person),
//             label: Text('Register'),
//             onPressed: () => widget.toggleView(),
//           ),
//         ],
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 20.0),
//               TextFormField(
//                 decoration: textInputDecoration.copyWith(hintText: 'email'),
//                 validator: (val) => val.isEmpty ? 'Enter an email' : null,
//                 onChanged: (val) {
//                   setState(() => email = val);
//                 },
//               ),
//               SizedBox(height: 20.0),
//               TextFormField(
//                 obscureText: true,
//                 decoration: textInputDecoration.copyWith(hintText: 'password'),
//                 validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
//                 onChanged: (val) {
//                   setState(() => password = val);
//                 },
//               ),
//               SizedBox(height: 20.0),
//               RaisedButton(
//                 color: Colors.pink[400],
//                 child: Text(
//                   'Sign In',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () async {
//                   if(_formKey.currentState.validate()){
//                     setState(() => loading = true);
//                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);
//                     if(result == null) {
//                       setState(() {
//                         loading = false;
//                         error = 'Could not sign in with those credentials';
//                       });
//                     }
//                   }
//                 }
//               ),
//               SizedBox(height: 12.0),
//               Text(
//                 error,
//                 style: TextStyle(color: Colors.red, fontSize: 14.0),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }


// ======================================================

// import '../../services/auth.dart';
// import '../../shared/constants.dart';
// import '../../shared/loading.dart';
// import 'package:flutter/material.dart';

// class SignIn extends StatefulWidget {

//   final Function toggleView;
//   SignIn({ this.toggleView });

//   @override
//   _SignInState createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {

//   final AuthService _auth = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   String error = '';
//   bool loading = false;

//   // text field state
//   String email = '';
//   String password = '';

//   @override
//   Widget build(BuildContext context) {
//     return loading ? Loading() : Scaffold(
//       backgroundColor: Colors.brown[100],
//       appBar: AppBar(
//         backgroundColor: Colors.brown[400],
//         elevation: 0.0,
//         title: Text('Sign in to Brew Crew'),
//         actions: <Widget>[
//           FlatButton.icon(
//             icon: Icon(Icons.person),
//             label: Text('Register'),
//             onPressed: () => widget.toggleView(),
//           ),
//         ],
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 20.0),
//               TextFormField(
//                 decoration: textInputDecoration.copyWith(hintText: 'email'),
//                 validator: (val) => val.isEmpty ? 'Enter an email' : null,
//                 onChanged: (val) {
//                   setState(() => email = val);
//                 },
//               ),
//               SizedBox(height: 20.0),
//               TextFormField(
//                 obscureText: true,
//                 decoration: textInputDecoration.copyWith(hintText: 'password'),
//                 validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
//                 onChanged: (val) {
//                   setState(() => password = val);
//                 },
//               ),
//               SizedBox(height: 20.0),
//               RaisedButton(
//                 color: Colors.pink[400],
//                 child: Text(
//                   'Sign In',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () async {
//                   if(_formKey.currentState.validate()){
//                     setState(() => loading = true);
//                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);
//                     if(result == null) {
//                       setState(() {
//                         loading = false;
//                         error = 'Could not sign in with those credentials';
//                       });
//                     }
//                   }
//                 }
//               ),
//               SizedBox(height: 12.0),
//               Text(
//                 error,
//                 style: TextStyle(color: Colors.red, fontSize: 14.0),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }