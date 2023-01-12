
import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy & Terms"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity, child: Text("We realise that not alot of persons take the time to go through privacy "
                  " and terms of service of applications such as this. This is why we have made it a step easier for you to share our privacy and terms of service page"
                  " with your trusted adviser.",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Raleway",
                    fontSize: 15
                ), textAlign: TextAlign.center,),),
              SizedBox(width: double.infinity, height: 10,),
              SizedBox(width: double.infinity, child: Text("You will find our privacy policies and terms of service when you follow the link below:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Raleway",
                    fontSize: 15
                ), textAlign: TextAlign.center,),),
              SizedBox(width: double.infinity, height: 10,),
              SizedBox(width: double.infinity, child: Text("https://www.standardbullion.co/privacy_terms",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Raleway",
                    fontSize: 15
                ), textAlign: TextAlign.center,),),
            ],
          ),
        ),
      ),
    );
  }
}
