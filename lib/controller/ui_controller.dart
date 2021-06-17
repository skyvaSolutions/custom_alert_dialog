//Provider for updating screen state for checkboxes, colors, etc

import 'dart:io';

import 'package:flutter/material.dart';

class UiController with ChangeNotifier{
  bool showDialogContent = true;
  bool showSizeAndColor = true;
  bool showImage = true;
  bool showContact = true;
  List<bool> bulletSelected = [true,false,false,false,false,false,false];
  bool emailCheck = false;
  bool phoneCheck = false;
  bool moreInfoChecked = false;
  Color bgColor = Colors.white;
  Color titleColor = Colors.black;
  Color bodyColor = Colors.black;
  bool showAdvancedSettings = false;
  double titleFontSize= 20.0;
  double bodyFontSize = 18.0;
  Image imageUploaded = Image.file(File(''));
  bool advButton = true;

  void changeShowDialogContent(){
    showDialogContent = true;
    notifyListeners();
  }
  void changeShowSizeAndColor(){
    showSizeAndColor = !showSizeAndColor;
    notifyListeners();
  }
  void changeShowImage(){
    showImage = !showImage;
    notifyListeners();
  }
  void changeShowContact(){
    showContact = !showContact;
    notifyListeners();
  }
  void changeShowAdvancedSettings(){
    showAdvancedSettings = !showAdvancedSettings;
    notifyListeners();
  }
  void changeTitleFontSize(double value){
    titleFontSize = value;
    notifyListeners();
  }
  void changeBodyFontSize(double value){
    bodyFontSize = value;
    notifyListeners();
  }
  void changeImage(Image image){
    imageUploaded = image;
    notifyListeners();
  }
  void changeAdvButtonVisibility(){
    advButton = !advButton;
    notifyListeners();
  }

  void changeBulletSelected(int index){
    for (int buttonIndex = 0; buttonIndex < bulletSelected.length; buttonIndex++) {
      if (buttonIndex == index) {
        bulletSelected[buttonIndex] = true;
      } else {
        bulletSelected[buttonIndex] = false;
      }
    }
    notifyListeners();
  }
  void changeEmailCheck(bool? value){
    emailCheck = value!;
    notifyListeners();
  }
  void changePhoneCheck(bool? value){
    phoneCheck = value!;
    notifyListeners();
  }
  void changeMoreInfoCheck(bool? value){
    moreInfoChecked = value!;
    notifyListeners();
  }

  void changeBgColor(Color newBgColor){
    bgColor = newBgColor;
    notifyListeners();
  }
  void changeTitleColor(Color newTitleColor){
    titleColor = newTitleColor;
    notifyListeners();
  }
  void changeBodyColor(Color newBodyColor){
    bodyColor = newBodyColor;
    notifyListeners();
  }

}