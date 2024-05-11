import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedClothing = '';

  void changePoseImage() {}

  void _showClothingOptions(String category) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GridViewWidget(
          selectedClothing: selectedClothing,
          onClothingSelected: (String clothing) {
            setState(() {
              selectedClothing = clothing;
            });
            Navigator.pop(context);
          },
          category: category,
        );
      },
    );
  }

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
              'Virtual Try On',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
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
                  color: Colors.grey,
                  category: 'Hat',
                  onTap: _showClothingOptions,
                ),
                ClothingOption(
                  color: Colors.grey,
                  category: 'Torso',
                  onTap: _showClothingOptions,
                ),
                ClothingOption(
                  color: Colors.grey,
                  category: 'Pants',
                  onTap: _showClothingOptions,
                ),
                ClothingOption(
                  color: Colors.grey,
                  category: 'Shoes',
                  onTap: _showClothingOptions,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: changePoseImage,
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: changePoseImage,
                        child: Icon(Icons.camera_alt),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Trying on: $selectedClothing');
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class ClothingOption extends StatelessWidget {
  final Color color;
  final String category;
  final Function onTap;

  ClothingOption(
      {required this.color, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(category);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 100,
          height: 100,
          color: color,
          child: Center(
            child: Text(
              category,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class GridViewWidget extends StatelessWidget {
  final String selectedClothing;
  final Function(String) onClothingSelected;
  final String category;

  GridViewWidget(
      {required this.selectedClothing,
      required this.onClothingSelected,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      height: MediaQuery.of(context).size.height * 0.5,
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        children: List.generate(
          clothingItems[category]?.length ?? 0,
          (index) {
            String clothingItem = clothingItems[category]?[index] ?? '';
            return GestureDetector(
              onTap: () {
                onClothingSelected(clothingItem);
              },
              child: Container(
                width: 100,
                height: 100,
                color: selectedClothing == clothingItem
                    ? Colors.blue
                    : Colors.grey,
                child: Center(
                  child: Text(
                    clothingItem,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Map<String, List<String>> clothingItems = {
  'Hat': ['Hat 1', 'Hat 2', 'Hat 3'],
  'Torso': [
    'Shirt 1',
    'Shirt 2',
    'Shirt 3',
    'Shirt 4',
    'Shirt 5',
    'Shirt 6',
    'Shirt 6',
    'Shirt 6',
    'Shirt 6',
    'Shirt 6',
    'Shirt 6'
  ],
  'Pants': ['Pants 1', 'Pants 2', 'Pants 3'],
  'Shoes': ['Shoes 1', 'Shoes 2', 'Shoes 3'],
};
