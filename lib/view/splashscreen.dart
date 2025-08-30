import 'package:ecommerce/main.dart';
import 'package:ecommerce/view/login.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'SignUp.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shopping App',style: TextStyle(color:  Colors.white)),
        leading: Icon(Icons.shopping_bag,color: Colors.white,),
        backgroundColor: Colors.lightBlue[300],
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
                         const SizedBox(height: 40),

   Image.asset(
    'assets/images/logo.jpg',
    width: 120,
    height: 120,
    fit: BoxFit.cover, 
  ),

   const SizedBox(height: 20),
   Padding(
    padding: const EdgeInsets.all(10.0),
    child: Image.network(
      'https://cdn-icons-png.flaticon.com/512/3081/3081986.png',
          width: 120,
    height: 120,

      fit: BoxFit.contain,
    ),
  ),
            const SizedBox(height: 40),
            // زر التسجيل
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SignUpPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[300],
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[100],
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



