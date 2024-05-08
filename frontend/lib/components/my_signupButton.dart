import 'package:flutter/material.dart';

class MySignUpButton extends StatefulWidget {
  final Function()? onTap;

  const MySignUpButton({Key? key, required this.onTap}) : super(key: key);

  @override
  _MySignUpButtonState createState() => _MySignUpButtonState();
}

class _MySignUpButtonState extends State<MySignUpButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 35),
        decoration: BoxDecoration(
          color: _isPressed ? Color(0xFFEE5566) : Color(0xFFFF6678),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
