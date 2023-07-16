// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newhome/screens/add_pg.dart';
import 'package:newhome/screens/admin_managepg%20copy.dart';
import 'package:newhome/screens/user_searchpg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class admin_nh extends StatefulWidget {
  const admin_nh({super.key});

  @override
  State<admin_nh> createState() => _admin_nhState();
}

class _admin_nhState extends State<admin_nh> {
  dynamic getcount = '';

  @override
  void initState() {
    super.initState();
    get_pgcount();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.account_box_rounded,
              color: Colors.black,
            ),
            Text(
              'Admin Home',
              style: TextStyle(color: Colors.black, fontFamily: 'Outfit2'),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 253, 253, 253),
        
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 102, 153, 204),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL REGISTERED PG',
                        style: TextStyle(
                          fontFamily: 'Outfit2',
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getcount.toString(),
                              style: TextStyle(
                                  fontFamily: 'Outfit2',
                                  color: Colors.black,
                                  fontSize: 50),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Image(
                                  height: 80,
                                  image: AssetImage('assets/images/ds.png')),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              'Actions',
              style: TextStyle(
                  fontFamily: 'Outfit2',
                  fontSize: 25,
                  decoration: TextDecoration.underline),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const addpg_nh()),
                      );
                    },
                    child: Text(
                      'Add New PG',
                      style: TextStyle(fontFamily: 'Outfit2', fontSize: 20),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const admin_pg_manage()),
                      );
                    },
                    child: Text(
                      'Manage PGs',
                      style: TextStyle(fontFamily: 'Outfit2', fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
