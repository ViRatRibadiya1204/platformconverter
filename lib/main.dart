import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:platformconverter/iostheme.dart';
// import 'package:platformconverter/android_settings.dart';
// import 'package:platformconverter/provaider.dart';
import 'package:plc2/provaider.dart';
import 'package:provider/provider.dart';
import 'android_add_chat.dart';
import 'android_add_contect.dart';
import 'android_contect_list.dart';
import 'android_settings.dart';
import 'iostheme.dart';

void main() {
  runApp(Myapp());




  
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => platformConverter(),
        )
      ],
      child:
      Consumer<platformConverter>(builder: (context, provaidervar, child) {
        return (provaidervar.isConverter == true)
            ? CupertinoApp(
          theme: (provaidervar.istheme == false)
              ? CupertinoThemeData(
            brightness: Brightness.light,
          )
              : CupertinoThemeData(brightness: Brightness.dark),
          debugShowCheckedModeBanner: false,
          home: iostheme(),
        )
            : MaterialApp(
          theme: (provaidervar.istheme == true)
              ? ThemeData.dark()
              : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: Myhomepage(),
        );
      }),
    );
  }
}
class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  @override
  Widget build(BuildContext context) {
    final provar = Provider.of<platformConverter>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Switch(
                  value: provar.getPlatform,
                  onChanged: (value) {
                    Fluttertoast.showToast(
                        msg: "Ios Runing",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 20);
                    provar.setPlatform = value;
                  }),
            ],
            bottom: TabBar(
              tabs: [
                Icon(Icons.person_add),
                Text("CHATS"),
                Text("CALLS"),
                Text("SETTING")
              ],
            ),
            title: Text("Phone"),
          ),
          body: TabBarView(
            children: [
              androidaddcontact(initials: '',),

              androidchat(),
              androidcontactlist(),
              andsettings(),
            ],
          )),
    );
  }
}
