import 'package:flutter/material.dart';
import 'package:newhome/screens/add_pg.dart';
import 'package:newhome/screens/add_pg2.dart';
import 'package:newhome/screens/admin_home.dart';
import 'package:newhome/screens/admin_managepg.dart';
import 'package:newhome/screens/admin_pgmg2.dart';

import 'package:newhome/screens/home_pageui.dart';

import 'package:newhome/screens/login.dart';
import 'package:newhome/screens/my_profile.dart';
import 'package:newhome/screens/room_detPage.dart';

import 'package:newhome/screens/signup.dart';
import 'package:newhome/screens/splash_screen.dart';
import 'package:newhome/screens/welcome.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://whtpwasrwgalpfghlxsy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndodHB3YXNyd2dhbHBmZ2hseHN5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODgwMjEzNDEsImV4cCI6MjAwMzU5NzM0MX0.vSUFZbX5k9Uo2_oQWEuauWh1w7jDGVIfkv8_R3VSp6o',
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: admin_pg_manage(),
  ));
}


// void main() {
//   runApp(MaterialApp(
//     theme: ThemeData(
//         fontFamily: 'Outfit', primaryColor: Color.fromARGB(255, 39, 114, 231)),
//     home: Home_nh(),
//   ));
// }
