import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Payment_Cust extends StatefulWidget{
  @override
  State<Payment_Cust> createState() => _Payment_CustState();
}

class _Payment_CustState extends State<Payment_Cust> {
  User? _currentUser;
  CollectionReference? _userPaymentsRef;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    // Wait for the Firebase Auth instance to get the current user.
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUser = user;
      if (user != null) {
        _userPaymentsRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('payments');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.white]
        )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text('Payment Info',
            style: GoogleFonts.lexendDeca(
              textStyle: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 25,
                letterSpacing: .5
              )
            ),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white70, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _userPaymentsRef?.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error loading payments'));
                    }

                    final payments = snapshot.data?.docs ?? [];

                    if (payments.isEmpty) {
                      return Center(child: Text('No payments found.'));
                    }

                    return ListView.builder(
                      itemCount: payments.length,
                      itemBuilder: (context, index) {
                        final payment = payments[index].data() as Map<String, dynamic>;
                        final month = payment['month'] ?? 'Unknown';
                        final dueAmount = payment['dueAmount'] ?? 0;
                        final isPaid = payment['isPaid'] ?? false;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            elevation: 3,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/detailed_payment');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(16.0),
                                  title: Text(
                                    'Month: $month',
                                    style: GoogleFonts.lora(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      )
                                    )
                                  ),
                                  subtitle: Text(
                                    'Due Amount: ₹$dueAmount',
                                    style: GoogleFonts.lora(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade700
                                        )
                                    )
                                  ),
                                  trailing: isPaid
                                      ? Icon(Icons.check_circle, color: Colors.green, size: 30)
                                      : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () => _makePayment(payments[index].id),
                                    child: Text('Pay Now',
                                    style: GoogleFonts.lora(
                                      textStyle: TextStyle(
                                        color: Colors.white
                                      )
                                    ),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePayment(String paymentId) async {
    final User? _currentUser = FirebaseAuth.instance.currentUser;

    if (_currentUser == null) {
      return;
    }

    final DocumentReference paymentRef = FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.uid)
        .collection('payments')
        .doc(paymentId);

    try {
      await paymentRef.update({'isPaid': true});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment successful!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed. Please try again.')),
      );
    }
  }

  Future<void> addExamplePayments() async {
    final payments = FirebaseFirestore.instance.collection('payments');

    final examplePayments = [
      {'month': 'January', 'dueAmount': 5000, 'isPaid': false},
      {'month': 'February', 'dueAmount': 5000, 'isPaid': true},
      {'month': 'March', 'dueAmount': 4500, 'isPaid': false},
    ];

    for (var payment in examplePayments) {
      await payments.add(payment);
    }
  }

}