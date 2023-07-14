// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_options.dart';
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
  String value = '';
  var pgdata = '';
  List<Map<String, dynamic>> item = [];

  search_pg() async {
    final data = await supabase
        .from('pg_det')
        .select('pg_name')
        .like('city', '%_$value%');

    print("String:$value");
    print("matched Pg:$data");
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
                        child: SearchBar(
                          hintText: 'Enter Place',
                          onChanged: (value) async {
                            var data = await supabase
                                .from('pg_det')
                                .select('pg_name, rent')
                                .ilike('city', '$value%');

                            // print(data['pg_name']);
                            final item = data;
                            print("String:$value");
                            print("matched Pg:${item}");
                            // print(data[0]);

                            // item.forEach((map) {
                            //   map.forEach((key, value) {
                            //     print('$key: $value');
                            //   });
                            // });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  height: 200,
                  child: Column(
                    children: [Text('data')],
                  ))
            ],
          ),
        ));
  }
}
