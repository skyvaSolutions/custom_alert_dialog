//Provider for populating _formKey object

import 'package:flutter/material.dart';

class FormContent with ChangeNotifier{

   var DialogObject = new Map();
  void contentChange(Map value){
    DialogObject = value;
    notifyListeners();
  }
}