import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_dialog/controller/form_content.dart';
import 'package:url_launcher/url_launcher.dart';

int appColor = 0xff2B3A67;

String title = '';
String header = '';
String bullets = '';
String footer = '';
Color bgColor = Colors.white;
Color titleColor = Colors.black;
Color bodyColor = Colors.black54;
double titleFontSize = 15.0;
double bodyFontSize = 15.0;
String email = '';
String phoneNumber = '';
IconData bulletIcon = Icons.circle;

class CustomDialogBox extends StatelessWidget {
  void initializeValues(BuildContext context) {
    var dialogMap = context.watch<FormContent>().DialogObject;

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

    if (dialogMap.containsKey('Email') && dialogMap['Email'] != null)
      email = dialogMap['Email'];

    if (dialogMap.containsKey('Number') && dialogMap['Number'] != null)
      phoneNumber = dialogMap['Number'];
  }

  @override
  Widget build(BuildContext context) {
    initializeValues(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Dialog'),
          backgroundColor: Color(appColor),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back')),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog();
                          });
                    },
                    child: Text('Open Dialog'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                children: [
                  Card(
                    child: ListTile(
                      title: Text('Title'),
                      subtitle: Text(
                        title,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Header'),
                      subtitle: Text(
                        header,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Bullets'),
                      subtitle: (bullets != '')
                          ? Text(bullets)
                          : Text('No Bullets Added'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Footer'),
                      subtitle: Text(
                        footer,
                      ),
                    ),
                  ),
                  if (bullets != '')
                    Card(
                      child: ListTile(
                        title: Text('Bullets'),
                        trailing: (context
                                    .watch<FormContent>()
                                    .DialogObject['Bullet Icon'] !=
                                null)
                            ? Icon(
                                context
                                    .watch<FormContent>()
                                    .DialogObject['Bullet Icon'],
                              )
                            : Icon(Icons.circle),
                      ),
                    ),
                  Card(
                    child: ListTile(
                      title: Text('Background Color'),
                      trailing: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 7.0,
                          backgroundColor: bgColor,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Title Color'),
                      trailing: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 7.0,
                          backgroundColor: titleColor,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Body Color'),
                      trailing: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 7.0,
                          backgroundColor: bodyColor,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Title Font Size'),
                      trailing: Text(
                        titleFontSize.toString(),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Body Font Size'),
                      trailing: Text(
                        bodyFontSize.toString(),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Image'),
                      trailing: (context
                                  .watch<FormContent>()
                                  .DialogObject
                                  .containsKey('Image') &&
                              context
                                      .watch<FormContent>()
                                      .DialogObject['Image'] !=
                                  null)
                          ? Text('Added')
                          : Text('Not Added'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Email'),
                      subtitle: (email != '') ? Text(email) : Text('Not Added'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Phone Number'),
                      subtitle: (phoneNumber != '')
                          ? Text(phoneNumber)
                          : Text('Not Added'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bulletWidgets = [];
    List<String> bulletsSeparated = bullets.split('\n');
    int index = 1;
    for (var b in bulletsSeparated) {
      bulletWidgets.add(
        ListTile(
          leading: bulletIcon == Icons.format_list_numbered ?Text(index.toString()) : Icon(bulletIcon),
          title: Text(
            b,
            style: TextStyle(
              fontSize: bodyFontSize,
              color: bodyColor,
            ),
          ),
        ),
      );
      index++;
    }

    return Dialog(
      backgroundColor: bgColor,
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
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
            if (context.watch<FormContent>().DialogObject.containsKey('Image') &&
                context.watch<FormContent>().DialogObject['Image'] != null &&
                !context.watch<FormContent>().DialogObject['Image'].isEmpty)
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.0,
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
                  height: 10.0,
                ),
                Text(
                  header,
                  style: TextStyle(
                    fontSize: bodyFontSize,
                    color: bodyColor,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                if (bullets != '')
                  Column(
                    children: bulletWidgets,
                  ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  footer,
                  style: TextStyle(
                    fontSize: bodyFontSize,
                    color: bodyColor,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Column(
                  children: [
                    if (email != '')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: bodyFontSize,
                              color: bodyColor,
                            ),
                          ),
                          Icon(
                            Icons.email,
                            size: 20,
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (phoneNumber != '')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            phoneNumber,
                            style: TextStyle(
                              fontSize: bodyFontSize,
                              color: bodyColor,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.phone),
                            iconSize: 20.0,
                            onPressed: () {
                              _makePhoneCall('tel:+91 9140416469');
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
