import 'package:flutter/material.dart';
import 'screens/add_parameters.dart';
import 'package:provider/provider.dart';
import 'package:custom_dialog/controller/form_content.dart';
import 'package:custom_dialog/controller/ui_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FormContent>(create: (context) => FormContent()),
        ChangeNotifierProvider<UiController>(create: (context) => UiController()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: Color(0xff2B3A67),
            secondary: Color(0xff2B3A67),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Custom Dialog'),
            backgroundColor: Color(0xff2B3A67),
          ),
          body: AddParameters(),
        ),
      ),
    );
  }
}
