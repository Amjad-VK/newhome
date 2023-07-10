// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newhome/screens/home_pageui.dart';
import 'package:newhome/screens/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class login_nha extends StatefulWidget {
  const login_nha({super.key});

  @override
  State<login_nha> createState() => _login_nhaState();
}

class _login_nhaState extends State<login_nha> {
  var formkey = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass = TextEditingController();

  void error() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          backgroundColor: Colors.redAccent, content: Text('Email not valid!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/images/bg.jpg'))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(196, 228, 231, 238)),
                width: 350,
                height: 500,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Welcome',
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
                            height: 60,
                            child: TextFormField(
                              validator: (email) {
                                if (email!.isEmpty ||
                                    !email.contains('@') ||
                                    !email.contains('.')) {
                                  return 'Enter valid email';
                                } else
                                  return null;
                              },
                              controller: email,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: InputBorder.none,
                                  filled: true,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  fillColor: Color.fromARGB(78, 39, 113, 231)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                            width: 300,
                            height: 60,
                            child: TextFormField(
                              validator: (pass) {
                                if (pass == null || pass.isEmpty) {
                                  return 'Enter a valid Password';
                                } else
                                  return null;
                              },
                              controller: pass,
                              decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: InputBorder.none,
                                  filled: true,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  fillColor: Color.fromARGB(78, 39, 113, 231)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                final valid = formkey.currentState!.validate();
                                if (valid) {
                                  final AuthResponse res =
                                      await supabase.auth.signInWithPassword(
                                    email: email.text,
                                    password: pass.text,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home_nh()),
                                  );
                                }
                              },
                              child: Text('Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const signup_nh()),
                            );
                          },
                          child: Text(
                            'Dont  have an Account? Sign Up Now',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
