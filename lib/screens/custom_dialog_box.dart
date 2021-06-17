import 'dart:io';
import 'package:custom_dialog/controller/ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_dialog/controller/form_content.dart';
import 'package:url_launcher/url_launcher.dart';

//Initialize all variables
int appColor = 0xff2B3A67;

String title = '';
String header = '';
String bullets = '';
String footer = '';
Color bgColor = Colors.white;
Color titleColor = Colors.black;
Color bodyColor = Colors.black;
double titleFontSize = 20.0;
double bodyFontSize = 18.0;
String email = '';
String phoneNumber = '';
IconData bulletIcon = Icons.circle;
String imageDisplayShape = 'Circle';
bool imageUploaded = false;
String url ='';



class CustomDialog extends StatelessWidget {
  Future<void> _contact(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void initializeValues(Map dialogMap , BuildContext context) {

// Error and Null checking of all variables and then updating values each time dialog box is opened
     title = '';
     header = '';
     bullets = '';
     footer = '';
     bgColor = Colors.white;
     titleColor = Colors.black;
     bodyColor = Colors.black;
     titleFontSize = 20.0;
     bodyFontSize = 18.0;
     email = '';
     phoneNumber = '';
     bulletIcon = Icons.circle;
     imageDisplayShape = 'Circle';
     imageUploaded = false;
     url ='';


    title = dialogMap['Title'];

    header = dialogMap['Header'];

    if (dialogMap['Bullets'] != null) bullets = dialogMap['Bullets'];

    footer = dialogMap['Footer'];

    if (dialogMap['Bullet Icon'] != null) bulletIcon = dialogMap['Bullet Icon'];

    if (dialogMap.containsKey('Background Color') &&
        dialogMap['Background Color'] != null)
      bgColor = dialogMap['Background Color'];

    if (dialogMap.containsKey('Title Color') &&
        dialogMap['Title Color'] != null) titleColor = dialogMap['Title Color'];

    if (dialogMap.containsKey('Body Color') && dialogMap['Body Color'] != null)
      bodyColor = dialogMap['Body Color'];

    if (dialogMap.containsKey('Title Font Size') &&
        dialogMap['Title Font Size'] != null)
      titleFontSize = dialogMap['Title Font Size'];

    if (dialogMap.containsKey('Body Font Size') &&
        dialogMap['Body Font Size'] != null)
      bodyFontSize = dialogMap['Body Font Size'];

    if(context.watch<FormContent>().DialogObject.containsKey('Image') && context.watch<FormContent>().DialogObject['Image'] != null && context.watch<FormContent>().DialogObject['Image'].length  !=0)
      imageUploaded = true;
    else
      imageUploaded = false;


    if (dialogMap.containsKey('Image Display Shape') &&
        dialogMap['Image Display Shape'] != null)
      imageDisplayShape = dialogMap['Image Display Shape'];

    if (context.watch<UiController>().emailCheck && dialogMap.containsKey('Email') && dialogMap['Email'] != null)
      email = dialogMap['Email'];

    if (context.watch<UiController>().phoneCheck && dialogMap.containsKey('Number') && dialogMap['Number'] != null)
      phoneNumber = dialogMap['Number'];

    if (context.watch<UiController>().moreInfoChecked &&  dialogMap.containsKey('More Info') && dialogMap['More Info'] != null)
      url = dialogMap['More Info'];
  }

  @override
  Widget build(BuildContext context) {
    var dialogMap = context.watch<FormContent>().DialogObject;

    initializeValues(dialogMap , context);

    List<Widget> bulletWidgets = [];
    List<String> bulletsSeparated = bullets.split('\n');
    int index = 1;
    for (var b in bulletsSeparated) {
      bulletWidgets.add(
        Row(children: [
          if (bulletIcon == Icons.format_list_numbered)
            Text(
              index.toString() + ".",
              style: TextStyle(fontSize: 20.0, color: bodyColor),
            )

          else if (bulletIcon != Icons.block)
            Icon(
              bulletIcon,
              size: bodyFontSize,
              color: bodyColor,
            )
          else
            Text(''),
          SizedBox(
            width: 10.0,
          ),
          Text(
            b,
            style: TextStyle(
              fontSize: bodyFontSize,
              color: bodyColor,
            ),
          ),
        ]),
      );
      index++;
    }

    return Dialog(
      backgroundColor: bgColor,
      child: Container(
        width: double.infinity,
        decoration: new BoxDecoration(
          color: bgColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(10.0, 10.0),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (imageUploaded)
              if (imageDisplayShape == 'Circle')
                Positioned(
                  left: 0,
                  right: 0,
                  top: -40,
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(
                          File(context
                              .watch<FormContent>()
                              .DialogObject['Image'][0]
                              .path),
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (imageDisplayShape == 'Rectangle')
                  Container(
                    height: 120.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: FileImage(
                          File(context
                              .watch<FormContent>()
                              .DialogObject['Image'][0]
                              .path),
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      if(imageUploaded)
                        if(imageDisplayShape == 'Circle')
                          SizedBox(
                            height: 30.0,
                          ),
                      Center(
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: titleColor),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        header,
                        style: TextStyle(
                          fontSize: bodyFontSize,
                          color: bodyColor,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (bullets != '')
                        Column(
                          children: bulletWidgets,
                        ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        footer,
                        style: TextStyle(
                          fontSize: bodyFontSize,
                          color: bodyColor,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (email != '')
                            TextButton(
                              onPressed: () {
                                _contact('mailto:$email');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.mail,
                                    size: 20.0,
                                    color: bodyColor,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                      fontSize: bodyFontSize,
                                      color: bodyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (phoneNumber != '')
                            TextButton(
                              onPressed: () {
                                _contact('tel:$phoneNumber');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 20.0,
                                    color: bodyColor,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Call',
                                    style: TextStyle(
                                      fontSize: bodyFontSize,
                                      color: bodyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                        if (url != '')
                          TextButton(
                            onPressed: () {
                              _contact('https:$url');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.open_in_browser,
                                  size: 20.0,
                                  color: bodyColor,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Visit website',
                                  style: TextStyle(
                                    fontSize: bodyFontSize,
                                    color: bodyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(
                                fontSize: bodyFontSize,
                                color: bodyColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//
