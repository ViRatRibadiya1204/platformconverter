import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plc2/provaider.dart';
// import 'package:platformconverter/provaider.dart';
import 'package:provider/provider.dart';

class andsettings extends StatefulWidget {
  const andsettings({super.key});

  @override
  State<andsettings> createState() => _andsettingsState();
}

class _andsettingsState extends State<andsettings> {
  bool value = false;
  // bool valuee = true;

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<platformConverter>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Container(
              width: 360,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                subtitle: Text("Update Profile Data"),
                trailing: Switch(
                  value: value,
                  onChanged: (vlaue) {
                    setState(() {
                      value = vlaue;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        // Visibility(
        //   child: CircleAvatar(
        //             radius: 100,
        //             child: Icon(
        //               Icons.add_a_photo_outlined,
        //               size: 60,
        //             ),
        //     ),
        //   visible: value,
        // ),
        // SizedBox(height: ,),
        Visibility(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (buildr){
                    return Container(
                      height: 300,
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            theme.getAlbumImage();
                          }, icon: Icon(Icons.photo)),
                          IconButton(onPressed: (){
                            theme.getAlbumeimagecam();
                          }, icon: Icon(Icons.camera))
                        ],
                      ),
                    );
                  });
                },
                child:(theme.profileImge == null)?(CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.yellow,
                )): CircleAvatar(
                  radius: 100,
                  backgroundImage: FileImage(theme.profileImge!),
                ),
              ),
              TextFormField(
                controller: theme.iosNameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Entar your name..."),
              ),
              TextFormField(
                controller: theme.iosBioController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Enter your Bio..."),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          theme.setprofilenameSharePrefrence(theme.iosNameController.text);
                          theme.setprofilbioSharePrefrence(theme.iosBioController.text);
                          // theme.setprofilimageSharePrefrence(theme.profileImge);
                          theme.setprofilimageSharePrefrence(theme.profileImge);

                        },
                        child: Text("SAVE")),
                    SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(onPressed: () {
                      theme.iosNameController.clear();
                      theme.iosBioController.clear();
                      setState(() {
                        theme.profileImge=null;
                      });
                    },
                    child: Text("CLEAR")),
                  ],
                ),
              )
            ],
          ),
          visible: value,
        ),

        ListTile(
            leading: Icon(CupertinoIcons.brightness),
            title: Text("Theme"),
            subtitle: Text("Change Theme"),
            trailing: Switch(
              value: theme.getTheme,
              onChanged: (v) {
                theme.setTheme=v;
              },
            ))
      ],
    );
  }
}
