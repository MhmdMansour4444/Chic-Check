import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/components/my_navBar.dart';

class PreferenceScreen extends StatefulWidget {
  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  List<String> dressingStyles = ['Casual', 'Formal', 'Sporty', 'Bohemian'];
  List<String> preferredColors = ['Red', 'Blue', 'Green', 'Yellow'];
  List<String> favoritePlaces = ['Beach', 'Cafe', 'Park', 'Concert'];

  List<String> selectedDressingStyles = [];
  List<String> selectedPreferredColors = [];
  List<String> selectedFavoritePlaces = [];

  void _toggleDressingStyle(String dressingStyle) {
    setState(() {
      if (selectedDressingStyles.contains(dressingStyle)) {
        selectedDressingStyles.remove(dressingStyle);
      } else {
        if (selectedDressingStyles.length < 3) {
          selectedDressingStyles.add(dressingStyle);
        } else {
          _showWarningDialog('You can select up to 3 dressing styles.');
        }
      }
    });
  }

  void _togglePreferredColor(String color) {
    setState(() {
      if (selectedPreferredColors.contains(color)) {
        selectedPreferredColors.remove(color);
      } else {
        if (selectedPreferredColors.length < 3) {
          selectedPreferredColors.add(color);
        } else {
          _showWarningDialog('You can select up to 3 preferred colors.');
        }
      }
    });
  }

  void _toggleFavoritePlace(String place) {
    setState(() {
      if (selectedFavoritePlaces.contains(place)) {
        selectedFavoritePlaces.remove(place);
      } else {
        if (selectedFavoritePlaces.length < 3) {
          selectedFavoritePlaces.add(place);
        } else {
          _showWarningDialog('You can select up to 3 favorite places.');
        }
      }
    });
  }

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _savePreferences() {
    print('Selected Dressing Styles: $selectedDressingStyles');
    print('Selected Preferred Colors: $selectedPreferredColors');
    print('Selected Favorite Places: $selectedFavoritePlaces');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyNavBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Your Dressing Style (Up to 3)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 8.0,
              children: dressingStyles.map((style) {
                return ChoiceChip(
                  label: Text(style),
                  selected: selectedDressingStyles.contains(style),
                  onSelected: (selected) {
                    _toggleDressingStyle(style);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Select Your Preferred Colors (Up to 3)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 8.0,
              children: preferredColors.map((color) {
                return ChoiceChip(
                  label: Text(color),
                  selected: selectedPreferredColors.contains(color),
                  onSelected: (selected) {
                    _togglePreferredColor(color);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Select Your Favorite Places (Up to 3)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 8.0,
              children: favoritePlaces.map((place) {
                return ChoiceChip(
                  label: Text(place),
                  selected: selectedFavoritePlaces.contains(place),
                  onSelected: (selected) {
                    _toggleFavoritePlace(place);
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _canContinue() ? _savePreferences : null,
              child: Text(
                'Continue to Home Page',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _canContinue() ? Color(0xFFFF6678) : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canContinue() {
    return selectedDressingStyles.isNotEmpty &&
        selectedPreferredColors.isNotEmpty &&
        selectedFavoritePlaces.isNotEmpty;
  }
}
