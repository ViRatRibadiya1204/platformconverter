import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plc2/provaider.dart';
import 'package:provider/provider.dart';

import 'mclass.dart';
var dateAlert;
var timeAlert;
var dateformetAlert;
var datepickerAlert;
var timeformetAlert;
class androidchat extends StatefulWidget {
  const androidchat({super.key});

  @override
  State<androidchat> createState() => _androidchatState();
}

class _androidchatState extends State<androidchat> {





  TextEditingController _editnameControlar = TextEditingController();
  TextEditingController _editNumberControlar = TextEditingController();
  TextEditingController _editchatControlar = TextEditingController();
  File? _eimage;
  var _editdate;
  var _edittime;
  int? eindex;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final saveDataprovaider = Provider.of<platformConverter>(context, listen: true);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            height: height,
            child: ListView.builder(
              itemCount: saveDataprovaider.contactDatalist.length,
              itemBuilder:(context, index){
                return InkWell(
                  onTap: (){
                    showModalBottomSheet(context: context, builder:(BuildContext context){
                      return Container(
                        height: 330,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(saveDataprovaider.contactDatalist[index].image!),
                            ),
                            Text(saveDataprovaider.contactDatalist[index].name.toString(),style: TextStyle(fontSize: 25),),
                            Text(saveDataprovaider.contactDatalist[index].chat.toString(),style: TextStyle(fontSize: 18),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(onPressed: (){
                                  Navigator.of(context).pop();
                                  _editnameControlar.text = saveDataprovaider.contactDatalist[index].name!;
                                  _editNumberControlar.text=saveDataprovaider.contactDatalist[index].number!;
                                  _editchatControlar.text=saveDataprovaider.contactDatalist[index].chat!;
                                  _eimage = saveDataprovaider.contactDatalist[index].image!;
                                  _editdate = saveDataprovaider.contactDatalist[index].cdate!;
                                  _edittime =saveDataprovaider.contactDatalist[index].ctime!;
                                  eindex = index;
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(

                                      title: const Text(
                                          'Edit'),
                                      actions: <Widget>[
                                        Column(
                                          children: [
                                            CircleAvatar(
                                             backgroundImage: FileImage(_eimage!),
                                              radius: 60,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              controller: _editnameControlar,
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                      Icons.person),
                                                  enabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                      BorderSide(
                                                          width:
                                                          1)),
                                                  hintText: "Name"),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(controller: _editNumberControlar,
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                      Icons.call),
                                                  enabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                      BorderSide(
                                                          width:
                                                          1)),
                                                  hintText: "Number"),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(controller: _editchatControlar,
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons
                                                      .chat_outlined),
                                                  enabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                      BorderSide(
                                                          width:
                                                          1)),
                                                  hintText: "Chat"),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            InkWell(
                                              onTap: () async {
                                                dateAlert =
                                                await showDatePicker(
                                                  context: context,
                                                  firstDate: DateTime(1990),
                                                  lastDate: DateTime(2050),
                                                  initialDate: DateTime.now(),
                                                );
                                                print(dateAlert);
                                                if (dateAlert != null) {
                                                  setState(() {
                                                    dateformetAlert = DateFormat('dd/MM/yyyy').format(dateAlert);
                                                  });
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(Icons.date_range_outlined),
                                                  (dateformetAlert == null) ? Text(_editdate) : Text("Pick Date"),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            timeAlert = await showTimePicker(
                                                context: context, initialTime: TimeOfDay.now());
                                            print(timeformetAlert);
                                            if (timeAlert != null) {
                                              datepickerAlert = DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month,
                                                  DateTime.now().day,
                                                  timeAlert.hour,
                                                  timeAlert.minute);
                                              setState(() {
                                                timeformetAlert = DateFormat('HH : mm').format(datepickerAlert);
                                              });
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(CupertinoIcons.clock),
                                              (timeformetAlert != null) ? Text("Pick Time") : Text(_edittime),
                                            ],
                                          ),
                                        ),

                                        TextButton(
                                          onPressed: () {
                                         contectdata editcontact = contectdata(name: _editnameControlar.text, number: _editNumberControlar.text, chat: _editchatControlar.text, image: _eimage, cdate: dateformetAlert, ctime: timeformetAlert);
                                          saveDataprovaider.editcontactData(editcontact, index);
                                          Navigator.of(context).pop();
                                    },



                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  }
                                  );
                                 },

                                 icon: Icon(Icons.edit)),
                                SizedBox(width: 10,),
                                IconButton(onPressed: (){
                                 saveDataprovaider.removedata(index);
                                  Navigator.of(context).pop();
                                }, icon: Icon(Icons.delete))
                              ],
                            )
                          ],
                        ),
                      );
                    });
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: FileImage(saveDataprovaider.contactDatalist[index].image!),
                    ),
                    title: Text(saveDataprovaider.contactDatalist[index].name.toString()),
                    subtitle: Text(saveDataprovaider.contactDatalist[index].chat.toString()),
                    trailing: Text("${saveDataprovaider.contactDatalist[index].cdate.toString()} ${saveDataprovaider.contactDatalist[index].ctime.toString()}"),
                  ),
                );
              }
              ,),
          )
        ],
      ),
    );
  }
}



// context: context,
// builder: (context) =>
// AlertDialog(
// title: const Text(
// 'Edit'),
// actions: <Widget>[
// Column(
// children: [
// CircleAvatar(
// backgroundColor:
// Colors.yellow,
// radius: 60,
// ),
// SizedBox(
// height: 10,
// ),
// TextFormField(
// decoration: InputDecoration(
// prefixIcon: Icon(
// Icons.person),
// enabledBorder:
// OutlineInputBorder(
// borderSide:
// BorderSide(
// width:
// 1)),
// hintText: "Name"),
// ),
// SizedBox(
// height: 5,
// ),
// TextFormField(
// decoration: InputDecoration(
// prefixIcon: Icon(
// Icons.call),
// enabledBorder:
// OutlineInputBorder(
// borderSide:
// BorderSide(
// width:
// 1)),
// hintText: "Number"),
// ),
// SizedBox(
// height: 5,
// ),
// TextFormField(
// decoration: InputDecoration(
// prefixIcon: Icon(Icons
//     .chat_outlined),
// enabledBorder:
// OutlineInputBorder(
// borderSide:
// BorderSide(
// width:
// 1)),
// hintText: "Chat"),
// ),
// SizedBox(
// height: 5,
// ),
//
// InkWell(
// onTap: () async {
// dateAlert =
// await showDatePicker(
// context: context,
// firstDate: DateTime(1990),
// lastDate: DateTime(2050),
// initialDate: DateTime.now(),
// );
// print(dateAlert);
// if (dateAlert != null) {
// setState(() {
// dateformetAlert = DateFormat('dd/MM/yyyy').format(dateAlert);
// });
// }
// },
// child: Row(
// children: [
// Icon(Icons.date_range_outlined),
// (dateformetAlert == null) ? Text("Pick Date") : Text(dateformetAlert),
// ],
// ),
// ),
//
// ],
// ),
// TextButton(
// onPressed: () =>
// Navigator.pop(
// context, 'Cancel'),
// child: const Text('Cancel'),
// ),
// TextButton(
// onPressed: () =>
// Navigator.pop(
// context, 'OK'),
// child: const Text('OK'),
// ),
// ],
// ),
// )