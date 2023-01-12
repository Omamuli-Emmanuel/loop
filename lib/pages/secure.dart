
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'dashboard.dart';

class Secure extends StatefulWidget {
  final String id;
  final String serial;
  final String fname;
  final String lname;
  final String phone;
  final String bankAccName;
  final String bankName;
  final String accNumber;
  final String wallet;
  final String assetOunce;
  final String accType;
  final String status;
  final String buy;
  final String sell;
  final String target;
  final int mGold;
  final int mSilver;
  final String email;

  const Secure({
    Key? key,
    required this.id,
    required this.serial,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.bankAccName,
    required this.bankName,
    required this.accNumber,
    required this.wallet,
    required this.assetOunce,
    required this.accType,
    required this.status,
    required this.buy,
    required this.sell,
    required this.target,
    required this.mGold,
    required this.mSilver,
    required this.email,
  }) : super(key: key);

  @override
  State<Secure> createState() => _SecureState();
}

class _SecureState extends State<Secure> {

  TextEditingController questionOneController = TextEditingController();
  TextEditingController questionTwoController = TextEditingController();
  TextEditingController questionThreeController = TextEditingController();

  TextEditingController questionOneAnswer = TextEditingController();
  TextEditingController questionTwoAnswer = TextEditingController();
  TextEditingController questionThreeAnswer = TextEditingController();

  //variables
  String address = "https://standardbullion.co/api/secure.php";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Account security"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity, height: 5,),
              SizedBox(width: double.infinity, child: Text(
                "Before you begin",
                style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.red
                ),
              ),),
              SizedBox(width: double.infinity, child: Text(
                "It is important to note that the security of your account is the collective responsibility yourself and our team of engineers. That said, you may ask the questions you would like, and provide the answers yourself. Answers are case sensitive. if you forget the answers to your questions, you may need to contact us to manually change your password if need be.",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),
              ),),
              SizedBox(width: double.infinity, height: 10,),
              SizedBox(width: double.infinity, child: Text("Question One", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
              TextField(
                keyboardType: TextInputType.text,
                controller: questionOneController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(width: double.infinity, height: 10,),
              SizedBox(width: double.infinity, child: Text("Answer", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
              TextField(
                keyboardType: TextInputType.text,
                controller: questionOneAnswer,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(width: double.infinity, height: 10,),
              SizedBox(width: double.infinity, child: Text("Question Two", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
              TextField(
                keyboardType: TextInputType.text,
                controller: questionTwoController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(width: double.infinity, height: 10,),
              SizedBox(width: double.infinity, child: Text("Answer", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
              TextField(
                keyboardType: TextInputType.text,
                controller: questionTwoAnswer,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(width: double.infinity, height: 15,),
              SizedBox(width: double.infinity, child: Text("Question Three", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
              TextField(
                keyboardType: TextInputType.text,
                controller: questionThreeController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(width: double.infinity, height: 10,),
              SizedBox(width: double.infinity, child: Text("Answer", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
              TextField(
                keyboardType: TextInputType.text,
                controller: questionThreeAnswer,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(width: double.infinity, height: 10,),
              ElevatedButton(
                  onPressed: (){
                    _secure();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue
                  ),
                  child: Text("Secure account", style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ))
              )
            ],
          ),
        ),
      ),
    );
  }

  Future  _secure() async{

    print("Address is: "+address);

    Map jsonData = {
      "serial" : "${int.parse(widget.serial)}",
      "QuestionOne" : "${questionOneController.text}",
      "AnswerOne" : "${questionOneAnswer.text}",
      "QuestionTwo" : "${questionTwoController.text}",
      "AnswerTwo" : "${questionTwoAnswer.text}",
      "QuestionThree" : "${questionThreeController.text}",
      "AnswerThree" : "${questionThreeAnswer.text}"
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(address));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("Reply is: "+reply.toString());

    httpClient.close();
    Map <String, dynamic> map = json.decode(reply.toString());

    if(map["message"] == "successful"){
      Navigator.pop(context);
    }
  }

}
