import 'package:flutter/material.dart';

class ForumsPage extends StatefulWidget {
  const ForumsPage({super.key});

  @override
  State<ForumsPage> createState() => _ForumsPageState();
}

class _ForumsPageState extends State<ForumsPage> {
  //user
  final currentUser = "";

  void signOut() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forums Page',
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          // the wall

          // post message

          //logged in
          Text("logged in as: "),
        ],
      ),
    );
  }
}
