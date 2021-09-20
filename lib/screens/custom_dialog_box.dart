import 'dart:io';
import 'package:custom_dialog/controller/ui_controller.dart';
import 'package:custom_dialog/main.dart';
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
String url = '';

class CustomDialog extends StatelessWidget {
  Future<void> _contact(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void initializeValues(Map dialogMap, BuildContext context) {
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
    url = '';

    // List iconList = [Icon(
    //   Icons.circle,
    //   color: colorPrimary,
    //   size: 18.0,
    // ),
    //   Icon(
    //     Icons.trip_origin,
    //     color: colorPrimary,
    //     size: 18.0,
    //   ),
    //   Icon(
    //     Icons.format_list_numbered,
    //     color: colorPrimary,
    //   ),
    //   Icon(
    //     Icons.arrow_forward_ios,
    //     color: colorPrimary,
    //     size: 15.0,
    //   ),
    //   Icon(
    //     Icons.star_outlined,
    //     color: colorPrimary,
    //     size: 20.0,
    //   ),
    //   Icon(
    //     Icons.stop,
    //     color: colorPrimary,
    //     size: 22.0,
    //   ),
    //   Icon(
    //     Icons.block,
    //     color: colorPrimary,
    //     size: 22.0,
    //   ),];

    title = dialogMap['title'];

    header = dialogMap['headerText'];

    print(
        'wanted = ${dialogMap['centerBulletText']}, ${dialogMap['centerBulletText']}');
    if (dialogMap['centerBulletText'] != null)
      bullets = dialogMap['centerBulletText'];

    footer = dialogMap['footerText'];

    // if (dialogMap['bulletSymbol'] != null) bulletIcon = dialogMap['bulletSymbol'];

    if (dialogMap.containsKey('bgColor') && dialogMap['bgColor'] != null)
      bgColor = dialogMap['bgColor'];

    if (dialogMap.containsKey('titleColor') && dialogMap['titleColor'] != null)
      titleColor = dialogMap['titleColor'];

    if (dialogMap.containsKey('msgColor') && dialogMap['msgColor'] != null)
      bodyColor = dialogMap['msgColor'];

    if (dialogMap.containsKey('titleFontString') &&
        dialogMap['titleFontString'] != null)
      titleFontSize = dialogMap['titleFontString'];

    if (dialogMap.containsKey('msgFontString') &&
        dialogMap['msgFontString'] != null)
      bodyFontSize = dialogMap['msgFontString'];

    if (context
            .watch<FormContent>()
            .dialogObject
            .containsKey('alertImageUrl') &&
        context.watch<FormContent>().dialogObject['alertImageUrl'] != null &&
        context.watch<FormContent>().dialogObject['alertImageUrl'].length != 0)
      imageUploaded = true;
    else
      imageUploaded = false;

    if (dialogMap.containsKey('imageDisplayShape') &&
        dialogMap['imageDisplayShape'] != null)
      imageDisplayShape = dialogMap['imageDisplayShape'];

    if (context.watch<UiController>().emailCheck &&
        dialogMap.containsKey('email') &&
        dialogMap['email'] != null) email = dialogMap['email'];

    if (context.watch<UiController>().phoneCheck &&
        dialogMap.containsKey('phoneNumber') &&
        dialogMap['phoneNumber'] != null)
      phoneNumber = dialogMap['phoneNumber'];

    if (context.watch<UiController>().moreInfoChecked &&
        dialogMap.containsKey('linkAllowedString') &&
        dialogMap['linkAllowedString'] != null) url = dialogMap['link'];
  }

  @override
  Widget build(BuildContext context) {
    var dialogMap = context.watch<FormContent>().dialogObject;

    initializeValues(dialogMap, context);

    List<Widget> bulletWidgets = [];
    List<String> bulletsSeparated = bullets.split('\n');
    int index = 1;
    for (var b in bulletsSeparated) {
      bulletWidgets.add(ListTile(
        leading: MyApp.customDialogStructure.bulletSymbol == null || MyApp.customDialogStructure.bulletSymbol == ""
            ? (bulletIcon == Icons.format_list_numbered
                ? Text(
                    index.toString() + ".",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20.0, color: bodyColor),
                  )
                : bulletIcon != Icons.block
                    ? Icon(
                        bulletIcon,
                        size: bodyFontSize,
                        color: bodyColor,
                      )
                    : Text(
                        '',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ))
            : MyApp.customDialogStructure.bulletSymbol,
        title: Text(b),
        dense: true,
      ));
      // bulletWidgets.add(
      //   Row(children: [
      //     if (bulletIcon == Icons.format_list_numbered)
      //       Text(
      //         index.toString() + ".",
      //         softWrap: true,
      //         overflow: TextOverflow.ellipsis,
      //         style: TextStyle(fontSize: 20.0, color: bodyColor),
      //       )
      //     else if (bulletIcon != Icons.block)
      //       Icon(
      //         bulletIcon,
      //         size: bodyFontSize,
      //         color: bodyColor,
      //       )
      //     else
      //       Text(
      //         '',
      //         softWrap: true,
      //         overflow: TextOverflow.ellipsis,
      //       ),
      //     SizedBox(
      //       width: 10.0,
      //     ),
      //     Text(
      //       b,
      //       softWrap: true,
      //       overflow: TextOverflow.ellipsis,
      //       style: TextStyle(
      //         fontSize: bodyFontSize,
      //         color: bodyColor,
      //       ),
      //     ),
      //   ]),
      // );
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
                              .dialogObject['alertImageUrl'][0]
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
                              .dialogObject['alertImageUrl'][0]
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
                      if (imageUploaded)
                        if (imageDisplayShape == 'Circle')
                          SizedBox(
                            height: 30.0,
                          ),
                      Center(
                        child: Text(
                          title,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
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
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
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
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
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
                                    'Email Us',
                                    softWrap: true,
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
                                    'Call Us',
                                    softWrap: true,
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
                                softWrap: true,
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
