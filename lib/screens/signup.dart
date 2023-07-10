// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newhome/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class signup_nh extends StatefulWidget {
  const signup_nh({super.key});

  @override
  State<signup_nh> createState() => _signup_nhState();
}

class _signup_nhState extends State<signup_nh> {
  var formkey = GlobalKey<FormState>();
  var uname = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var cpass = TextEditingController();

  Future<void> saveUserDataToSharedPrefs(String email, String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', email);
    await prefs.setString('username', username);

    print('User data saved to shared preferences');
  }
//   Future<void> signup() async {

// final Session? session = res.session;
// final User? user = res.user;
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                  height: 600,
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'SignUp',
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
                              child: TextField(
                                controller: uname,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    border: InputBorder.none,
                                    filled: true,
                                    hintText: 'Username',
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
                                    fillColor:
                                        Color.fromARGB(78, 39, 113, 231)),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                controller: pass,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    border: InputBorder.none,
                                    filled: true,
                                    hintText: 'Password',
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
                                validator: (conpass) {
                                  if (conpass!.isEmpty || conpass.length < 6) {
                                    return 'Password Too Short or Empty';
                                  } else if (cpass.text != pass.text) {
                                    return 'Password does not match!';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: cpass,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    border: InputBorder.none,
                                    filled: true,
                                    hintText: 'Confirm Password',
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
                            child: ElevatedButton(
                                onPressed: () async {
                                  final valid =
                                      formkey.currentState!.validate();
                                  if (valid) {
                                    final AuthResponse res =
                                        await supabase.auth.signUp(
                                      email: email.text,
                                      password: pass.text,
                                      data: {'username': uname.text},
                                    );

                                    saveUserDataToSharedPrefs(
                                        email.text, uname.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.greenAccent,
                                          content: Text('Success')),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const login_nha()),
                                    );
                                    final Session? session = res.session;
                                    final User? user = res.user;
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.redAccent,
                                          content: Text('Error!')),
                                    );
                                  }
                                },
                                child: Text('SignUp',
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
                                    builder: (context) => const login_nha()),
                              );
                            },
                            child: Text(
                              'Already have an Account? SignIn Now',
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
      ),
    );
  }
}
