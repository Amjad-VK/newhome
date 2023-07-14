// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class myprof_nh extends StatefulWidget {
  const myprof_nh({super.key});

  @override
  State<myprof_nh> createState() => _myprof_nhState();
}

class _myprof_nhState extends State<myprof_nh> {
  @override
  var formkey = GlobalKey<FormState>();
  var u_email = TextEditingController();
  var u_name = TextEditingController();
  var u_pass = TextEditingController();

  void initState() {
    // TODO: impleme
    super.initState();
    get_userdet();
  }

  update_userdet() async {
    final UserResponse res = await supabase.auth.updateUser(
      UserAttributes(
        data: {'username': u_name.text},
         email: u_email.text,
         password: u_pass.text,
      ),
    );
    final User? updatedUser = res.user;
  }

  get_userdet() async {
    User? user = await supabase.auth.currentUser;
    print(user!.email);
    setState(() {
      u_email.text = user.email.toString();
      u_name.text = user.userMetadata!["username"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.black, fontFamily: 'Outfit2'),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 253, 253, 253),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Color.fromARGB(255, 39, 114, 231),
        ),
      ),
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/uu.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: u_name,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'Username',
                    hintStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    fillColor: Color.fromARGB(78, 39, 113, 231)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: u_email,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'Email',
                    hintStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    fillColor: Color.fromARGB(78, 39, 113, 231)),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(controller: u_pass,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'New Password',
                    hintStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    fillColor: Color.fromARGB(78, 39, 113, 231)),
              ),
            ),
            SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      update_userdet();
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(fontFamily: 'Outfit2'),
                    )))
          ],
        ),
      ),
    );
  }
}
