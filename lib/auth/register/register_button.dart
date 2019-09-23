import 'package:flutter/material.dart';
import 'package:wallet/style/theme.dart' as Style;

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Style.Colors.mainColor,
      disabledColor: Style.Colors.mainColor.withOpacity(0.2),
      disabledTextColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      onPressed: _onPressed,
      child: Text('Үргэлжүүлэх', style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }
}