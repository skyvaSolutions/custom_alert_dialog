import 'package:custom_dialog/main.dart';
import 'package:custom_dialog/screens/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:custom_dialog/controller/form_content.dart';
import 'package:custom_dialog/controller/ui_controller.dart';

//Mostly all the widgets have been separated into separate widget tree so that it is easy for further changes

//Color Scheme of the app
Color colorPrimary = Colors.grey.shade800;
Color colorSecondary = Color(0xFF3CD1BB);
Color colorButton = Color(0xFF3CD1BB);

//This is the default decoration for all the text fields
InputDecoration customInputDecoration(String label, IconData prefixIcon) {
  return InputDecoration(
    prefixIcon: Icon(prefixIcon),
    hintText: label,
    labelStyle: TextStyle(color: colorPrimary, fontSize: 15.0),
    fillColor: Colors.grey[300],
    filled: true,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.0),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        )),
    focusColor: colorPrimary,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
  );
}

//Custom Button style
ButtonStyle customButtonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(colorButton),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  );
}

//Main class of this file which renders the over all widget tree on the screen
class AddParameters extends StatelessWidget {
  //_formKey is the variable that populates all the values of the form in Map datatype
  static final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    print('Add parameters build called');
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PreviewButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Center(
                child: Text(
                  'Dialog Content',
                  style: TextStyle(
                      color: colorPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
            FormBuilder(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    DialogContent(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (context
                        .watch<UiController>()
                        .advButton)
                      AdvanceSettingsButton(),
                    if (context
                        .watch<UiController>()
                        .showAdvancedSettings)
                      AdvancedSettings(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Submit button Custom Layout
class PreviewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (AddParameters.formKey.currentState!.saveAndValidate()) {
          print(AddParameters.formKey.currentState!.value);
          context
              .read<FormContent>()
              .contentChange(AddParameters.formKey.currentState!.value);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog();
            },
          );
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorPrimary),
      ),
      child: Text(
        'Preview',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }
}

//Advance Settings Custom Button
class AdvanceSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextButton(
        onPressed: () {
          context.read<UiController>().changeShowAdvancedSettings();
          context.read<UiController>().changeAdvButtonVisibility();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: colorPrimary,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Advanced Settings',
              style: TextStyle(
                  color: colorPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}

//Bottom Widgets for advance settings
class AdvancedSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 1.0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10.0,
          ),
          BulletIconField(),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 1.0,
            color: Colors.grey,
          ),
          SizeAndColors(),
          ImagePicker(),
          ImageDisplayShape(),
          ContactUs(),
        ],
      ),
    );
  }
}

//Title,header,bullets,footer
class DialogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('DialogContent build called');
    print(MyApp.customDialogStructure);
    if (MyApp.customDialogStructure != null) {
      print(MyApp.customDialogStructure.title);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormBuilderTextField(
            name: 'title',
            initialValue: MyApp.customDialogStructure == null
                ? ""
                : MyApp.customDialogStructure.title,
            autofocus: true,
            cursorColor: colorPrimary,
            style: TextStyle(fontSize: 15.0),
            decoration: customInputDecoration('Add Title', Icons.title),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Title cannot be empty'),
              FormBuilderValidators.maxLength(context, 30,
                  errorText: 'Title cannot exceed 30 characters'),
            ]),
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 10.0,
          ),
          FormBuilderTextField(
            name: 'headerText',
            style: TextStyle(fontSize: 15.0),
            initialValue: MyApp.customDialogStructure == null
                ? ""
                : MyApp.customDialogStructure.headerText,
            cursorColor: colorPrimary,
            decoration:
            customInputDecoration('Add Header', Icons.article_sharp),
            keyboardType: TextInputType.text,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Header cannot be empty'),
              FormBuilderValidators.maxLength(context, 100,
                  errorText: 'Title cannot exceed 100 characters'),
            ]),
          ),
          SizedBox(
            height: 10.0,
          ),
          FormBuilderTextField(
            name: 'centerBulletText',
            initialValue: MyApp.customDialogStructure == null
                ? ""
                : MyApp.customDialogStructure.centerBulletText,
            cursorColor: colorPrimary,
            decoration: customInputDecoration(
                'Add multiline Bullets', Icons.format_list_bulleted),
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
          ),
          SizedBox(
            height: 10.0,
          ),
          FormBuilderTextField(
            name: 'footerText',
            initialValue: MyApp.customDialogStructure == null
                ? ""
                : MyApp.customDialogStructure.footerText,
            cursorColor: colorPrimary,
            style: TextStyle(fontSize: 15.0),
            decoration: customInputDecoration(
                'Add Footer', Icons.branding_watermark_outlined),
            keyboardType: TextInputType.text,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Footer Cannot be empty'),
              FormBuilderValidators.maxLength(context, 100,
                  errorText: 'Footer cannot exceed 100 characters'),
            ]),
          ),
        ],
      ),
    );
  }
}

//bullet icons
// ignore: must_be_immutable
class BulletIconField extends StatelessWidget {
  List<IconData> icons = [
    Icons.circle,
    Icons.trip_origin,
    Icons.format_list_numbered,
    Icons.arrow_forward_ios,
    Icons.star_outlined,
    Icons.stop,
    Icons.block
  ];

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: "bulletSymbol",
      initialValue: MyApp.customDialogStructure == null
          ? ""
          : MyApp.customDialogStructure.bulletSymbol,
      builder: (FormFieldState<dynamic> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bullet Icons',
              style: TextStyle(
                fontSize: 15.0,
                color: colorPrimary,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleButtons(
                isSelected: context
                    .watch<UiController>()
                    .bulletSelected,
                selectedBorderColor: colorPrimary,
                fillColor: colorButton,
                borderRadius: BorderRadius.circular(5.0),
                borderColor: colorPrimary,
                borderWidth: 1.5,
                onPressed: (int index) {
                  context.read<UiController>().changeBulletSelected(index);
                  AddParameters.formKey.currentState!.fields['bulletSymbol']!
                      .didChange(icons[index]);
                },
                children: [
                  Icon(
                    Icons.circle,
                    color: colorPrimary,
                    size: 18.0,
                  ),
                  Icon(
                    Icons.trip_origin,
                    color: colorPrimary,
                    size: 18.0,
                  ),
                  Icon(
                    Icons.format_list_numbered,
                    color: colorPrimary,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: colorPrimary,
                    size: 15.0,
                  ),
                  Icon(
                    Icons.star_outlined,
                    color: colorPrimary,
                    size: 20.0,
                  ),
                  Icon(
                    Icons.stop,
                    color: colorPrimary,
                    size: 22.0,
                  ),
                  Icon(
                    Icons.block,
                    color: colorPrimary,
                    size: 22.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        );
      },
    );
  }
}

//title font size, body font size, title, background and body color
class SizeAndColors extends StatelessWidget {
  static var bgColor, titleColor, msgColor;

  void changeColor(BuildContext context, String selected, Color color) {
    if (selected == 'bgColor') {
      context.read<UiController>().changeBgColor(color);
      bgColor = color.value;
    } else if (selected == 'titleColor') {
      context.read<UiController>().changeTitleColor(color);
      titleColor = color.value;
    } else {
      context.read<UiController>().changeBodyColor(color);
      msgColor = color.value;
    }
  }

  void openColorPalette(BuildContext context, String selected, defaultColor) {
    Color colorPicked = defaultColor;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: colorPicked,
              onColorChanged: (Color color) {
                changeColor(context, selected, color);
              },
            ),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(colorButton),
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  color: colorPrimary,
                  fontSize: 15.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  RawMaterialButton customIconButton(VoidCallback pressedAction,
      Color selectedColor) {
    return RawMaterialButton(
      onPressed: pressedAction,
      fillColor: selectedColor,
      constraints: BoxConstraints.tight(Size(20, 20)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
    );
  }

  Text simpleText(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.0,
        color: colorPrimary,
      ),
    );
  }

  FormBuilderField colorPickerField(String title, BuildContext context,
      Color selectedColor, String selected, Color defaultColor) {
    return FormBuilderField(
      name: title,
      initialValue: defaultColor,
      builder: (FormFieldState<dynamic> field) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            simpleText(title),
            SizedBox(
              width: 20.0,
            ),
            Row(
              children: [
                customIconButton(() {
                  openColorPalette(context, selected, defaultColor);
                }, selectedColor),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  FormBuilderSlider customSlider(String title, BuildContext context, change,
      value) {
    return FormBuilderSlider(
      name: title,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.min(context, 6),
      ]),
      onChanged: change,
      min: 5.0,
      max: 30.0,
      initialValue: double.parse(value),
      divisions: 25,
      activeColor: colorPrimary,
      displayValues: DisplayValues.minMax,
      inactiveColor: colorSecondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        colorPickerField(
          'Background Color',
          context,
          context
              .watch<UiController>()
              .bgColor,
          'bgColor',
          Color(MyApp.customDialogStructure == null
              ? 0xFFFFFFFF
              : int.parse(MyApp.customDialogStructure.bgColor.toString())),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 1.0,
          color: Colors.grey,
        ),
        colorPickerField(
          'Title Color',
          context,
          context
              .watch<UiController>()
              .titleColor,
          'titleColor',
          Color(MyApp.customDialogStructure == null
              ? 0xFFFFFFFF
              : int.parse(MyApp.customDialogStructure.titleColor.toString())),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 1.0,
          color: Colors.grey,
        ),
        colorPickerField(
          'Body Color',
          context,
          context
              .watch<UiController>()
              .msgColor,
          'msgColor',
          Color(MyApp.customDialogStructure == null
              ? 0xFFFFFFFF
              : int.parse(MyApp.customDialogStructure.msgColor.toString())),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 1.0,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          children: [
            Row(
              children: [
                Text(
                  'Title Font Size',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: colorPrimary,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  context
                      .watch<UiController>()
                      .titleFontString
                      .toString(),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            customSlider('titleFontString', context, (double? value) {
              context.read<UiController>().changeTitleFontSize(value!);
            },
                MyApp.customDialogStructure == null
                    ? "20"
                    : MyApp.customDialogStructure.titleFontString),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          children: [
            Row(
              children: [
                Text(
                  'Body Font Size',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: colorPrimary,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  context
                      .watch<UiController>()
                      .msgFontString
                      .toString(),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            customSlider('msgFontString', context, (double? value) {
              context.read<UiController>().changeBodyFontSize(value!);
            },
                MyApp.customDialogStructure == null
                    ? "16"
                    : MyApp.customDialogStructure.msgFontString),
          ],
        ),
      ],
    );
  }
}

//Image
class ImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormBuilderImagePicker(
      iconColor: colorPrimary,
      name: 'alertImageUrl',
      decoration: InputDecoration(
        labelText: 'Upload an Image',
        labelStyle: TextStyle(fontSize: 20.0, color: colorPrimary),
      ),
      maxImages: 1,
      onImage: (Image image) {
        context.read<UiController>().changeImage(image);
        AddParameters.formKey.currentState!.fields['Image']!.didChange(image);
      },
    );
  }
}

class ImageDisplayShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormBuilderChoiceChip(
      name: 'imageDisplayShape',
      initialValue: 'Circle',
      selectedColor: colorButton,
      decoration: InputDecoration(
          labelText: 'Image Display Shape',
          labelStyle: TextStyle(
            fontSize: 20.0,
            color: colorPrimary,
          )),
      spacing: 20.0,
      onSaved: (String? value) =>
          AddParameters
              .formKey.currentState!.fields['imageDisplayShape']!
              .didChange(value!),
      options: [
        FormBuilderFieldOption(
          value: 'Circle',
          child: Text(
            'Circle',
            style: TextStyle(
              color: colorPrimary,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FormBuilderFieldOption(
          value: 'Rectangle',
          child: Text(
            'Rectangle',
            style: TextStyle(
              color: colorPrimary,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

//email, phone and url
class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderCheckbox(
          name: 'emailAllowedString',
          title: Text(
            'Add Email us button',
            style: TextStyle(
              fontSize: 15.0,
              color: colorPrimary,
            ),
          ),
          activeColor: colorPrimary,
          initialValue: context
              .watch<UiController>()
              .emailCheck,
          onChanged: (bool? value) {
            context.read<UiController>().changeEmailCheck(value);
          },
        ),
        if (context
            .watch<UiController>()
            .emailCheck)
          FormBuilderTextField(
            name: 'email',
            cursorColor: colorPrimary,
            initialValue:
            MyApp.customDialogStructure.emailAllowedString == "true"
                ? MyApp.customDialogStructure.email
                : "",
            decoration: customInputDecoration('Email', Icons.email),
            keyboardType: TextInputType.emailAddress,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.email(context,
                  errorText: 'Enter a valid email'),
            ]),
          ),
        FormBuilderCheckbox(
          name: 'phoneAllowedString',
          title: Text(
            'Add Call us button',
            style: TextStyle(
              fontSize: 15.0,
              color: colorPrimary,
            ),
          ),
          activeColor: colorPrimary,
          initialValue: context
              .watch<UiController>()
              .phoneCheck,
          onChanged: (bool? value) {
            context.read<UiController>().changePhoneCheck(value);
          },
        ),
        if (context
            .watch<UiController>()
            .phoneCheck)
          FormBuilderTextField(
            name: 'phoneNumber',
            cursorColor: colorPrimary,
            initialValue:
            MyApp.customDialogStructure.phoneAllowedString == "true"
                ? MyApp.customDialogStructure.phoneNumber
                : "",
            decoration: customInputDecoration('+XX XXXXXXXXXX', Icons.phone),
            keyboardType: TextInputType.phone,
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.minLength(context, 13,
                    errorText: 'Enter a valid Phone Number'),
                FormBuilderValidators.maxLength(context, 14,
                    errorText: 'Enter a valid Phone Number'),
              ],
            ),
          ),
        FormBuilderCheckbox(
          name: 'linkAllowedString',
          title: Text(
            'Add More Information link',
            style: TextStyle(
              fontSize: 15.0,
              color: colorPrimary,
            ),
          ),
          activeColor: colorPrimary,
          initialValue: context
              .watch<UiController>()
              .moreInfoChecked,
          onChanged: (bool? value) {
            context.read<UiController>().changeMoreInfoCheck(value);
          },
        ),
        if (context
            .watch<UiController>()
            .moreInfoChecked)
          FormBuilderTextField(
            name: 'link',
            cursorColor: colorPrimary,
            initialValue: MyApp.customDialogStructure.linkAllowedString == "true"
                ? MyApp.customDialogStructure.link
                : "",
            decoration:
            customInputDecoration('Paste Website URL', Icons.insert_link),
            keyboardType: TextInputType.url,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.url(context,
                  errorText: 'Enter a valid URL'),
            ]),
          ),
      ],
    );
  }
}

//----------------------------------------------------------------------------------Just Some Random Code ------------------------------------------------------------------------------------------//
// Separator('Font Size and Color', () {
//   context.read<UiController>().changeShowSizeAndColor();
// }, context.watch<UiController>().showSizeAndColor),

// ElevatedButton Separator(String title, VoidCallback PressedAction, bool show) {
//   return ElevatedButton(
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
//     ),
//     onPressed: PressedAction,
//     child: ListTile(
//       leading: Icon(
//           !show ? Icons.arrow_drop_down_sharp : Icons.arrow_drop_up_sharp,
//           color: colorPrimary,
//           size: 30.0),
//       minLeadingWidth: -2.0,
//       title: Text(
//         title,
//         style: TextStyle(
//           fontSize: 15.0,
//           color: colorPrimary,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//   );
// }
