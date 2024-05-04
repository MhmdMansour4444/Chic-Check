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
        title: Text('The Closet'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      'Title 1',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 70),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      'Title 2',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: GridView.builder(
              itemCount: 5,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          ),
        ],
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