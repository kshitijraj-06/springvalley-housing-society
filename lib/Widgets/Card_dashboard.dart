import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cards extends StatelessWidget{
  final String Name;
  final Icon icon;

  const Cards({
    super.key,
    required this.Name,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Card(
        elevation: 01,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 0),
            child: Container(
              width: MediaQuery.of(context).size.width/2.687,
              height: 100,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    SizedBox(
                      width: 7,
                    ),
                    Text(Name,
                    style: GoogleFonts.lexendDeca(
                      fontSize: 20,
                    ),),
                  ],
                ),
              ),
            ),
          ),

      ),
    );
  }
  
}