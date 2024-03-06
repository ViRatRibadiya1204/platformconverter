import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plc2/provaider.dart';
import 'package:provider/provider.dart';

import 'mclass.dart';
var EditiosTime;
var EditiosDate;
class ioschats extends StatefulWidget {
  const ioschats({super.key});

  @override
  State<ioschats> createState() => _ioschatsState();
}

class _ioschatsState extends State<ioschats> {
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
  TextEditingController _editiosnameControlar = TextEditingController();
  TextEditingController _editiosNumberControlar = TextEditingController();
  TextEditingController _editioschatControlar = TextEditingController();
  File? _eiosimage;
  var _editiosdate;
  var _editiostime;
  int? iosindex;
  @override
  Widget build(BuildContext context) {
    final saveDataprovaider = Provider.of<platformConverter>(context, listen: true);
    return Center(

      child:ListView.builder(
        itemCount: saveDataprovaider.contactDatalist.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoListTile(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                          FileImage(saveDataprovaider.contactDatalist[index].image!),
                        ),
                        Text(
                          saveDataprovaider.contactDatalist[index].name.toString(),
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          saveDataprovaider.contactDatalist[index].chat.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _editiosnameControlar.text = saveDataprovaider.contactDatalist[index].name!;
                                  _editiosNumberControlar.text = saveDataprovaider.contactDatalist[index].number!;
                                  _editioschatControlar.text = saveDataprovaider.contactDatalist[index].chat!;
                                  _eiosimage = saveDataprovaider.contactDatalist[index].image!;
                                  _editiosdate = saveDataprovaider.contactDatalist[index].cdate!;
                                  _editiostime = saveDataprovaider.contactDatalist[index].ctime!;
                                  iosindex = index;
                                  showCupertinoDialog(context: context, builder: (context) {
                                    return CupertinoAlertDialog(
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 60,
                                                backgroundImage: FileImage(_eiosimage!),
                                              ),
                                              CupertinoFormRow(
                                                child: CupertinoTextFormFieldRow(
                                                  controller: _editiosnameControlar,
                                                  placeholder: "Name",
                                                  // obscureText: true,
                                                ),
                                                padding: EdgeInsets.only(right: 5, left: 5, top: 10),
                                                prefix: Icon(CupertinoIcons.person),
                                                // error: Text('Must be 8 digit long'),
                                              ),
                                              CupertinoFormRow(
                                                child: CupertinoTextFormFieldRow(
                                                  controller: _editiosNumberControlar,
                                                  placeholder: "Number",
                                                  // obscureText: true,
                                                ),
                                                padding: EdgeInsets.only(right: 5, left: 5, top: 10),
                                                prefix: Icon(CupertinoIcons.phone),
                                                // error: Text('Must be 8 digit long'),
                                              ),
                                              CupertinoFormRow(
                                                child: CupertinoTextFormFieldRow(
                                                  controller: _editioschatControlar,
                                                  placeholder: "Chat",
                                                  // obscureText: true,
                                                ),
                                                padding: EdgeInsets.only(right: 5, left: 5, top: 10),
                                                prefix: Icon(CupertinoIcons.chat_bubble_text),

                                                // error: Text('Must be 8 digit long'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5, top: 15),
                                                child: GestureDetector(
                                                  onTap: () => _showDialog(
                                                    CupertinoDatePicker(
                                                      onDateTimeChanged: (DateTime value){
                                                        setState(() {
                                                          EditiosDate = DateFormat('dd/MM/yyyy').format(value);
                                                        });
                                                      },
                                                      mode: CupertinoDatePickerMode.date,
                                                      use24hFormat: false,
                                                      initialDateTime: DateTime.now(),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(CupertinoIcons.calendar),
                                                      (EditiosDate == null)
                                                          ?Text(_editiosdate)
                                                          : Text('Pick Date')
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5, top: 10),
                                                child: GestureDetector(
                                                  onTap: () => _showDialog(
                                                    CupertinoDatePicker(

                                                      onDateTimeChanged: (DateTime value){
                                                        setState(() {
                                                          EditiosTime = DateFormat('HH : mm').format(value);

                                                        });
                                                      },
                                                      mode: CupertinoDatePickerMode.time,
                                                      use24hFormat: false,
                                                      initialDateTime: DateTime.now(),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(CupertinoIcons.time),
                                                      (EditiosTime == null)
                                                          ? Text(_editiostime)
                                                          :Text("Pick Time")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              CupertinoButton(child: Text("Edit"), onPressed:(){
                                                contectdata ioseditcontact = contectdata(name: _editiosnameControlar.text, number: _editiosNumberControlar.text, chat: _editioschatControlar.text, image: _eiosimage, cdate: EditiosDate, ctime: EditiosTime);
                                                saveDataprovaider.editcontactData(ioseditcontact, index);
                                                Navigator.of(context).pop();
                                              })
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },);
                                }, icon: Icon(Icons.edit)),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  saveDataprovaider.removedata(index);
                                  Navigator.of(context).pop();
                                },
                                child: Icon(CupertinoIcons.delete_solid))
                          ],
                        )
                      ],
                    ),
                  ),
                );
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
              trailing: Row(
                children: [
                  Text(saveDataprovaider.contactDatalist[index].cdate.toString()),
                  Text(" ~ "),
                  Text(saveDataprovaider.contactDatalist[index].ctime.toString()),
                ],
              )
            ),
          );
        },
      ),
    );
  }
}
