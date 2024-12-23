import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import '../Services/auth_service.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (account != null) {
        _saveUserDataToFirestore(account);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleLogin(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (FirebaseAuth.instance.currentUser != null) {
        print("User logged in: ${FirebaseAuth.instance.currentUser!.uid}");

        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        print("Error: Failed to log in");
      }
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _saveUserDataToFirestore(GoogleSignInAccount account) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(account.id);
    await userDoc.set({
      //'name': account.displayName,
      'email': account.email ?? ' ',
      //'photoUrl': account.photoUrl,
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text('Spring Valley Phase - 1',
                style: GoogleFonts.dmSerifText(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/logo2.json',height: 250, width: 250),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Enter Email',
                          style: GoogleFonts.lexendDeca(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15
                            )
                          ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7,),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade100
                            )
                          )
                        ),
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Enter Password',
                          style: GoogleFonts.lexendDeca(
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal
                            )
                          ),),
                        ),
                      ),
                      SizedBox(height: 7,),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade100
                                )
                            )
                        ),
                      ),
                      SizedBox(height: 10,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button background color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Padding
                    ),
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 200)); // Simulate animation delay
                      _handleLogin(context);
                    },
                  child: Text('Sign In with Google'),
                ),
                      SizedBox(height: 50,),
                      GestureDetector(
                        onTap: (){
                         // _handleSignIn();
                        },
                          child: Image.asset('assets/google.png',scale: 10,)
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: (){
                          print('Forgot Clicked');
                        },
                        child: Text('Forgot Password?',
                        style: GoogleFonts.lexendDeca(
                          color: Colors.red,
                          fontSize: 14
                        ),),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}