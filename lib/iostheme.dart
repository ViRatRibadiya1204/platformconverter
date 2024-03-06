// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// import 'package:platformconverter/ios_calls.dart';
// import 'package:platformconverter/ios_chats.dart';
// import 'package:platformconverter/ios_person_.dart';
// import 'package:platformconverter/ios_settings.dart';
// import 'package:platformconverter/main.dart';
//
// class iostheme extends StatefulWidget {
//   const iostheme({super.key});
//
//   @override
//   State<iostheme> createState() => _iosthemeState();
// }
//
// class _iosthemeState {
// }
//
//
// List<Widget> _tabs = [
//
// ];
// // class _iosthemeState extends State<iostheme> {
// //   final List<Widget> _tabs = [
// //     iosperson(),
// //     ioschats(),
// //     ioscalls(),
// //     iossettings(),
// //     // const HomeTab(), // see the HomeTab class below
// //     // const SettingTab() // see the SettingsTab class below
// //   ];
//
//   bool value = true;
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//
//       navigationBar: CupertinoNavigationBar(
//
//         middle: Text("Platform Converter"),
//         trailing: CupertinoSwitch(
//           value: value,
//           onChanged: (value) {
//             Fluttertoast.showToast(msg: "Android",
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.BOTTOM,
//                 fontSize: 20);
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => Myhomepage(),
//             ));
//           },
//         ),
//       ),
//       child: CupertinoTabScaffold(
//         tabBar: CupertinoTabBar(
//           items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_add_solid),),
//             BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_2),label: ('CHATS')),
//
//
//           ],
//         ), tabBuilder: (BuildContext context, int index) {
//           return CupertinoTabView(
//             builder: (BuildContext context) {
//               return _tabs[index];
//             },
//           );
//       },
//       )
//     );
//   }
// }
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'main.dart';
//
// class iostheme extends StatefulWidget {
//   const iostheme({super.key});
//
//   @override
//   State<iostheme> createState() => _iosthemeState();
// }
// List<Widget> _tabs = [
//
// ];
//
// class _iosthemeState extends State<iostheme> {
//   bool value = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       home: CupertinoNavigationBar(
//         middle: Text("Platform Converter"),
//         trailing: CupertinoSwitch(
//           value: value,
//           onChanged: (value) {
//             Fluttertoast.showToast(msg: "Android",
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.BOTTOM,
//                 fontSize: 20);
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => Myhomepage(),
//             ));
//           },
//         ),
//         child: CupertinoTabScaffold(
//           tabBar: CupertinoTabBar(
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.person_add_solid)),
//               BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.chat_bubble_2), label: ("CHATS")),
//             ],
//           ),
//           tabBuilder: (BuildContext context, int index) {
//             return CupertinoTabView(
//               builder: (BuildContext context){
//                 return _tabs[index];
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plc2/provaider.dart';
// import 'package:platformconverter/ios_calls.dart';
// import 'package:platformconverter/ios_chats.dart';
// import 'package:platformconverter/ios_person_.dart';
// import 'package:platformconverter/ios_settings.dart';
// import 'package:platformconverter/provaider.dart';
import 'package:provider/provider.dart';

import 'ios_calls.dart';
import 'ios_chats.dart';
import 'ios_person_.dart';
import 'ios_settings.dart';
import 'main.dart';

class iostheme extends StatefulWidget {
  const iostheme({super.key});

  @override
  State<iostheme> createState() => _iosthemeState();
}
List<Widget> _tebs = [
  iosperson(initials: '',),
  ioschats(),
  ioscalls(),
  iossettings(),
];

class _iosthemeState extends State<iostheme> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    final provaar = Provider.of<platformConverter>(context);
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Platform Converter"),
          trailing: CupertinoSwitch(
            value: provaar.getPlatform,
            onChanged: (value) {
              Fluttertoast.showToast(
                  msg: "Android",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  fontSize: 20);
             provaar.setPlatform=value;

            },
          ),
        ),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_add_solid)),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble_2), label: ("CHATS")),
              BottomNavigationBarItem(icon: Icon(Icons.call),label: ("CALLS")),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings),label: ("SETTINGS")),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context){
                return _tebs[index];
              },
            );
            // return _tebs[index];
          },
        ),
      );
  }
}
