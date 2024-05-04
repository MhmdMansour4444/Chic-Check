import 'package:flutter/material.dart';
import 'package:frontend/components/my_navbar.dart';

class ClosetPage extends StatefulWidget {
  @override
  _ClosetPageState createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  int _selectedIndex = 0;
  int _selectedTitleIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTitlePressed(int index) {
    setState(() {
      _selectedTitleIndex = index;
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
                  InkWell(
                    onTap: () => _onTitlePressed(0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTitleIndex == 0
                                ? Color(0xFFFF6678)
                                : const Color.fromARGB(0, 255, 255, 255),
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Title 1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 70),
                  InkWell(
                    onTap: () => _onTitlePressed(1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTitleIndex == 1
                                ? Color(0xFFFF6678)
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Title 2',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
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