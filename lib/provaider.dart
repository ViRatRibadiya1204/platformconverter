import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mclass.dart';

class platformConverter with ChangeNotifier{
  bool isConverter = false;
  bool svalue = false;
  bool istheme = false;
  List<contectdata> contactDatalist=[

  ];

  TextEditingController iosNameController = TextEditingController();
  TextEditingController iosBioController = TextEditingController();
  File? profileImge;
  File? contactfileImge;

  platformConverter(){
    getprofilenameSharePrefrence();
    getprofilebioSharePrefrence();
    getprofileimageSharePrefrence();

  }

getAlbumImage()async{
  final files = await imageHelper.pickImage();
  if (files.isNotEmpty) {
    final croppedFile = await imageHelper.crop(
      file: files.first!,
      cropStyle: CropStyle.circle,
    );
    if (croppedFile != null) {
      profileImge = File(croppedFile.path);
    }
  }
  notifyListeners();
}
getAlbumeimagecam()async{
    var proFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if(proFile != null){
      profileImge = File(proFile.path);
    }
    notifyListeners();
}
  getcontactalbumImage()async{
    final files = await imageHelper.pickImage();
    if (files.isNotEmpty) {
      final croppedFile = await imageHelper.crop(
        file: files.first!,
        cropStyle: CropStyle.circle,
      );
      if (croppedFile != null) {
        contactfileImge = File(croppedFile.path);
      }
    }
    notifyListeners();
  }
  getcontatccamraimagecam()async{
    var proFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if(proFile != null){
    contactfileImge = File(proFile.path);
    }
    notifyListeners();
  }

  set setPlatform(value){
    isConverter = value;
    notifyListeners();
  }
  get getPlatform{
    return isConverter;
  }
  set setprofil(value){
    svalue = value;
    notifyListeners();
  }
  get getprofil{
    return svalue;
  }
  set setTheme(value){
    istheme = value;
    notifyListeners();
  }
  get getTheme{
    return istheme;
  }
  savedata(value){
    contactDatalist.add(value);
    notifyListeners();
  }

  removedata(index){
    contactDatalist.removeAt(index);
    notifyListeners();
  }
  editcontactData(contectdata Data, index){
    contactDatalist[index]=(Data);
    notifyListeners();
  }

  setprofilenameSharePrefrence(value) async{
    SharedPreferences proshare = await SharedPreferences.getInstance();
    proshare.setString('proName', value);
  }
  getprofilenameSharePrefrence() async{
    SharedPreferences proshare = await SharedPreferences.getInstance();
    iosNameController.text = proshare.getString("proName") ?? "Enter your profile data";
  }

  setprofilbioSharePrefrence(value) async{
    SharedPreferences proshare = await SharedPreferences.getInstance();
    proshare.setString('proBio', value);
  }
  getprofilebioSharePrefrence() async{
    SharedPreferences proshare = await SharedPreferences.getInstance();
    iosBioController.text= proshare.getString('proBio') ?? "Enter your profile data";
  }
  setprofilimageSharePrefrence(value) async{
    SharedPreferences proshare = await SharedPreferences.getInstance();
    proshare.setString('proImage', value);
  }
  getprofileimageSharePrefrence() async{
    SharedPreferences proshare = await SharedPreferences.getInstance();
    profileImge= File((proshare.getString('proImage')??"Enter your Bio"));
  }

  removeimage(){
    profileImge=null;
    notifyListeners();
  }

}

