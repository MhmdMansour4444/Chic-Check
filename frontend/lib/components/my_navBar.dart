import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const MyNavBar({required this.selectedIndex, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: GNav(
        selectedIndex: selectedIndex,
        activeColor: Color(0xFFFF6678),
        tabBackgroundColor: Color.fromARGB(83, 255, 102, 120),
        gap: 5,
        onTabChange: (value) {
          print(value);
        },
        padding: EdgeInsets.all(14),
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.checkroom_rounded,
            text: 'Closet',
          ),
          GButton(
            icon: Icons.camera_outlined,
            text: 'Camera',
          ),
          GButton(
            icon: Icons.message_rounded,
            text: 'Forums',
          ),
          GButton(
            icon: Icons.bookmarks_outlined,
            text: 'Saved',
          ),
        ],
      ),
    );
  }
}
