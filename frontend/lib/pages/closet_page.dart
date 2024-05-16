import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class Cloth {
  final String name;
  final String? brand;
  final String? base64Image;
  final int categoryId;

  Cloth({
    required this.name,
    required this.brand,
    required this.base64Image,
    required this.categoryId,
  });

  factory Cloth.fromJson(Map<String, dynamic> json) {
    return Cloth(
      name: json['name'],
      brand: json['brand'],
      base64Image: json['image'],
      categoryId: json['category_id'],
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

void printAuthToken() async {
  String? authToken = await AuthService.getAuthToken();
  print('Auth Token: $authToken');
}

class AuthService {
  static Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

class ClosetPage extends StatefulWidget {
  @override
  _ClosetPageState createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  List<Cloth> shoes = [];
  List<Cloth> hats = [];
  List<Cloth> torsos = [];
  List<Cloth> pants = [];
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    printAuthToken();
    fetchClothes();
    fetchCategories();
  }

  Future<void> fetchClothes() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.2:8000/api/clothes'),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic>? clothJson = jsonDecode(response.body);
        print("any");
        if (clothJson != null) {
          setState(() {
            for (var json in clothJson) {
              Cloth cloth = Cloth.fromJson(json);
              switch (cloth.categoryId) {
                case 1:
                  hats.add(cloth);
                  break;
                case 2:
                  torsos.add(cloth);
                  break;
                case 3:
                  pants.add(cloth);
                  break;
                case 4:
                  shoes.add(cloth);
                  break;
              }
            }
          });
        } else {
          throw Exception('Response body is null');
        }
      } else {
        throw Exception('Failed to load clothes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching clothes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to load clothes. Please check your internet connection.'),
        ),
      );
    }
  }

  Future<void> fetchCategories() async {
    try {
      final authToken = await AuthService.getAuthToken();
      final response = await http.get(
        Uri.parse('http://192.168.1.2:8000/api/categories'),
        headers: {'Authorization': 'Bearer $authToken'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> categoryJson = jsonDecode(response.body);
        setState(() {
          categories =
              categoryJson.map((json) => Category.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to load categories. Please check your internet connection.'),
        ),
      );
    }
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
            for (int i = 0; i < categories.length; i++) ...[
              buildCategoryListView(
                category: categories[i],
                items: getCategoryItems(categories[i].id),
              ),
              if (i < categories.length - 1)
                Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
            ],
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

  List<Cloth> getCategoryItems(int categoryId) {
    switch (categoryId) {
      case 1:
        return hats;
      case 2:
        return torsos;
      case 3:
        return pants;
      case 4:
        return shoes;
      default:
        return [];
    }
  }

  Widget buildCategoryListView(
      {required Category category, required List<Cloth> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount:
                items.where((item) => item.categoryId == category.id).length,
            separatorBuilder: (context, _) => SizedBox(width: 12),
            itemBuilder: (context, index) {
              final filteredItems = items
                  .where((item) => item.categoryId == category.id)
                  .toList();
              return buildCard(filteredItems[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget buildCard(Cloth item) {
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
            child: item.base64Image != null
                ? Image.network(
                    "http://http://192.168.1.2:8000/storage/clothes/${item.base64Image}",
                    width: 180,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : SizedBox(
                    width: 180,
                    height: 120,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.name,
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
              _buildAddItemButton(context, 'Hats'),
              _buildAddItemButton(context, 'Torsos'),
              _buildAddItemButton(context, 'Pants'),
              _buildAddItemButton(context, 'Shoes'),
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

  int _getCategoryId(String category) {
    switch (category) {
      case 'Hats':
        return 1;
      case 'Torsos':
        return 2;
      case 'Pants':
        return 3;
      case 'Shoes':
        return 4;
      default:
        return 0;
    }
  }

  void _showAddItemDialog(BuildContext context, String category) {
    TextEditingController titleController = TextEditingController();
    TextEditingController brandController = TextEditingController();

    File? _image;

    Future<void> _getImageFromCamera() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      setState(() {
        _image = pickedFile != null ? File(pickedFile.path) : null;
      });
    }

    Future<void> _getImageFromGallery() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = pickedFile != null ? File(pickedFile.path) : null;
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Item to $category'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image!),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _getImageFromCamera,
                      child: Text('Take Picture'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _getImageFromGallery,
                      child: Text('Select from Gallery'),
                    ),
                  ],
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: brandController,
                  decoration: InputDecoration(labelText: 'Brand (Optional)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text;
                String brand = brandController.text;
                if (title.isNotEmpty && _image != null) {
                  int categoryId = _getCategoryId(category);
                  List<int> imageBytes = await _image!.readAsBytes();
                  String base64Image = base64Encode(imageBytes);

                  final authToken = await AuthService.getAuthToken();
                  Map<String, dynamic> newItemData = {
                    'name': title,
                    'brand': brand,
                    'image': base64Image,
                    'category_id': categoryId,
                  };

                  try {
                    final response = await http.post(
                      Uri.parse('http://192.168.1.2:8000/api/clothes'),
                      body: jsonEncode(newItemData),
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer $authToken',
                      },
                    );

                    if (response.statusCode == 201) {
                      Cloth newItem = Cloth.fromJson(jsonDecode(response.body));
                      addItem(category, newItem);
                      Navigator.of(context).pop();
                    } else {
                      print('Failed to add item: ${response.body}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Failed to add item. Please try again later.',
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    print('Error adding item: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error adding item. Please try again later.',
                        ),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Please provide a title and select an image.'),
                    ),
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void addItem(String category, Cloth item) {
    switch (category) {
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
      case 'Shoes':
        setState(() {
          shoes.add(item);
        });
        break;
    }
  }
}
