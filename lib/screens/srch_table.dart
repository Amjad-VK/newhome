import 'package:flutter/material.dart';

import '../main.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> searchResults = [];

  Future<void> searchTableData(String searchTerm) async {
    final response =
        await supabase.from('pg_det').select().ilike('city', '%$searchTerm%');

    if (response.error != null) {
      // Handle error
    } else {
      setState(() {
        searchResults = response.data as List<Map<String, dynamic>>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              searchTableData(value);
            },
            decoration: InputDecoration(
              labelText: 'Search',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final item = searchResults[index];
                return ListTile(
                  title: Text(item['pg_name'].toString()),
                  subtitle: Text(item['rent'].toString()),
                  // Display other columns as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
