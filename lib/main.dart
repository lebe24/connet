import 'package:app/auth/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'auth/models/user.dart';
import 'auth/screens/authenticate/forgot.dart';
import 'auth/screens/authenticate/reg.dart.dart';
import 'auth/services/auth.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Wrapper(),
        routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) =>  Register(),
        '/forgot': (BuildContext context) =>  Forgot()
      },
      ),
    );
  }
}

// import 'package:app/temp/temp4/util/key.dart';
// import 'package:flutter/material.dart';
// import 'package:youtube_api/youtube_api.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DemoApp(),
//     );
//   }
// }

// class DemoApp extends StatefulWidget {
//   @override
//   _DemoAppState createState() => _DemoAppState();
// }

// class _DemoAppState extends State<DemoApp> {
//   static String key = api_key;

//   YoutubeAPI ytApi = YoutubeAPI(key);
//   List<YT_API> ytResult = [];

//   callAPI() async {
//     String query = "Java";
//     ytResult = await ytApi.search(query);
//     ytResult = await ytApi.nextPage();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     callAPI();
//     print('hello');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Youtube API'),
//       ),
//       body: Container(
//         child: ListView.builder(
//           itemCount: ytResult.length,
//           itemBuilder: (_, int index) => listItem(index),
//         ),
//       ),
//     );
//   }

//   Widget listItem(index) {
//     return Card(
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 7.0),
//         padding: EdgeInsets.all(12.0),
//         child: Row(
//           children: <Widget>[
//             Image.network(
//               ytResult[index].thumbnail['default']['url'],
//             ),
//             Padding(padding: EdgeInsets.only(right: 20.0)),
//             Expanded(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                   Text(
//                     ytResult[index].title,
//                     softWrap: true,
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                   Padding(padding: EdgeInsets.only(bottom: 1.5)),
//                   Text(
//                     ytResult[index].channelTitle,
//                     softWrap: true,
//                   ),
//                   Padding(padding: EdgeInsets.only(bottom: 3.0)),
//                   Text(
//                     ytResult[index].url,
//                     softWrap: true,
//                   ),
//                 ]))
//           ],
//         ),
//       ),
//     );
//   }
// }
