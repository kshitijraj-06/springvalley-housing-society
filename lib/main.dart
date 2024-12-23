import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:springvalley1/Login/login.dart';
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
      home: LoginPage(),
      routes: {
        '/dashboard' : (context)=> Dashboard(),
        '/payment_cust' : (context)=> Payment_Cust(),
      },
    );
  }
}
