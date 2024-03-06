import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:plc2/android_add_contect.dart';
import 'package:plc2/provaider.dart';
import 'package:provider/provider.dart';

import 'mclass.dart';

var iosTime;
var iosDate;

var timeformetios;
var dateformetios;
class iosperson extends StatefulWidget {
  const iosperson({super.key, required this.initials});
  final String initials;
  @override
  State<iosperson> createState() => _iospersonState();
}

class _iospersonState extends State<iosperson> {
  File? _image;
  DateTime time = DateTime(2016, 5, 10, 22, 35);
  DateTime date = DateTime(2016, 10, 26);

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

  TextEditingController _nameiosController = TextEditingController();
  TextEditingController _numberiosController = TextEditingController();
  TextEditingController _chatiosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final saveDataprovaider = Provider.of<platformConverter>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 130),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()  {
              showCupertinoModalPopup(context: context, builder: (builder){
                return Container(
                  height: 300,
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        // setState(() async {
                        //   final files = await imageHelper.pickImage();
                        //   if (files.isNotEmpty) {
                        //     final croppedFile = await imageHelper.crop(
                        //       file: files.first!,
                        //       cropStyle: CropStyle.circle,
                        //     );
                        //     if (croppedFile != null) {
                        //       setState(() => _image = File(croppedFile.path));
                        //     }
                        //   }
                        // });
                        saveDataprovaider.getcontactalbumImage();
                      }, icon: Icon(Icons.photo)),
                      IconButton(onPressed: (){
                        saveDataprovaider.getcontatccamraimagecam();
                      }, icon: Icon(Icons.camera))
                    ],
                  ),
                );
              });
            },
            child: CircleAvatar(
              radius: 80,
              backgroundImage: saveDataprovaider.contactfileImge != null ? FileImage(saveDataprovaider.contactfileImge!) : null,
              // child: _image == null
              //     ? Text(
              //         widget.initials,
              //         style: TextStyle(fontSize: 40),
              //       )
              //     : Container(),
            ),
          ),
          CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
              controller: _nameiosController,
              placeholder: "Name",
              // obscureText: true,
            ),
            padding: EdgeInsets.only(right: 5, left: 5, top: 40),
            prefix: Icon(CupertinoIcons.person),
            // error: Text('Must be 8 digit long'),
          ),
          CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
              controller: _numberiosController,
              placeholder: "Number",
              // obscureText: true,
            ),
            padding: EdgeInsets.only(right: 5, left: 5, top: 10),
            prefix: Icon(CupertinoIcons.phone),
            // error: Text('Must be 8 digit long'),
          ),
          CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
              controller: _chatiosController,
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
                      iosDate = DateFormat('dd/MM/yyyy').format(value);
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
                  (iosDate != null)
                  ?Text(iosDate.toString())
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
                     iosTime = DateFormat('HH : mm').format(value);

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
                  (iosTime != null)
                  ? Text(iosTime.toString())
                      :Text("Pick Time")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
              color: Colors.blue,
              child: Text("SAVE"),
              onPressed: () {
                setState(() {
                  contectdata ioscontact = contectdata(
                      name: _nameiosController.text,
                      number: _numberiosController.text,
                      chat: _chatiosController.text,
                      image: saveDataprovaider.contactfileImge,
                      cdate: iosDate,
                      ctime: iosTime);
                  saveDataprovaider.savedata(ioscontact);
                  _nameiosController.clear();
                  _numberiosController.clear();
                  _chatiosController.clear();
                  setState(() {
                    saveDataprovaider.contactfileImge=null;
                  });
                  iosTime = null;
                  iosDate = null;
                });
              })
        ],
      ),
    );
  }
}
