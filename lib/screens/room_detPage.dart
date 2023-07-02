// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newhome/screens/welcome.dart';

class roomdet_2 extends StatefulWidget {
  const roomdet_2({super.key});

  @override
  State<roomdet_2> createState() => _roomdet_2State();
}

class _roomdet_2State extends State<roomdet_2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            title: Text(
              'Details',
              style: TextStyle(color: Colors.black, fontFamily: 'Outfit2'),
            ),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 253, 253, 253),
            leading: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 39, 114, 231),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            // Image Carousel
            Container(
              child: CarouselSlider(
                items: [
                  //1st Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://whtpwasrwgalpfghlxsy.supabase.co/storage/v1/object/sign/pg/r1.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwZy9yMS5qcGciLCJpYXQiOjE2ODgxMzU4NTAsImV4cCI6MTY5MDcyNzg1MH0.hINiqHKwiyrZT6cn4TBnto5_3Us9CjLL2aNGEJgvTNM&t=2023-06-30T14%3A37%3A29.929Z"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //2nd Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
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
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
            )

            // Details
            ,
            Container(
              width: 800,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Heidhin Home Stay',
                      style: TextStyle(fontFamily: 'Outfit2', fontSize: 25),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 39, 114, 231),
                        ),
                        Text(
                          'Kozhikode, Kerala',
                          style: TextStyle(fontFamily: 'Outfit2'),
                        ),
                      ],
                    ),
                    // Icons Cirlce
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(child: Icon(Icons.wifi)),
                              Text(
                                'Free Wifi',
                                style: TextStyle(fontFamily: 'Outfit2'),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(child: Icon(Icons.chair)),
                              Text(
                                'Furnished',
                                style: TextStyle(fontFamily: 'Outfit2'),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                  child: Icon(Icons.emoji_food_beverage)),
                              Text(
                                'Kitchen',
                                style: TextStyle(fontFamily: 'Outfit2'),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    //  Description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(fontFamily: 'Outfit2', fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Tons of users visit FlutterBeads regularly. Join the newsletters to get best Flutter Tutorials.Tons of users visit FlutterBeads regularly. Join the newsletters to get best Flutter Tutorials',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '2500 Rs/ Month',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Outfit2',
                                  color: Color.fromARGB(255, 39, 114, 231)),
                            ),
                            SizedBox(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const welcome_nh()),
                                    );
                                  },
                                  child: Text(
                                    'Book Now',
                                    style: TextStyle(
                                        fontFamily: 'Outfit2', fontSize: 20),
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
