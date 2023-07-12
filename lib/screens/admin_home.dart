import 'package:flutter/material.dart';
import 'package:newhome/screens/add_pg.dart';

class admin_nh extends StatefulWidget {
  const admin_nh({super.key});

  @override
  State<admin_nh> createState() => _admin_nhState();
}

class _admin_nhState extends State<admin_nh> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Home',
          style: TextStyle(color: Colors.black, fontFamily: 'Outfit2'),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 253, 253, 253),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Color.fromARGB(255, 39, 114, 231),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const addpg_nh()),
                    );
                  },
                  child: Text('Register new PG'))
            ],
          ),
        ),
      ),
    );
  }
}
