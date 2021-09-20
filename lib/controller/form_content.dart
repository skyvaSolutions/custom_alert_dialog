//Provider for populating _formKey object

import 'package:flutter/material.dart';

class FormContent with ChangeNotifier{

   var dialogObject = new Map();
  void contentChange(Map value){
    dialogObject = value;
    notifyListeners();
  }
}