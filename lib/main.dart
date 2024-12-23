import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:springvalley1/Login/login.dart';
import 'package:springvalley1/Payment/detailed_payment.dart';
import 'package:springvalley1/Payment/payment_cust.dart';
import 'package:springvalley1/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: AuthWrapper(),
      routes: {
        '/dashboard' : (context)=> Dashboard(),
        '/payment_cust' : (context)=> Payment_Cust(),
        '/detailed_payment' : (context) => DetailedPayments()
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          return Dashboard(); // User is logged in
        } else {
          return LoginPage(); // Redirect to login page
        }
      },
    );
  }
}
