//Provider for updating screen state for checkboxes, colors, etc

import 'dart:io';

import 'package:custom_dialog/main.dart';
import 'package:flutter/material.dart';

class UiController with ChangeNotifier {
  bool showDialogContent = true;
  bool showSizeAndColor = true;
  bool showImage = true;
  bool showContact = true;
  List<bool> bulletSelected = [true, false, false, false, false, false, false];
  bool emailCheck = MyApp.customDialogStructure.emailAllowedString == "false" ||
          MyApp.customDialogStructure.emailAllowedString == "" ||
          MyApp.customDialogStructure.emailAllowedString == null
      ? false
      : true;
  bool phoneCheck = MyApp.customDialogStructure.phoneAllowedString == "false" ||
          MyApp.customDialogStructure.phoneAllowedString == "" ||
          MyApp.customDialogStructure.phoneAllowedString == null
      ? false
      : true;
  bool moreInfoChecked =
      MyApp.customDialogStructure.linkAllowedString == "false" ||
              MyApp.customDialogStructure.linkAllowedString == "" ||
              MyApp.customDialogStructure.linkAllowedString == null
          ? false
          : true;
  Color bgColor = MyApp.customDialogStructure == null
      ? Colors.black
      : Color(int.parse(MyApp.customDialogStructure.bgColor));
  Color titleColor = MyApp.customDialogStructure == null
      ? Colors.black
      : Color(int.parse(MyApp.customDialogStructure.titleColor));
  Color msgColor = MyApp.customDialogStructure == null
      ? Colors.black
      : Color(int.parse(MyApp.customDialogStructure.msgColor));
  bool showAdvancedSettings = false;
  double titleFontString = MyApp.customDialogStructure == null
      ? 20.0
      : double.parse(MyApp.customDialogStructure.titleFontString);
  double msgFontString = MyApp.customDialogStructure == null
      ? 16.0
      : double.parse(MyApp.customDialogStructure.msgFontString);
  Image imageUploaded = Image.file(File(''));
  bool advButton = true;

  void changeShowDialogContent() {
    showDialogContent = true;
    notifyListeners();
  }

  void changeShowSizeAndColor() {
    showSizeAndColor = !showSizeAndColor;
    notifyListeners();
  }

  void changeShowImage() {
    showImage = !showImage;
    notifyListeners();
  }

  void changeShowContact() {
    showContact = !showContact;
    notifyListeners();
  }

  void changeShowAdvancedSettings() {
    showAdvancedSettings = !showAdvancedSettings;
    notifyListeners();
  }

  void changeTitleFontSize(double value) {
    titleFontString = value;
    notifyListeners();
  }

  void changeBodyFontSize(double value) {
    msgFontString = value;
    notifyListeners();
  }

  void changeImage(Image image) {
    imageUploaded = image;
    notifyListeners();
  }

  void changeAdvButtonVisibility() {
    advButton = !advButton;
    notifyListeners();
  }

  void changeBulletSelected(int index) {
    for (int buttonIndex = 0;
        buttonIndex < bulletSelected.length;
        buttonIndex++) {
      if (buttonIndex == index) {
        bulletSelected[buttonIndex] = true;
      } else {
        bulletSelected[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  void changeEmailCheck(bool? value) {
    emailCheck = value!;
    notifyListeners();
  }

  void changePhoneCheck(bool? value) {
    phoneCheck = value!;
    notifyListeners();
  }

  void changeMoreInfoCheck(bool? value) {
    moreInfoChecked = value!;
    notifyListeners();
  }

  void changeBgColor(Color newBgColor) {
    bgColor = newBgColor;
    notifyListeners();
  }

  void changeTitleColor(Color newTitleColor) {
    titleColor = newTitleColor;
    notifyListeners();
  }

  void changeBodyColor(Color newBodyColor) {
    msgColor = newBodyColor;
    notifyListeners();
  }
}
