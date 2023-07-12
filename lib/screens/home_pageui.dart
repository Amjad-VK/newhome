// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newhome/main.dart';
import 'package:newhome/screens/login.dart';
import 'package:newhome/screens/my_profile.dart';
import 'package:newhome/screens/room_detPage.dart';
import 'package:newhome/screens/welcome.dart';
import 'package:postgrest/src/types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home_nh extends StatefulWidget {
  @override
  State<Home_nh> createState() => _Home_nhState();
}

class _Home_nhState extends State<Home_nh> {
  dynamic user1name = '';
  dynamic getcount = '';

  @override
  void initState() {
    super.initState();
    get_pgcount();
    // retrieveUsername();
    get_username();
  }

// Get the user name
  Future get_username() async {
    final User? user = await supabase.auth.currentUser;
    var nm = user!.userMetadata!["username"];
    user1name = nm;
    // setState(() {

    // });
  }

  get_pgcount() async {
    final res = await supabase.from('pg_det').select(
          'pg_name',
          const FetchOptions(
            count: CountOption.exact,
          ),
        );

    final count = res.count;
    setState(() {
      getcount = count;
    });
  }

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

    print('User data cleared from shared preferences');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => login_nha()),
    );
  }

  // Future<void> retrieveUsername() async {
  //   String retrievedUsername = await getUsernameFromSharedPrefs();
  //   setState(() {
  //     username = retrievedUsername;
  //     print(username);
  //   });
  // }

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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => myprof_nh()),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/uu.png'),
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, $user1name',
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
                        '${getcount} Rooms Found ',
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
                                  // Show Dialog of pg details
                                  showDialog<void>(
                                    context: context,
                                    useSafeArea: false,
                                    builder: (BuildContext context) {
                                      return Scaffold(
                                        body: CustomScrollView(
                                          slivers: [
                                            SliverAppBar(
                                              elevation: 0,
                                              title: Text(
                                                'Details',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Outfit2'),
                                              ),
                                              centerTitle: true,
                                              backgroundColor: Color.fromARGB(
                                                  255, 253, 253, 253),
                                              leading: Icon(
                                                Icons.arrow_back_ios,
                                                color: Color.fromARGB(
                                                    255, 39, 114, 231),
                                              ),
                                            ),
                                            SliverList(
                                                delegate:
                                                    SliverChildListDelegate([
                                              SizedBox(
                                                height: 20,
                                              ),
                                              // Image Carousel
                                              Container(
                                                child: CarouselSlider(
                                                  items: [
                                                    //1st Image of Slider
                                                    Container(
                                                      margin:
                                                          EdgeInsets.all(6.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              notes[index]
                                                                  ['image']),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),

                                                    //2nd Image of Slider
                                                    Container(
                                                      margin:
                                                          EdgeInsets.all(6.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://whtpwasrwgalpfghlxsy.supabase.co/storage/v1/object/sign/pg/r1.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwZy9yMS5qcGciLCJpYXQiOjE2ODgxMzU4NTAsImV4cCI6MTY5MDcyNzg1MH0.hINiqHKwiyrZT6cn4TBnto5_3Us9CjLL2aNGEJgvTNM&t=2023-06-30T14%3A37%3A29.929Z"),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),

                                                    //3rd Image of Slider
                                                  ],

                                                  //Slider Container properties
                                                  options: CarouselOptions(
                                                    height: 180.0,
                                                    enlargeCenterPage: true,
                                                    autoPlay: true,
                                                    aspectRatio: 16 / 9,
                                                    autoPlayCurve:
                                                        Curves.fastOutSlowIn,
                                                    enableInfiniteScroll: true,
                                                    autoPlayAnimationDuration:
                                                        Duration(
                                                            milliseconds: 800),
                                                    viewportFraction: 0.8,
                                                  ),
                                                ),
                                              )

                                              // Details
                                              ,
                                              Container(
                                                width: 800,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        notes[index]['pg_name'],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Outfit2',
                                                            fontSize: 25),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    39,
                                                                    114,
                                                                    231),
                                                          ),
                                                          Text(
                                                            notes[index][
                                                                    'location'] +
                                                                ', ' +
                                                                '' +
                                                                notes[index]
                                                                    ['city'],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Outfit2'),
                                                          ),
                                                        ],
                                                      ),
                                                      // Icons Cirlce
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                CircleAvatar(
                                                                    child: Icon(
                                                                        Icons
                                                                            .wifi)),
                                                                Text(
                                                                  'Free Wifi',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Outfit2'),
                                                                )
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                CircleAvatar(
                                                                    child: Icon(
                                                                        Icons
                                                                            .chair)),
                                                                Text(
                                                                  'Furnished',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Outfit2'),
                                                                )
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                CircleAvatar(
                                                                    child: Icon(
                                                                        Icons
                                                                            .emoji_food_beverage)),
                                                                Text(
                                                                  'Kitchen',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Outfit2'),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      //  Description
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Description',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Outfit2',
                                                                fontSize: 17),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            notes[index]
                                                                ['facil'],
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                notes[index][
                                                                        'rent'] +
                                                                    ' Rs' +
                                                                    '/ Month',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        25,
                                                                    fontFamily:
                                                                        'Outfit2',
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            39,
                                                                            114,
                                                                            231)),
                                                              ),
                                                              SizedBox(
                                                                width: 150,
                                                                height: 50,
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => const welcome_nh()),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Book Now',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Outfit2',
                                                                              fontSize: 20),
                                                                        )),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]))
                                          ],
                                        ),
                                        bottomNavigationBar: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: BottomNavigationBar(
                                            elevation: 2,
                                            items: [
                                              BottomNavigationBarItem(
                                                  icon: Icon(Icons.home),
                                                  label: 'Home'),
                                              BottomNavigationBarItem(
                                                  icon: Icon(Icons.favorite),
                                                  label: 'Favourites')
                                            ],
                                          ),
                                        ),
                                      );
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourites')
          ],
        ),
      ),
    );
  }
}

Future<String> getUsernameFromSharedPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username') ?? '';
  return username;
}
