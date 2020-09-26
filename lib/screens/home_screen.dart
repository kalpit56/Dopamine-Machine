import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Image imgUp = Image.asset('images/button2.png');
  Image imgDown = Image.asset('images/button1.png');
  Image img;
  int counter;

  @override
  void initState() {
    super.initState();
    img = imgUp;
    counter = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            Text(
              "Bored Button",
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(
                color: Colors.black,
                fontSize: 50.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "[Press the button to start]",
              style: GoogleFonts.pressStart2p(
                color: Colors.black,
                fontSize: 10.0,
              ),
            ),
            SizedBox(height: 100.0),
            Text(
              '$counter',
              style: GoogleFonts.pressStart2p(
                color: Colors.black,
                fontSize: 50.0,
              ),
            ),
            Spacer(),
            GestureDetector(
              child: img,

              onTapDown: (tap) {
                setState(() {
                  // when it is pressed
                  img = imgDown;
                  counter++;
                });
              },
              onTapUp: (tap) {
                setState(() {
                  // when it is released
                  img = imgUp;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}


