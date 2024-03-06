import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plc2/provaider.dart';
// import 'package:platformconverter/provaider.dart';
import 'package:provider/provider.dart';

class iossettings extends StatefulWidget {
  const iossettings({super.key});

  @override
  State<iossettings> createState() => _iossettingsState();
}

class _iossettingsState extends State<iossettings> {

  @override
  Widget build(BuildContext context) {
    // final saveDataprovaider = Provider.of<platformConverter>(context, listen: true);
    final theme = Provider.of<platformConverter>(context, listen: true);
    var abc = MediaQuery.of(context).size.height;
    final profil = Provider.of<platformConverter>(context, listen: true);
    return Column(
      children: [
        Container(
          height: 50,
        ),
        SizedBox(
          height: 60,
        ),
        CupertinoListTile(
          leading: Icon(CupertinoIcons.person),
          title: Text("Profil"),
          subtitle: Text("Update Profile Data"),
          trailing: CupertinoSwitch(
            value: profil.getprofil,
            onChanged: (nvalue) {
              profil.setprofil = nvalue;
            },
          ),
        ),
        Visibility(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                showCupertinoModalPopup(context: context, builder: (builder){
                  return CupertinoActionSheet(
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoButton(child: Icon(CupertinoIcons.photo), onPressed: (){
                            theme.getAlbumImage();
                          }),
                          CupertinoButton(child: Icon(CupertinoIcons.camera), onPressed: (){
                            theme.getAlbumeimagecam();
                          })
                        ],
                      )
                    ],
                  );
                });
                },
                child: (theme.profileImge == null) ? CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.yellow,
                ): CircleAvatar(
                  radius: 80,backgroundImage: FileImage(theme.profileImge!),
                ),
              ),
              CupertinoFormRow(
                child: CupertinoTextField(
                  textAlign: TextAlign.center,
                  placeholder: "Name",
                  controller: theme.iosNameController,
                ),

                // error: Text('Must be 8 digit long'),
              ),
              CupertinoFormRow(
                child: CupertinoTextField(
                  textAlign: TextAlign.center,
                  placeholder: "Bio",
                  controller: theme.iosBioController,
                ),

                // error: Text('Must be 8 digit long'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(child: Text("SAVE"), onPressed: (){

                    // saveDataprovaider.setprofilenameSharePrefrence(saveDataprovaider.iosNameController.text);
                    theme.setprofilenameSharePrefrence(theme.iosNameController.text);
                    theme.setprofilbioSharePrefrence(theme.iosBioController.text);
                    theme.setprofilimageSharePrefrence(theme.profileImge);


                  }),
                  CupertinoButton(child: Text("CLEAR"), onPressed: (){
                  theme.iosNameController.clear();
                  theme.iosBioController.clear();
                  setState(() {
                    theme.profileImge=null;
                  });

                  }),

                ],
              )
            ],
          ),
          visible: profil.getprofil,
        ),
        CupertinoListTile(
          leading: Icon(CupertinoIcons.person),
          title: Text("Profil"),
          subtitle: Text("Update Profile Data"),
          trailing: CupertinoSwitch(
            value: theme.getTheme,
            onChanged: (v) {
             theme.setTheme=v;
            },
          ),
        ),
      ],

    );
  }
}
