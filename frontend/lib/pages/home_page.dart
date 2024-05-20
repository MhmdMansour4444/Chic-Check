import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String apiUrl =
      'http://192.168.1.2:8001/process'; // Update this with your backend URL
  String approvalResult = '';
  String imageUrl = '';
  String preferences = '';
  String occasion = '';
  String weather = '';
  String season = '';
  bool isLoading = false;

  Future<void> _getOutfitApproval() async {
    setState(() {
      isLoading = true;
    });

    if (imageUrl.isEmpty ||
        preferences.isEmpty ||
        occasion.isEmpty ||
        weather.isEmpty ||
        season.isEmpty) {
      setState(() {
        approvalResult = 'Error: Please fill all fields';
        isLoading = false;
      });
      return;
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'imageURL': imageUrl,
        'rawText':
            '$preferences $occasion $weather $season', // Concatenate all fields into rawText
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        approvalResult = data['rawText']; // Extracting the raw text response
        isLoading = false;
      });
    } else {
      setState(() {
        approvalResult = 'Error: ${response.reasonPhrase}';
        isLoading = false;
      });
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
              'Outfits Approval',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => imageUrl = value,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF6678)),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => preferences = value,
                decoration: InputDecoration(
                  labelText: 'Clothing Preferences: casual, sporty...',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF6678)),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => occasion = value,
                decoration: InputDecoration(
                  labelText: 'Occasion: Party, wedding...',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF6678)),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => weather = value,
                decoration: InputDecoration(
                  labelText: 'Weather',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF6678)),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => season = value,
                decoration: InputDecoration(
                  labelText: 'Season',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF6678)),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _getOutfitApproval,
                child: isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.red), // Change the color here
                      )
                    : Text(
                        'Get Approval',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFFFF6678)),
                      ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                padding: EdgeInsets.all(20),
                child: Text(
                  approvalResult.isNotEmpty
                      ? 'Approval Result: $approvalResult'
                      : '',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
