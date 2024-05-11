import 'package:flutter/material.dart';

class MyTryOnButton extends StatefulWidget {
  final Function()? onTap;

  const MyTryOnButton({Key? key, required this.onTap}) : super(key: key);

  @override
  _MyTryOnButtonState createState() => _MyTryOnButtonState();
}

class _MyTryOnButtonState extends State<MyTryOnButton> {
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
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 35),
        decoration: BoxDecoration(
          color: _isPressed ? Color(0xFFEE5566) : Color(0xFFFF6678),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Change',
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
