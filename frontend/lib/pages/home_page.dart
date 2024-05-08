import 'package:flutter/material.dart';
import 'package:frontend/pages/camera_page.dart'; // Import the CameraPage
import 'package:frontend/pages/forums_page.dart'; // Import the ForumsPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onTap(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForumsPage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              'Welcome!!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(83, 255, 102, 120),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
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
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: const Text(
                'Use your camera for our fitcheck',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () => onTap(0),
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
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: const Text(
                'Or browse our community for the best outfit advices out there!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () => onTap(1),
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
            ),
          ],
        ),
      ),
    );
  }
}
