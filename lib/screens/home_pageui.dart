// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newhome/main.dart';
import 'package:newhome/screens/login.dart';
import 'package:newhome/screens/room_detPage.dart';
import 'package:postgrest/src/types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home_nh extends StatefulWidget {
  @override
  State<Home_nh> createState() => _Home_nhState();
}

class _Home_nhState extends State<Home_nh> {
  String username = '';
  int count = 3;

  @override
  void initState() {
    super.initState();
    retrieveUsername();
  }

// Get pgs count

// View a PG
  // view_det() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => roomdet_2()),
  //   );
  // }

// Clear sharefpref data logout
  Future<void> clearUserDataInSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('email');
    await prefs.remove('username');

    print('User data cleared from shared preferences');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => login_nha()),
    );
  }

  Future<void> retrieveUsername() async {
    String retrievedUsername = await getUsernameFromSharedPrefs();
    setState(() {
      username = retrievedUsername;
    });
  }

  final TextEditingController _searchController = TextEditingController();
  final _notes =
      Supabase.instance.client.from('pg_det').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromARGB(255, 253, 253, 253),
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/uu.png'),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello ' + username,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text('Welcome to NewHome',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))
              ],
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        clearUserDataInSharedPrefs();
                      },
                      icon: Icon(
                        Icons.logout_rounded,
                        color: Color.fromARGB(255, 39, 114, 231),
                      )))
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            //Search Bar
            Container(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search by Location',
                    hintStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            // Room Count
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 39, 114, 231),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$count Rooms Found',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Rooms
            Container(
              height: 600,
              child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _notes,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final notes = snapshot.data!;
                    return MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(15),
                              child: InkWell(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    useSafeArea: false,
                                    builder: (BuildContext context) {
                                      return roomdet_2();
                                    },
                                  );
                                },
                                child: Container(
                                  height: 200,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              notes[index]['image']))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 120, left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notes[index]['pg_name'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Outfit2',
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 30,
                                              color: Color.fromARGB(
                                                  255, 39, 114, 231),
                                            ),
                                            Text(
                                              notes[index]['location'] +
                                                  ',' +
                                                  notes[index]['city'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Outfit2',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }),
            )
          ]))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourites')
        ],
      ),
    );
  }
}

Future<String> getUsernameFromSharedPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username') ?? '';
  return username;
}
