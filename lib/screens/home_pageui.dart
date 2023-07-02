// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Home_nh extends StatefulWidget {
  @override
  State<Home_nh> createState() => _Home_nhState();
}

class _Home_nhState extends State<Home_nh> {
 

  final TextEditingController _searchController = TextEditingController();
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
                  'Hello, User',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text('Welcome to NewHome',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold))
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.account_circle,
                  color: Color.fromARGB(255, 39, 114, 231),
                ),
              )
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
                        '200 Rooms Found',
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
              child: MediaQuery(
                data: MediaQuery.of(context).removePadding(removeTop: true),
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: 200,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/r1.jpg'))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 120, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Heidhin Home Stay',
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
                                      color: Color.fromARGB(255, 39, 114, 231),
                                    ),
                                    Text(
                                      'Vellimadukunnu, Kozhikode',
                                      style: TextStyle(
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
                      );
                    }),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
