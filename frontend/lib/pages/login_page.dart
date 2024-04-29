import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              // logo
              Icon(
                Icons.lock,
                size: 100,
              ),

              SizedBox(height: 50),

              Text(
                'Chic Check',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 25),

              // welcome back

              // username textfield
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 15),

              // password textfield
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                  ),
                ),
              ),

              // forgot password?

              // sign in button

              // or continue with

              // google sign in button

              // not a member ? register now
            ],
          ),
        ),
      ),
    );
  }
}
