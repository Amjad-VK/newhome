// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_options.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newhome/screens/welcome.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class admin_pg_manage extends StatefulWidget {
  const admin_pg_manage({super.key});

  @override
  State<admin_pg_manage> createState() => _admin_pg_manageState();
}

class _admin_pg_manageState extends State<admin_pg_manage> {
  var pgname = TextEditingController();
  var formkey = GlobalKey<FormState>();
  String value = 'ko';
  dynamic pgdata = '';
  List<dynamic> newVariable = [];
  List<Map<String, String>> item = [];

  search_pg() async {
    var data =
        await supabase.from('pg_det').select('*').ilike('city', '$value%');
    print("DTYPE:${data.runtimeType.toString()}");

    setState(() {
      newVariable = data;
    });

    print("matched Pg:$newVariable");

    // data = item;
    // print("Matched PG:${data[0]['pg_name']}");

    print("String:$value");
    // print("matched Pg:$pgdata");
  }

  delete_pg() async {
    await supabase.from('pg_det').delete();
  }

  final _notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Manage PGs',
            style: TextStyle(color: Colors.black, fontFamily: 'Outfit2'),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 253, 253, 253),
          leading: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 39, 114, 231),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: ElevatedButton(
                            onPressed: () async {
                              search_pg();
                            },
                            child: Text('Search')),
                        //  ,SearchBar(
                        //     hintText: 'Enter Place',
                        //     onChanged: (value) async {

                        //       print("matched Pg:${item}");

                        //       // item.forEach((map) {
                        //       //   map.forEach((key, value) {
                        //       //     print('$key: $value');
                        //       //   });
                        //       // });
                        //     },
                        //   ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: newVariable.length,
                      itemBuilder: (context, index) {
                        var data = newVariable[index];
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              showDialog<void>(
                                  context: context,
                                  useSafeArea: false,
                                  builder: (BuildContext context) {return Scaffold(
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
                                              leading: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: Color.fromARGB(
                                                      255, 39, 114, 231),
                                                ),
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
                                                              data
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
                                                        data['pg_name'],
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
                                                            data[
                                                                    'location'] +
                                                                ', ' +
                                                                '' +
                                                                data
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
                                                           data
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
                                                                data[
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
                                                                          // Make Call
                                                                          var ph =
                                                                              data['contact'].toString();
                                                                          print(
                                                                              ph);
                                                                          var url =
                                                                              Uri.parse('tel:${ph}');
                                                                          launchUrl(
                                                                              url);
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
                                      );});
                            },
                            child: Container(
                              height: 200,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(data['image']))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 120, left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['pg_name'],
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
                                          color:
                                              Color.fromARGB(255, 39, 114, 231),
                                        ),
                                        Text(
                                          data['location'] + ',' + data['city'],
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
                      }))
            ],
          ),
        ));
  }
}
