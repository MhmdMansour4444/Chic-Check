import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/closet_page.dart';
import 'package:frontend/pages/camera_page.dart';
import 'package:frontend/pages/forums_page.dart';
import 'package:frontend/pages/saved_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    ClosetPage(),
    CameraPage(),
    ForumsPage(),
    SavedPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFFFF6678),
            unselectedItemColor: Colors.grey.shade400,
            elevation: 0,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.checkroom_rounded), label: 'Closet'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.camera_outlined), label: 'Camera'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message_rounded), label: 'Forums'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmarks_outlined), label: 'Saved'),
            ],
          ),
        ),
      ),
    );
  }
}
