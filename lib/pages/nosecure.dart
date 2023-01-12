
import 'package:flutter/material.dart';

class NoSecure extends StatefulWidget {
  final String serial;

  const NoSecure({
    Key? key,
    required this.serial,
  }) : super(key: key);

  @override
  State<NoSecure> createState() => _NoSecureState();
}

class _NoSecureState extends State<NoSecure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account defect"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity, child: Text("It seems you forgot to secure your account before now.",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Raleway",
                  fontSize: 15
                ), textAlign: TextAlign.center,),),
              SizedBox(width: double.infinity, height: 10,),
              SizedBox(width: double.infinity, child: Text("To ensure that your account has not been compromised, we will have to help reset your password from our end. Kindly send a mail containing your account number or phone number to the email address below or send us a message on any of our social media handles and one of our care agents will reachout to you, ready to help.",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Raleway",
                    fontSize: 15
                ), textAlign: TextAlign.center,),),
              SizedBox(width: double.infinity, height: 10,),
              SizedBox(width: double.infinity, child: Text("hello@standardbullion.co",
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
