import 'package:flutter/material.dart';

import '../main.dart';

class apg_manage extends StatefulWidget {
  const apg_manage({super.key});

  @override
  State<apg_manage> createState() => _apg_manageState();
}

class _apg_manageState extends State<apg_manage> {
  List<Map<String, dynamic>> searchResults = [];
  Future<void> searchTableData(String searchTerm) async {
    final response =
        await supabase.from('pg_det').select().ilike('city', '%$searchTerm%');

    
      setState(() {
        searchResults = response as List<Map<String, dynamic>>;
      });
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.greenAccent,
          height: 600,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 400,
                  child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final item = searchResults[index];
                        return ListTile(
                          title: Text(item['pg_name'].toString()),
                          // subtitle: Text(item['rent']),
                          // Display other columns as needed
                        );
                      }),
                ),
                Container(
                  height: 100,
                  child: TextField(
                    onChanged: (value) {
                      searchTableData(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
