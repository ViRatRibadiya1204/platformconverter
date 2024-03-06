import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plc2/provaider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'mclass.dart';



class androidcontactlist extends StatefulWidget {
  const androidcontactlist({super.key});

  @override
  State<androidcontactlist> createState() => _androidcontactlistState();
}

class _androidcontactlistState extends State<androidcontactlist> {
  @override
  Widget build(BuildContext context) {
    final saveDataprovaider = Provider.of<platformConverter>(context, listen: true);
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            height: height,
            child: ListView.builder(
              itemCount: saveDataprovaider.contactDatalist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundImage: FileImage(saveDataprovaider.contactDatalist[index].image!),
                  ),
                  title: Text(saveDataprovaider.contactDatalist[index].name.toString()),
                  subtitle: Text(saveDataprovaider.contactDatalist[index].chat.toString()),
                  trailing: InkWell(onTap: () async {
                    final Uri url = Uri(
                      path: saveDataprovaider.contactDatalist[index].number,
                      scheme: 'tel');
                    await launchUrl(url);

                  },
                    child: Icon(
                      Icons.call,
                      color: Colors.green,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
