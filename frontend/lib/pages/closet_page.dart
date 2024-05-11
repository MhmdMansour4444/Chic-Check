import 'package:flutter/material.dart';

class CardItem {
  final String urlImage;
  final String title;

  const CardItem({
    required this.urlImage,
    required this.title,
  });
}

class ClosetPage extends StatefulWidget {
  @override
  _ClosetPageState createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  List<CardItem> shoes = [
    CardItem(
      urlImage:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'Nike Free run',
    ),
    CardItem(
      urlImage:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'Nike Free run 2',
    ),
    CardItem(
      urlImage:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'Nike Free run 3',
    ),
    CardItem(
      urlImage:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'Nike Free run 4',
    ),
  ];

  List<CardItem> hats = [];
  List<CardItem> torsos = [];
  List<CardItem> pants = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFFF6678),
                  width: 3.0,
                ),
              ),
            ),
            child: const Text(
              'ChicCloset',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCategoryListView(title: 'Shoes', items: shoes),
            buildCategoryListView(title: 'Hats', items: hats),
            buildCategoryListView(title: 'Torsos', items: torsos),
            buildCategoryListView(title: 'Pants', items: pants),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemBottomSheet(context),
        child: Icon(
          Icons.add,
          color: Color(0xFFFF6678),
        ),
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget buildCategoryListView(
      {required String title, required List<CardItem> items}) {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (context, _) => SizedBox(width: 12),
              itemBuilder: (context, index) => buildCard(items[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(CardItem item) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              item.urlImage,
              width: 180,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddItemBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAddItemButton(context, 'Shoes'),
              _buildAddItemButton(context, 'Hats'),
              _buildAddItemButton(context, 'Torsos'),
              _buildAddItemButton(context, 'Pants'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddItemButton(BuildContext context, String category) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        _showAddItemDialog(context, category);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Add Item to $category',
        style: TextStyle(fontSize: 18, color: Color(0xFFFF6678)),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context, String category) {
    TextEditingController urlController = TextEditingController();
    TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Item to $category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: urlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String url = urlController.text;
                String title = titleController.text;
                if (url.isNotEmpty && title.isNotEmpty) {
                  addItem(category, CardItem(urlImage: url, title: title));
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void addItem(String category, CardItem item) {
    switch (category) {
      case 'Shoes':
        setState(() {
          shoes.add(item);
        });
        break;
      case 'Hats':
        setState(() {
          hats.add(item);
        });
        break;
      case 'Torsos':
        setState(() {
          torsos.add(item);
        });
        break;
      case 'Pants':
        setState(() {
          pants.add(item);
        });
        break;
    }
  }
}
