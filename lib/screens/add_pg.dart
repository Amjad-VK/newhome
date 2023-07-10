// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';

class addpg_nh extends StatefulWidget {
  const addpg_nh({super.key});

  @override
  State<addpg_nh> createState() => _addpg_nhState();
}

class _addpg_nhState extends State<addpg_nh> {
  String? _selectedOption;

  // States
  List<String> _dropdownOptions = ['Kozhikode', 'Kannur', 'Malappuram'];
  File? _selectedImage;

  var formkey = GlobalKey<FormState>();
  var pgname = TextEditingController();
  // var city = TextEditingController();
  var location = TextEditingController();
  var rent = TextEditingController();

  Future<void> inserttotable() async {
    await supabase.from('pg_details').insert({
      'pg_name': pgname.text,
      'city': _selectedOption.toString(),
      'location': location.text,
      'rent': rent.text
    });
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/pgbg.jpg'))),
          child: Center(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(196, 228, 231, 238)),
                    width: 350,
                    height: 600,
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Add PG',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 37, 79, 133),
                                  fontSize: 32),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                                width: 300,
                                height: 50,
                                child: TextFormField(
                                  controller: pgname,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      hintText: 'PG Name',
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      fillColor:
                                          Color.fromARGB(78, 39, 113, 231)),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                              width: 300,
                              height: 50,
                              child: DropdownButtonFormField<String>(
                                value: _selectedOption,
                                items: _dropdownOptions.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedOption = newValue;
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  labelText: 'Select your city',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                                width: 300,
                                height: 50,
                                child: TextFormField(
                                  controller: location,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      hintText: 'Location',
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      fillColor:
                                          Color.fromARGB(78, 39, 113, 231)),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                                width: 300,
                                height: 50,
                                child: TextFormField(
                                  // validator: (conpass) {
                                  //   if (conpass!.isEmpty || conpass.length < 6) {
                                  //     return 'Password Too Short or Empty';
                                  //   } else if (cpass.text != pass.text) {
                                  //     return 'Password does not match!';
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  controller: rent,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      hintText: 'Rent',
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      fillColor:
                                          Color.fromARGB(78, 39, 113, 231)),
                                )),
                          ),
                          SizedBox(
                              width: 250,
                              height: 30,
                              child: ListTile(
                                title: Text('Upload Image'),
                                leading: Icon(Icons.photo_library),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    final valid =
                                        formkey.currentState!.validate();
                                    if (valid) {
                                      inserttotable();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.greenAccent,
                                            content: Text('Added Succesfully')),
                                      );
                                    }
                                  },
                                  child: Text('Submit',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}