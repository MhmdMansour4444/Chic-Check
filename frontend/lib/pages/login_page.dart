import 'package:flutter/material.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/components/my_signinButton.dart';
import 'package:frontend/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  //sign in user in method
  void signInUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              const Text(
                'Chic Check',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 15),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style:
                          TextStyle(color: Color.fromARGB(255, 148, 148, 148)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 200),

              // sign in button
              MySignInButton(
                onTap: signInUser,
              ),

              const SizedBox(
                height: 25,
              ),

              // or continue with
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color.fromARGB(255, 148, 148, 148),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                            color: Color.fromARGB(255, 148, 148, 148)),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color.fromARGB(255, 148, 148, 148),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // google + apple sign in button
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  SquareTile(imagePath: 'lib/image/google.png'),

                  SizedBox(width: 10),

                  //apple button
                  SquareTile(imagePath: 'lib/image/apple.png'),
                ],
              )

              // not a member ? register now
            ],
          ),
        ),
      ),
    );
  }
}
