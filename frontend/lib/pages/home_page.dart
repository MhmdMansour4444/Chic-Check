import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Mohammad!'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Color.fromARGB(108, 255, 102, 120),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  'Need help with your outfit?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'We are here to assist you!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Use your camera for our fitcheck',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.only(
                  bottom: 12, left: 25, right: 25, top: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6678),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'Go to Scan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Or browse our community for the best outfit advices out there!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.only(
                  bottom: 12, left: 25, right: 25, top: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6678),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'Start Chatting',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}