import 'package:custom_dialog/screens/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:custom_dialog/controller/form_content.dart';
import 'package:custom_dialog/controller/ui_controller.dart';

final _formKey = GlobalKey<FormBuilderState>();

Color colorPrimary = Color(0xff2B3A67);
Color colorSecondary = Color(0xffD4DAED);
//Color(0xffFFC482);
Color colorButton = Color(0xffD4DAED);

InputDecoration CustomInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
      color: colorPrimary,
      fontSize: 15.0
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 2.0,
      )
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: colorPrimary,
        width: 2.0,
      ),
    ),
  );
}

ButtonStyle CustomButtonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(colorButton),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  );
}

class AddParameters extends StatelessWidget {
  ListTile Separator(String title, VoidCallback PressedAction, bool show) {
    return ListTile(
      leading: Icon(!show ? Icons.arrow_drop_down_sharp : null,
          color: colorPrimary, size: 30.0),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: colorPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: PressedAction,
      tileColor: colorSecondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fill in the values',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: colorPrimary,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    print(_formKey.currentState!.value);
                    context
                        .read<FormContent>()
                        .contentChange(_formKey.currentState!.value);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomDialogBox()));
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(colorPrimary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 2.0,
          color: colorPrimary,
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: ListView(
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Separator('Message Content', () {
                      context.read<UiController>().changeShowDialogContent();
                    }, context.watch<UiController>().showDialogContent),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (context.watch<UiController>().showDialogContent)
                      DialogContent(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Separator('Font Size and Color', () {
                      context.read<UiController>().changeShowSizeAndColor();
                    }, context.watch<UiController>().showSizeAndColor),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (context.watch<UiController>().showSizeAndColor)
                      SizeAndColors(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Separator('Image', () {
                      context.read<UiController>().changeShowImage();
                    }, context.watch<UiController>().showImage),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (context.watch<UiController>().showImage) ImagePicker(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Separator('Contact', () {
                      context.read<UiController>().changeShowContact();
                    }, context.watch<UiController>().showContact),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (context.watch<UiController>().showContact) ContactUs(),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DialogContent extends StatelessWidget {
  List<IconData> icons = [
    Icons.circle,
    Icons.trip_origin,
    Icons.format_list_numbered,
    Icons.arrow_forward_ios,
    Icons.star_outlined
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormBuilderTextField(
            name: 'Title',
            cursorColor: colorPrimary,
            style: TextStyle(
              fontSize: 15.0
            ),
            decoration: CustomInputDecoration('Add Title'),
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
            name: 'Header',
            style: TextStyle(
                fontSize: 15.0
            ),
            cursorColor: colorPrimary,
            decoration: CustomInputDecoration('Add Header'),
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
            name: 'Bullets',
            cursorColor: colorPrimary,
            decoration: CustomInputDecoration('Add multiline Bullets'),
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
          ),
          SizedBox(
            height: 10.0,
          ),
          FormBuilderTextField(
            name: 'Footer',
            cursorColor: colorPrimary,
            style: TextStyle(
                fontSize: 15.0
            ),
            decoration: CustomInputDecoration('Add Footer'),
            keyboardType: TextInputType.text,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Footer Cannot be empty'),
              FormBuilderValidators.maxLength(context, 30,
                  errorText: 'Footer cannot exceed 30 characters'),
            ]),
          ),
          SizedBox(
            height: 10.0,
          ),
          FormBuilderField(
            name: "Bullet Icon",
            builder: (FormFieldState<dynamic> field) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bullet Icons',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: colorPrimary,
                    ),
                  ),
                  ToggleButtons(
                    isSelected: context.watch<UiController>().bulletSelected,
                    selectedBorderColor: colorPrimary,
                    fillColor: colorButton,
                    borderRadius: BorderRadius.circular(6.0),
                    borderColor: colorPrimary,
                    borderWidth: 1.5,
                    onPressed: (int index) {
                      // context
                      //     .read<FormContent>()
                      //     .changeBulletIcon(icons[index]);
                      context.read<UiController>().changeBulletSelected(index);
                      _formKey.currentState!.fields['Bullet Icon']!
                          .didChange(icons[index]);
                    },
                    children: [
                      Icon(
                        Icons.circle,
                        color: colorPrimary,
                      ),
                      Icon(
                        Icons.trip_origin,
                        color: colorPrimary,
                      ),
                      Icon(
                        Icons.format_list_numbered,
                        color: colorPrimary,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: colorPrimary,
                      ),
                      Icon(
                        Icons.star_outlined,
                        color: colorPrimary,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class SizeAndColors extends StatelessWidget {
  void changeColor(BuildContext context, String selected, Color color) {
    if (selected == 'bgColor') {
      context.read<UiController>().changeBgColor(color);
      _formKey.currentState!.fields['Background Color']!.didChange(color);
    } else if (selected == 'titleColor') {
      context.read<UiController>().changeTitleColor(color);
      _formKey.currentState!.fields['Title Color']!.didChange(color);
    } else {
      context.read<UiController>().changeBodyColor(color);
      _formKey.currentState!.fields['Body Color']!.didChange(color);
    }
  }

  void openColorPalette(BuildContext context, String selected , defaultColor) {
    Color colorPicked = defaultColor;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: colorPicked,
              onColorChanged: (Color color) {
                changeColor(context, selected, color);
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.5,
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

  IconButton customIconButton(VoidCallback pressedAction) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: pressedAction,
      color: colorPrimary,
    );
  }

  Text SimpleText(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.0,
        color: colorPrimary,
      ),
    );
  }

  FormBuilderField ColorPickerField(String title, BuildContext context,
      Color selectedColor, String selected , Color defaultColor) {
    return FormBuilderField(
      name: title,
      initialValue: colorPrimary,
      builder: (FormFieldState<dynamic> field) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleText(title),
            SizedBox(
              width: 20.0,
            ),
            Row(
              children: [
                customIconButton(() {
                  openColorPalette(context, selected , defaultColor);
                }),
                CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 7.0,
                    backgroundColor: selectedColor,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  FormBuilderSlider CustomSlider(String title, BuildContext context, change) {
    return FormBuilderSlider(
      name: title,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.min(context, 6),
      ]),
      onChanged: change,
      min: 5.0,
      max: 30.0,
      initialValue: 15.0,
      divisions: 25,
      activeColor: colorPrimary,
      inactiveColor: colorSecondary,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(
          fontSize: 20.0,
          color: colorPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ColorPickerField('Background Color', context,
              context.watch<UiController>().bgColor, 'bgColor' , Colors.white),
          SizedBox(
            height: 10.0,
          ),
          ColorPickerField('Title Color', context,
              context.watch<UiController>().titleColor, 'titleColor' , Colors.black),
          SizedBox(
            height: 10.0,
          ),
          ColorPickerField('Body Color', context,
              context.watch<UiController>().bodyColor, 'bodyColor' , Colors.black54),
          SizedBox(
            height: 10.0,
          ),
          CustomSlider('Title Font Size', context, (double? value) {
            //context.read<FormContent>().changeTitleFontSize(value!);
          }),
          SizedBox(
            height: 10.0,
          ),
          CustomSlider('Body Font Size', context, (double? value) {
            //context.read<FormContent>().changeBodyFontSize(value!);
          }),
        ],
      ),
    );
  }
}

class ImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: FormBuilderImagePicker(
        iconColor: colorPrimary,
        name: 'Image',
        decoration: InputDecoration(
          labelText: 'Choose an Image',
          labelStyle: TextStyle(fontSize: 22.0, color: colorPrimary),
        ),
        maxImages: 1,
      ),
    );
  }
}

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          FormBuilderCheckbox(
            name: 'Email Enabled',
            title: Text(
              'Email Enabled',
              style: TextStyle(
                fontSize: 15.0,
                color: colorPrimary,
              ),
            ),
            activeColor: colorPrimary,
            initialValue: context.watch<UiController>().emailCheck,
            onChanged: (bool? value) {
              context.read<UiController>().changeEmailCheck(value);
            },
          ),
          if (context.watch<UiController>().emailCheck)
            FormBuilderTextField(
              name: 'Email',
              cursorColor: colorPrimary,
              decoration: CustomInputDecoration('Email'),
              keyboardType: TextInputType.emailAddress,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.email(context,
                    errorText: 'Enter a valid email'),
              ]),
            ),
          FormBuilderCheckbox(
            name: 'Number Enabled',
            title: Text(
              'Number Enabled',
              style: TextStyle(
                fontSize: 15.0,
                color: colorPrimary,
              ),
            ),
            activeColor: colorPrimary,
            initialValue: context.watch<UiController>().phoneCheck,
            onChanged: (bool? value) {
              context.read<UiController>().changePhoneCheck(value);
            },
          ),
          if (context.watch<UiController>().phoneCheck)
            FormBuilderTextField(
              name: 'Number',
              cursorColor: colorPrimary,
              decoration: CustomInputDecoration('Phone Number'),
              keyboardType: TextInputType.phone,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.maxLength(context, 12,
                    errorText: 'Enter a valid Phone Number'),
                FormBuilderValidators.numeric(context,
                    errorText: 'Enter a valid Phone Number'),
              ]),
            ),
        ],
      ),
    );
  }
}

class AdditionalInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
