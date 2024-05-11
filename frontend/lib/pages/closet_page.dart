import 'package:flutter/material.dart';

class CardItem {
  final String urlImage;
  final String title;

  const CardItem({
    required this.urlImage,
    required this.title,
  });
}

class ClosetPage extends StatelessWidget {
  final List<CardItem> shoes = [
    const CardItem(
      urlImage:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'Nike Free run',
    ),
    const CardItem(
      urlImage:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'Nike Free run 2',
    ),
    const CardItem(
      urlImage:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'Nike Free run 3',
    ),
    const CardItem(
      urlImage:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'Nike Free run 4',
    ),
  ];

  final List<CardItem> hats = [];
  final List<CardItem> torsos = [];
  final List<CardItem> pants = [];

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
            buildListView(title: 'Hats', items: hats),
            buildListView(title: 'Torsos', items: torsos),
            buildListView(title: 'Pants', items: pants),
            buildListView(title: 'Shoes', items: shoes),
          ],
        ),
      ),
    );
  }

  Widget buildListView(
          {required String title, required List<CardItem> items}) =>
      Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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

  Widget buildCard(CardItem item) => Container(
        width: 180,
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item.urlImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(item.title, style: TextStyle(fontSize: 20))
          ],
        ),
      );
}
