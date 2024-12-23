import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:springvalley1/Widgets/Card_dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic> _newsArticles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final url = Uri.parse(
        'https://saurav.tech/NewsAPI/top-headlines/category/health/in.json');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _newsArticles = data['articles'];
        });
      } else {
        print('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white])),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Spring Valley Phase - 1',
                  style: GoogleFonts.dmSerifText(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white70, Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Image.asset('assets/google.png'),
                              ),
                              Text(
                                'Hello Name',
                                style: GoogleFonts.lexendDeca(
                                    textStyle: TextStyle(fontSize: 15)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap : (){
                                Navigator.pushNamed(context, '/payment_cust');
                              },
                              child: Cards(
                                  Name: 'Payment',
                                  icon: Icon(Icons.paypal_outlined)),
                            ),
                            Cards(
                                Name: 'Social',
                                icon: Icon(Icons.facebook_outlined))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Cards(
                                Name: 'Card3', icon: Icon(Icons.paypal_outlined)),
                            Cards(
                                Name: 'Card4',
                                icon: Icon(Icons.facebook_outlined))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Upcoming Meeting Details',
                        style: GoogleFonts.lexendDeca(
                          fontSize: 20
                        ),),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 90,
                            child: Card(
                              elevation: 1,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Meeting updates',
                                  style: GoogleFonts.lexendDeca(),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "Today's Top News",
                          style: GoogleFonts.lexendDeca(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 400,
                          width: 400  ,
                          child: ListView.builder(
                              itemCount: _newsArticles.length,
                              itemBuilder: (context, index) {
                                final article = _newsArticles[index];
                                return Card(
                                  margin: EdgeInsets.only(left: 10, bottom: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (article['urlToImage'] != null)
                                          Image.network(article['urlToImage']),
                                        SizedBox(height: 8),
                                        Text(
                                          article['title'] ?? 'No Title',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          article['description'] ??
                                              'No Description',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                    
                      ],
                    ),
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
