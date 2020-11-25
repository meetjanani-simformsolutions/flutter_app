import 'package:flutter/material.dart';

typedef EditTextValue = void Function(String);
typedef EditTextValidator = String Function(String);
class EditTextWidget extends StatelessWidget {
  final String hintLable;
  final String defaultLable;
  final IconData iconData;
  final VoidCallback focuse;
  final TextInputAction action;
  final bool obSecoreText;
  final EditTextValue onChange;
  final EditTextValidator validator;

  const EditTextWidget({@required this.hintLable, this.defaultLable, this.iconData, this.focuse, this.action, this.obSecoreText = false, this.onChange, this.validator});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Container(
          color: Colors.transparent,
          child: TextFormField(
            onChanged: onChange,
            validator: validator,
            autofocus: true,
            style: TextStyle(color:  Colors.white),
            textInputAction: action,
            onEditingComplete: focuse,
            obscureText: obSecoreText,
            decoration: InputDecoration(
                prefixIcon: Icon(iconData, color: Colors.white70,),
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 14),
                fillColor: Colors.white,
                hintText: hintLable,
                labelText: defaultLable
            ),
          ),
        ),
      ),
    );
  }
}
