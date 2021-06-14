import 'package:flutter/material.dart';

class UiController with ChangeNotifier{
  bool showDialogContent = true;
  bool showSizeAndColor = false;
  bool showImage = false;
  bool showContact = false;
  List<bool> bulletSelected = [true,false,false,false,false];
  bool emailCheck = false;
  bool phoneCheck = false;
  Color bgColor = Colors.white;
  Color titleColor = Colors.black;
  Color bodyColor = Colors.black54;

  void changeShowDialogContent(){
    showDialogContent = true;
    notifyListeners();
  }
  void changeShowSizeAndColor(){
    showSizeAndColor = true;
    notifyListeners();
  }
  void changeShowImage(){
    showImage = true;
    notifyListeners();
  }
  void changeShowContact(){
    showContact = true;
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