import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';

class AutoCompleteSearchLocation extends StatefulWidget {
  @override
  _AutoCompleteSearchLocationState createState() => _AutoCompleteSearchLocationState();
}

class _AutoCompleteSearchLocationState extends State<AutoCompleteSearchLocation> {
  final String _apiKey = 'pk.eyJ1Ijoicmh1cmJhaW4iLCJhIjoiY200YmVhbXEwMDNlazJrcjR5NTV1cHIzZiJ9.YJYIAlDKtqbvQuwJMxDpzQ';
  late PlacesSearch placesSearch;
  List<MapBoxPlace> suggestedPlaces = []; // List to store search results

  @override
  void initState() {
    super.initState();
    placesSearch = PlacesSearch(
      apiKey: _apiKey,
      limit: 5, // Limit results to 5
    );
  }

  void searchPlace(String query) async {
    try {
      // Perform search
      List<MapBoxPlace>? places = await placesSearch.getPlaces(query);

      // Update the UI with search results
      setState(() {
        suggestedPlaces = places ?? [];
      });
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mapbox Search Example')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                // Trigger search when user types
                if (value.isNotEmpty) {
                  searchPlace(value);
                } else {
                  setState(() {
                    suggestedPlaces = []; // Clear suggestions
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Search for a place',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: suggestedPlaces.length,
              itemBuilder: (context, index) {
                final place = suggestedPlaces[index];
                return ListTile(
                  title: Text(place.placeName ?? 'Unknown Place'),
                  subtitle: Text(
                    'Coordinates: ${place.geometry?.coordinates.toString() ?? 'N/A'}',
                  ),
                  onTap: () {
                    // Handle tap on a place
                    print('Selected: ${place.placeName}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
