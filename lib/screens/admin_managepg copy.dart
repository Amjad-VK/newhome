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
  // String value = 'ko';
  dynamic pgdata = '';
  List<dynamic> newVariable = [];
  List<Map<String, String>> item = [];

  search_pg(String value) async {
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
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 39, 114, 231),
            ),
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
                            hintText: "Enter a Location",
                            leading: Icon(Icons.search),
                            onChanged: (value) {
                              search_pg(value);
                            },
                          )
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
                child: Text(
                  'Search Results',
                  style: TextStyle(fontFamily: 'Outfit2'),
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
                                barrierDismissible:
                                    true, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // <-- SEE HERE
                                    title: Text(data['pg_name']),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Update'),
                                        onPressed: () async {
                                          // Update
                                          
await supabase
  .from('pg_det')
  .update({ 'pg_name': 'Middle Earth' })
  .match({ 'name': 'Auckland' });
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Delete'),
                                        onPressed: () async {
                                          // Delete;
                                          await supabase
                                              .from('pg_det')
                                              .delete()
                                              .match({'id': data['id']});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                backgroundColor:
                                                    Colors.greenAccent,
                                                content:
                                                    Text('Deleted Succesfully')),
                                                    
                                          );
                                        },
                                      ),
                                    ],
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
