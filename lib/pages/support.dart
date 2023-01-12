import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity, child: Text("Contact us:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Raleway",
                    fontSize: 15
                ), textAlign: TextAlign.center,),),
              SizedBox(width: double.infinity, height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.instagram, color: Colors.blue, size: 20.0),
                  SizedBox(width: 5,),
                  Icon(FontAwesomeIcons.twitter, color: Colors.blue, size: 20.0),
                  SizedBox(width: 5,),
                  Text("Bulliontrustng", style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue
                  ),)
                ],
              ),
              SizedBox(width: double.infinity, height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.linkedinIn, color: Colors.blue, size: 20.0),
                  SizedBox(width: 10,),
                  Text("Standard Bullion Trust", style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue
                  ),)
                ],
              ),
              SizedBox(width: double.infinity, height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.envelope, color: Colors.blue, size: 20.0),
                  SizedBox(width: 10,),
                  Text("hello@standardbullion.co", style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue
                  ),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
