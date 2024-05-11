import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedClothing = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Try On'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Welcome, User!',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClothingOption(
                  color: Colors.blue,
                  onTap: () {
                    setState(() {
                      selectedClothing = 'Hat';
                    });
                  },
                ),
                ClothingOption(
                  color: Colors.green,
                  onTap: () {
                    setState(() {
                      selectedClothing = 'Torso';
                    });
                  },
                ),
                ClothingOption(
                  color: Colors.red,
                  onTap: () {
                    setState(() {
                      selectedClothing = 'Pants';
                    });
                  },
                ),
                ClothingOption(
                  color: Colors.yellow,
                  onTap: () {
                    setState(() {
                      selectedClothing = 'Shoes';
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              width: 200,
              height: 450,
              color: Colors.grey,
              child: Center(
                child: Text(
                  'Pose Image',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
      // Button to try on selected clothing
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement logic to apply selected clothing to the pose image
          // For now, just print the selected clothing
          print('Trying on: $selectedClothing');
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class ClothingOption extends StatelessWidget {
  final Color color;
  final Function onTap;

  ClothingOption({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 100,
          height: 100,
          color: color,
          child: Center(
            child: Text(
              'Placeholder',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
