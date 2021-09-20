import 'dart:convert';

import 'package:custom_dialog/api/allNewApis.dart';
import 'package:custom_dialog/modal/customDialogStructure.dart';
import 'package:flutter/material.dart';
import 'screens/add_parameters.dart';
import 'package:provider/provider.dart';
import 'package:custom_dialog/controller/form_content.dart';
import 'package:custom_dialog/controller/ui_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static var customDialogStructure;

  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool touchWorks = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FormContent>(create: (context) => FormContent()),
        ChangeNotifierProvider<UiController>(
            create: (context) => UiController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Color(0xFF3CD1BB),
                secondary: Color(0xFF4C44B3),
              ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Custom Dialog'),
            actions: [
              TextButton(
                onPressed: () async {
                  AllNewApis apis = AllNewApis();
                  final response = await apis.deleteCustomAlerts(
                    token:
                        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MTMwNzhhMTQzZGYzYmUyMzYwMjQ3YTUiLCJwaG9uZU5vIjoiKzkxNzg5MTc4MzIyMiIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTYzMTc5MTYyNSwiZXhwIjoxNjU3NzExNjI1fQ.Bd2B0OAcN5kYDRUFUtg_Q040Y74fv26ChBJlyMnzZS0",
                    businessId: "613a0990423dd78af3eb7bf1",
                  );
                  print(response.statusCode);
                },
                child: Center(
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (AddParameters.formKey.currentState!.saveAndValidate()) {
                    print(AddParameters.formKey.currentState!.value);
                    AllNewApis apis = AllNewApis();
                    final response = await apis.createCustomAlert(
                        token:
                            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MTMwNzhhMTQzZGYzYmUyMzYwMjQ3YTUiLCJwaG9uZU5vIjoiKzkxNzg5MTc4MzIyMiIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTYzMTc5MTYyNSwiZXhwIjoxNjU3NzExNjI1fQ.Bd2B0OAcN5kYDRUFUtg_Q040Y74fv26ChBJlyMnzZS0",
                        businessId: "613a0990423dd78af3eb7bf1",
                        jsonBody: AddParameters.formKey.currentState!.value);
                    print(response.statusCode);
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
            backgroundColor: Color(0xFF3CD1BB),
          ),
          body: touchWorks
              ? AbsorbPointer(
                  absorbing: !touchWorks,
                  child: Stack(
                    children: [
                      AddParameters(),
                      Center(
                        child: touchWorks ? null : Text('Loading...'),
                      ),
                    ],
                  ),
                )
              : Center(child: Text('Loading...')),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    assignCustomDialogAValue();
  }

  void assignCustomDialogAValue() async {
    setState(() {
      touchWorks = false;
    });
    AllNewApis apis = AllNewApis();
    final response = await apis.getCustomAlerts(
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MTMwNzhhMTQzZGYzYmUyMzYwMjQ3YTUiLCJwaG9uZU5vIjoiKzkxNzg5MTc4MzIyMiIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTYzMTc5MTYyNSwiZXhwIjoxNjU3NzExNjI1fQ.Bd2B0OAcN5kYDRUFUtg_Q040Y74fv26ChBJlyMnzZS0",
        businessId: "613a0990423dd78af3eb7bf1");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = jsonDecode(response.body);
      MyApp.customDialogStructure = CustomDialogStructure();
      MyApp.customDialogStructure.fromJson(body);
    }
    print(response.body);
    setState(() {
      print("setState called");
      touchWorks = true;
    });
  }
}
