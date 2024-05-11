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
  List<CardItem> items = [
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
      body: Container(
        height: 256,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          separatorBuilder: (context, _) => SizedBox(width: 20),
          itemBuilder: (context, index) => buildCard(),
        ),
      ),
    );
  }

  Widget buildCard() => Container(
        width: 180,
        height: 180,
        color: Color(0xFFFF6678),
        child: Column(
          children: [
            Image.network(
                'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            const SizedBox(height: 4),
            Text('Shoe XYZ', style: TextStyle(fontSize: 20))
          ],
        ),
      );
}
