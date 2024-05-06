import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  List<Outfit> outfits = [];

  @override
  void initState() {
    super.initState();
    // fetchData();
    mockData();
  }

  // Future<void> fetchData() async {
  //   try {
  //     final response = await http.get(Uri.parse(''));
  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       List<Outfit> fetchedOutfits = [];
  //       for (var item in jsonData) {
  //         fetchedOutfits.add(Outfit.fromJson(item));
  //       }
  //       setState(() {
  //         outfits = fetchedOutfits;
  //       });
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  void mockData() {
    List<Outfit> mockOutfits = [
      Outfit(
        id: 1,
        name: "Outfit 1",
        imageUrl: "https://via.placeholder.com/150",
        clothes: [
          Cloth(id: 1, name: "Shirt"),
          Cloth(id: 2, name: "Pants"),
          Cloth(id: 3, name: "Shoes"),
        ],
      ),
      Outfit(
        id: 2,
        name: "Outfit 2",
        imageUrl: "https://via.placeholder.com/150",
        clothes: [
          Cloth(id: 4, name: "T-shirt"),
          Cloth(id: 5, name: "Jeans"),
          Cloth(id: 6, name: "Sneakers"),
        ],
      ),
    ];

    setState(() {
      outfits = mockOutfits;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              'Saved Outfits',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: outfits.length,
        itemBuilder: (context, index) {
          final outfit = outfits[index];
          return OutfitCard(outfit: outfit);
        },
      ),
    );
  }
}

class Outfit {
  final int id;
  final String name;
  final String? imageUrl;
  final List<Cloth> clothes;

  Outfit({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.clothes,
  });
}

class Cloth {
  final int id;
  final String name;

  Cloth({required this.id, required this.name});
}

class OutfitCard extends StatelessWidget {
  final Outfit outfit;

  const OutfitCard({Key? key, required this.outfit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(outfit.name),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (outfit.imageUrl != null)
                    Image.network(
                      outfit.imageUrl!,
                      fit: BoxFit.cover,
                      height: 200.0,
                    )
                  else
                    Placeholder(
                      fallbackHeight: 200.0,
                      color: Colors.grey,
                    ),
                  SizedBox(height: 8.0),
                  Text(
                    'Clothes:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: outfit.clothes
                        .map((cloth) => Text(cloth.name))
                        .toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Color(0xFFFF6678)),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (outfit.imageUrl != null)
              Container(
                width: 100.0,
                child: Image.network(
                  outfit.imageUrl!,
                  fit: BoxFit.fill,
                ),
              )
            else
              Container(
                width: 100.0,
                child: Placeholder(
                  fallbackWidth: 100.0,
                  fallbackHeight: 200.0,
                  color: Colors.grey,
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  outfit.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutfitDetailsPage extends StatelessWidget {
  final Outfit outfit;

  const OutfitDetailsPage({Key? key, required this.outfit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(outfit.name),
      ),
      body: ListView.builder(
        itemCount: outfit.clothes.length,
        itemBuilder: (context, index) {
          final cloth = outfit.clothes[index];
          return ListTile(
            title: Text(cloth.name),
          );
        },
      ),
    );
  }
}
