import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plc2/provaider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mclass.dart';

class ioscalls extends StatefulWidget {
  const ioscalls({super.key});

  @override
  State<ioscalls> createState() => _ioscallsState();
}

class _ioscallsState extends State<ioscalls> {
  @override
  Widget build(BuildContext context) {
    final saveDataprovaider = Provider.of<platformConverter>(context, listen: true);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
          itemCount: saveDataprovaider.contactDatalist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoListTile(
                onTap: () {

                },
                leadingSize: 50,
                leadingToTitle: 15,
                leading: CircleAvatar(
                  radius: 35,
                  backgroundImage: FileImage(saveDataprovaider.contactDatalist[index].image!),
                ),
                title: Text(
                  saveDataprovaider.contactDatalist[index].name.toString(),
                  style: TextStyle(fontSize: 25),
                ),
                subtitle: Text(
                  saveDataprovaider.contactDatalist[index].chat.toString(),
                  style: TextStyle(fontSize: 15),
                ),
                trailing: InkWell(onTap: () async {
                  final Uri url = Uri(
                      path: saveDataprovaider.contactDatalist[index].number,
                      scheme: 'tel');
                  await launchUrl(url);

                },
                  child: Icon(
                    CupertinoIcons.phone,
                    size: 25,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
