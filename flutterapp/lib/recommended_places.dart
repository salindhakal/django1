import 'package:flutter/material.dart';

class RecommendedPlacesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> recommendedPlaces;

  RecommendedPlacesScreen(this.recommendedPlaces);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Places'),
      ),
      body: ListView.builder(
        itemCount: recommendedPlaces.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(recommendedPlaces[index]['name']),
            children: [
              ListTile(
                title: Text(recommendedPlaces[index]['description']),
              ),
            ],
          );
        },
      ),
    );
  }
}
