import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'recommended_places.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TravelApp(),
  ));
}

class TravelApp extends StatefulWidget {
  @override
  _TravelAppState createState() => _TravelAppState();
}

class _TravelAppState extends State<TravelApp> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  List<String> _selectedInterests = [];
  List<Map<String, dynamic>> _recommendedPlaces = [];
  final Map<String, List<String>> _recommendations = {
    'Nature': [
      'Hiking in the mountains',
      'Exploring wildlife sanctuaries',
      'Bird watching',
      'National Park Safaris',
      'Exploring Lakes'
    ],
    'Culture': [
      'Visiting historical sites',
      'Visiting museums and galleries',
      'Attending cultural events',
      'Homestays with Local Communities',
      'Visits to Sacred Sites',
      'Visits to Temples and Monasteries'
    ],
    'Adventure': [
      'Rafting in white water',
      'Paragliding',
      'Rock climbing',
      'Bungee Jumping',
      'Mountain Biking',
      'Zip-lining',
      'Canyoning'
    ],
  };

  Future<void> sendSelectedInterests(BuildContext context) async {
  try {
    List<String> lowercaseInterests = _selectedInterests
        .map((interest) => interest.toLowerCase())
        .toList();

    // Convert main options to lowercase and add them to the list
    List<String> mainOptions =
        _recommendations.keys.map((option) => option.toLowerCase()).toList();
    lowercaseInterests.addAll(mainOptions);

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/recommend_places/'),
      body: jsonEncode({'options': lowercaseInterests}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> recommendedSites = json.decode(response.body);
      setState(() {
        _recommendedPlaces = recommendedSites.map<Map<String, dynamic>>((site) {
          return {
            'name': site['name'],
            'description': site['description'],
            'isExpanded': false,
          };
        }).toList();
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecommendedPlacesScreen(_recommendedPlaces),
        ),
      );
    } else {
      throw Exception('Failed to send selected interests');
    }
  } catch (e) {
    print('Error: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Way Finder Nepal',
            style: const TextStyle(
                fontSize: 25,
                color: Colors.purple,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Implement your logic when "Where to?" is tapped
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
                  width: double.infinity,
                  height: 135,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Bon Voyage',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff111417),
                            ),
                          ),
                          Container(
                            height: 110,
                            child: Icon(Icons.airplane_ticket_rounded,
                                size: 26, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 7),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Implement your logic when popular destination 1 is tapped
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        padding: EdgeInsets.fromLTRB(16, 8, 32, 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffeff2f4),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 12),
                              width: 34,
                              height: 24,
                              child: Icon(Icons.search,
                                  size: 24, color: Colors.black),
                            ),
                            Flexible(
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Where to?',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'Popular destinations',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff111417),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                width: double.infinity,
                height: 170,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Destination Card 1
                      GestureDetector(
                        onTap: () {
                          // Implement your logic when popular destination 1 is tapped
                        },
                        child: _buildDestinationCard('Mt. Everest',
                            'assets/mt.png'),
                      ),
                      SizedBox(width: 12),
                      // Destination Card 2
                      GestureDetector(
                        onTap: () {
                          // Implement your logic when popular destination 2 is tapped
                        },
                        child: _buildDestinationCard(
                            'Pokhara', 'assets/pokhara.png'),
                      ),
                      SizedBox(width: 12),
                      // Destination Card 3
                      GestureDetector(
                        onTap: () {
                          // Implement your logic when popular destination 3 is tapped
                        },
                        child: _buildDestinationCard('Tilicho', 'assets/til.png'),
                      ),
                    ],
                  ),
                ),
              ),
              // Categories Section
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff111417),
                      ),
                    ),
                    SizedBox(height: 19.5),
                    // Displaying Interests
                    _displayInterests(),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  sendSelectedInterests(context);
                },
                child: Text('Show Places'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  textStyle: TextStyle(fontSize: 18.0),
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.black),
              label: 'Favorites',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black),
              label: 'Search',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              label: 'Profile',
              backgroundColor: Colors.white,
            ),
          ],
          selectedItemColor: Colors.black,
          showSelectedLabels: true,
        ),
      ),
    );
  }

  Widget _buildDestinationCard(String destination, String imagePath) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            width: 160,
            height: 90,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            destination,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff111417),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayInterests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _recommendations.keys.map((category) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff111417),
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _recommendations[category]!
                  .map((subInterest) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: CheckboxListTile(
                          title: Text(subInterest),
                          value: _selectedInterests.contains(subInterest),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                _selectedInterests.add(subInterest);
                              } else {
                                _selectedInterests.remove(subInterest);
                              }
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 24),
          ],
        );
      }).toList(),
    );
  }
}
