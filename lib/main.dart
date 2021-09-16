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
            primary: Color(0xFF3CD1BB),
            secondary: Color(0xFF4C44B3),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Custom Dialog'),
            backgroundColor: Color(0xFF3CD1BB),
          ),
          body: AddParameters(),
        ),
      ),
    );
  }
}
