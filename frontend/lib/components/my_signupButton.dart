import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySignUpButton extends StatelessWidget {
  final Function()? onTap;

  const MySignUpButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 35),
        decoration: BoxDecoration(
            color: Color(0xFFFF6678), borderRadius: BorderRadius.circular(8)),
        child: const Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
