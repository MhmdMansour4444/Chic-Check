import 'package:flutter/material.dart';

class ClosetPage extends StatefulWidget {
  @override
  _ClosetPageState createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFFF6678),
                  width: 3.0,
                ),
              ),
            ),
            child: const Text(
              'ChicCloset',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: 140,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildCard(),
            SizedBox(width: 12),
            buildCard(),
            SizedBox(width: 12),
            buildCard(),
            SizedBox(width: 12),
            buildCard(),
            SizedBox(width: 12),
            buildCard(),
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget buildCard() => Container(
        width: 200,
        height: 200,
        color: Color(0xFFFF6678),
        child: Image.network(
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
      );
}
