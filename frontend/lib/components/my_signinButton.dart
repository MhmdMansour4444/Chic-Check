import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySignInButton extends StatelessWidget {
  const MySignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 35),
      decoration: BoxDecoration(
          color: Color(0xFFFF6678), borderRadius: BorderRadius.circular(8)),
      child: const Center(
        child: Text(
          'Sign In',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
