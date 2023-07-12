import 'package:flutter/material.dart';
import 'package:newhome/screens/home_pageui.dart';
import 'package:newhome/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    // Delay the navigation for a certain duration (e.g., 2 seconds)
    await Future.delayed(Duration(seconds: 3));

    if (email != null && email.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home_nh()),
      ); // Navigate to home page
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => login_nha()),
      ); // Navigate to login page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/nhuia.png',
              width: 100,
            ),
            Text(
              'NewHome',
              style: TextStyle(fontFamily: 'Outfit2', fontSize: 25),
            )
          ],
        ), // Add a loading indicator or splash screen UI here
      ),
    );
  }
}
