import 'package:flutter/material.dart';
import 'package:frontend/components/my_navbar.dart';

class ClosetPage extends StatefulWidget {
  @override
  _ClosetPageState createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              width: 30,
              color: Colors.grey[300],
            ),
          );
        },
      ),
      bottomNavigationBar: MyNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _navigateBottomBar,
      ),
    );
  }
}

// GridView.count(
      //   crossAxisCount: 3,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         height: 30,
      //         width: 30,
      //         color: Colors.grey[300],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         height: 30,
      //         width: 30,
      //         color: Colors.grey[300],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         height: 30,
      //         width: 30,
      //         color: Colors.grey[300],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         height: 30,
      //         width: 30,
      //         color: Colors.grey[300],
      //       ),
      //     ),
      //   ],
      // ),