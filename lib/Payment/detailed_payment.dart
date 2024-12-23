import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Services/firestore_service.dart';

class DetailedPayments extends StatefulWidget {
  @override
  State<DetailedPayments> createState() => _DetailedPaymentsState(id: 1);
}

class _DetailedPaymentsState extends State<DetailedPayments> {
  final int id;
  final FirestoreService firestoreService = FirestoreService();

  _DetailedPaymentsState({required this.id});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Payment Details',
              style: GoogleFonts.lora(
                  textStyle: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 29)),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [Colors.white70, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Welcome to Payment Details',
                          style: GoogleFonts.lora(
                              textStyle: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 18,
                                fontWeight: FontWeight.normal
                          )),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Text('Name -',
                            style: GoogleFonts.lora(
                                textStyle: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal
                                )),),
                          FutureBuilder<Map<String, dynamic>?>(
                            future: firestoreService.fetchUserData(id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return Text('Error: ${snapshot.error}',);
                              }
                              if (!snapshot.hasData) {
                                return Center(child: Text('No user data found.'));
                              }

                              Map<String, dynamic> userData = snapshot.data!;
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name: ${userData['name'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                                    Text('Email: ${userData['email'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                                    Text('Phone: ${userData['phone'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
