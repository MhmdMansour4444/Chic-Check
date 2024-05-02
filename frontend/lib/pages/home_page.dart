import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  void onTap() {
    // Implement onTap functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Mohammad!'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 2.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Use your camera for our fitcheck',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}
