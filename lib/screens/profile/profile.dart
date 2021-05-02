import 'dart:io';

import 'package:app/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:app/auth/services/auth.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  Image image;

  pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    var _image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (_image != null) {
      setState(() {
        image = _image as Image ;
      });
      ImageSharedPrefs.saveImageToPrefs(
          ImageSharedPrefs.base64String(_image.readAsBytesSync()));
    } else {
      print('Error picking image!');
    }
  }

  loadImageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final imageKeyValue = prefs.getString(IMAGE_KEY);
    if (imageKeyValue != null) {
      final imageString = await ImageSharedPrefs.loadImageFromPrefs();
      setState(() {
        image = ImageSharedPrefs.imageFrom64BaseString(imageString);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadImageFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('Profile',
       style: TextStyle(
         color: Colors.black
       )),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              child:Stack(
                
                children: <Widget>[
                  CircleAvatar(
                    radius: 120,
                    backgroundColor: Color(0xff476cfb),
                    child:ClipOval(
                      child: SizedBox(
                      width: 250,
                      height: 250,
                        child: image == null ? Image.asset('assets/category/cnn-logo.png') : image,
                      )
                    )
                  ),
                   FloatingActionButton(
                    child: Icon(Icons.add_a_photo),
                    onPressed: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child:  Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                   ListTile(
                                    leading: new Icon(Icons.camera),
                                    title: new Text('Camera'),
                                    onTap: () {
                                      pickImage(ImageSource.camera);
                                      // this is how you dismiss the modal bottom sheet after making a choice
                                      Navigator.pop(context);
                                    },
                                  ),
                                   ListTile(
                                    leading: new Icon(Icons.image),
                                    title: new Text('Gallery'),
                                    onTap: () {
                                      pickImage(ImageSource.gallery);
                                      // dismiss the modal sheet
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ],),
              ),
              
            Container(
             
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin:
                      EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 12.0),
                  child: Icon(Icons.person,size: 40,color: Colors.blueAccent,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(.0),
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black, fontSize: 20.0),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.edit)),
              ) // This Icon
            ],
          ),
            ),
            Container(
              child: Column(
                children:[
                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(Icons.email,size: 30,color: Colors.blueAccent,),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Montserrat'
                    ))),
                    // Align(
                    //   padding: const EdgeInsets.only(left:180.0),
                    //   child: IconButton(
                    //     icon: Icon(Icons.edit) , onPressed: null),
                    // )
                  ],)
                ]
              ),),
            Container(
              child: Column(
                children:[
                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(Icons.lock,size: 30,color: Colors.blueAccent,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Montserrat'
                    ))),
                    // Align(
                    //   padding: const EdgeInsets.only(left:180.0),
                    //   child: IconButton(
                    //     icon: Icon(Icons.edit) , onPressed: null),
                    // )
                  ],)
                ]
              ),)
          ],
        ),
      ),
    );
  }
}
  // ===================================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.delete_forever),
//             onPressed: () {
//               ImageSharedPrefs.emptyPrefs();
//               setState(() {
//                 image = null;
//               });
//             },
//           ),
//         ],
//         title: Text('Image Shared Preferences'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: image == null ? Text('No image selected') : image,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add_a_photo),
//         onPressed: () {
//           showModalBottomSheet<void>(
//               context: context,
//               builder: (BuildContext context) {
//                 return SafeArea(
//                   child: new Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       new ListTile(
//                         leading: new Icon(Icons.camera),
//                         title: new Text('Camera'),
//                         onTap: () {
//                           pickImage(ImageSource.camera);
//                           // this is how you dismiss the modal bottom sheet after making a choice
//                           Navigator.pop(context);
//                         },
//                       ),
//                       new ListTile(
//                         leading: new Icon(Icons.image),
//                         title: new Text('Gallery'),
//                         onTap: () {
//                           pickImage(ImageSource.gallery);
//                           // dismiss the modal sheet
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               });
//         },
//       ),
//     );
//   }
// }
