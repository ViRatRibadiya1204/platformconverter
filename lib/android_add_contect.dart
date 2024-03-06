import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:intl/intl.dart';
import 'package:plc2/android_contect_list.dart';
import 'package:plc2/provaider.dart';
import 'package:provider/provider.dart';

import 'mclass.dart';

var date;
var time;
var dateformet;
var datepicker;
var timeformet;

class androidaddcontact extends StatefulWidget {
  const androidaddcontact({super.key, required this.initials});

  final String initials;
  @override
  State<androidaddcontact> createState() => _androidaddcontactState();
}

class _androidaddcontactState extends State<androidaddcontact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _chatController = TextEditingController();

  File? _image;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final saveDataprovaider =
        Provider.of<platformConverter>(context, listen: true);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  showModalBottomSheet(context: context, builder: (builder){
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
                  radius: 70,
                  backgroundImage: saveDataprovaider.contactfileImge != null ? FileImage(saveDataprovaider.contactfileImge!) : null,
                  // child: _image == null
                  //     ? Text(
                  //         widget.initials,
                  //         style: TextStyle(fontSize: 40),
                  //       )
                  //     : Container(),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Name';
                  }
                },
                controller: _nameController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    hintText: "Full Name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Number";
                  }
                },
                controller: _numberController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.call),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    hintText: "Phone Number"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Chat";
                  }
                },
                controller: _chatController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.chat_outlined),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    hintText: "Chat Conversation"),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2050),
                    initialDate: DateTime.now(),
                  );
                  print(date);
                  if (date != null) {
                    setState(() {
                      dateformet = DateFormat('dd/MM/yyyy').format(date);
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.date_range_outlined),
                    (dateformet == null) ? Text("Pick Date") : Text(dateformet),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  print(timeformet);
                  if (time != null) {
                    datepicker = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        time.hour,
                        time.minute);
                    setState(() {
                      timeformet = DateFormat('HH : mm').format(datepicker);
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(CupertinoIcons.clock),
                    (timeformet == null) ? Text("Pick Time") : Text(timeformet),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {

                    if(saveDataprovaider.contactfileImge != null) {
                      if(dateformet != null) {
                        if(timeformet != null) {
                          if (formkey.currentState!.validate()) {
                            contectdata contact = contectdata(
                                name: _nameController.text,
                                number: _numberController.text,
                                chat: _chatController.text,
                                image: saveDataprovaider.contactfileImge!,
                                cdate: dateformet,
                                ctime: timeformet);
                            saveDataprovaider.savedata(contact);
                            _nameController.clear();
                            _chatController.clear();
                            _numberController.clear();
                            dateformet = null;
                            timeformet = null;
                            setState(() {
                              saveDataprovaider.contactfileImge=null;
                            });

                            Fluttertoast.showToast(
                              msg: 'Contatct Add',
                              fontSize: 20,
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_LONG,
                            );
                          };
                        }else{
                          Fluttertoast.showToast(
                            msg: 'Time Not Add',
                            fontSize: 20,
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                      }else{
                        Fluttertoast.showToast(
                          msg: 'Date Not Add',
                          fontSize: 20,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                        );
                      }
                    }else{
                        Fluttertoast.showToast(
                          msg: 'Image Not Add',
                          fontSize: 20,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                        );
                        }

                  },
                  child: Text("SAVE")),
            ],
          ),
        ),
      ),
    );
  }
}
