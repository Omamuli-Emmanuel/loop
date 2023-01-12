
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:standardbullionbank/pages/questionsmodal.dart';
import 'package:standardbullionbank/pages/secure.dart';

import 'login.dart';

class Ask extends StatefulWidget {

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
  final String tpin;
  final int mGold;
  final int mSilver;
  final String email;

  const Ask({
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
    required this.tpin,
    required this.mGold,
    required this.mSilver,
    required this.email,
  }) : super(key: key);

  @override
  State<Ask> createState() => _AskState();
}

class _AskState extends State<Ask> {


  String id = '';
  String serial = '';
  String fname = '';
  String lname = '';
  String phone = '';
  String bankAccName = '';
  String bankName = '';
  String accNumber = '';
  String wallet = '';
  String assetOunce = '';
  String accType = '';
  String status = '';
  String role = '';
  String buy = '';
  String sell = '';
  String secure = '';
  String tpin = '';
  String target = '';
  int marketGold = 0;
  int marketSilver = 0;
  String email = "";


  //list of all profit n loss
  List<QuestionsAnswerList> _transactions = List.empty(growable: true);

  String getallthequestions = "https://standardbullion.co/api/getAllTheQuestions.php";
  String checkSecAnswer = "https://standardbullion.co/api/checkSecurityAnswers.php";


  TextEditingController questionOneAnswerController = TextEditingController();
  TextEditingController questionTwoAnswerController = TextEditingController();
  TextEditingController questionThreeAnswerController = TextEditingController();

  TextEditingController changePasswordController = TextEditingController();
  TextEditingController transactionPinController = TextEditingController();

  String changePasswordLink = "https://standardbullion.co/api/changePasswordHere.php";

  @override
  void initState() {
    GallQuestions().then((value) {
      setState(() {
        _transactions.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Change password"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text("Please answer the following security questions", style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: "Raleway"
              ),),
            ),
            SizedBox(width: double.infinity, height: 15,),
            Expanded(
                child: listallQuestions()
            ),
            ElevatedButton(
                onPressed: (){
                  CheckAnswers();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue
                ),
                child: Text("Change password", style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ))
            )
          ],
        )
      ),
    );
  }

  Future<List<QuestionsAnswerList>>  GallQuestions() async {
    Map jsonData = {
      "serial": widget.serial,
    };

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(getallthequestions));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyTwo = await resp.transform(utf8.decoder).join();
    print("Reply is: " + replyTwo.toString());

    var transacts = json.decode(replyTwo);

    List<QuestionsAnswerList> trac = List.empty(growable: true);

    for(var transact in transacts){
      trac.add(QuestionsAnswerList.fromJson(transact));
    }

    if(trac.length <= 0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Secure(
          id: widget.id,
          serial: widget.serial,
          fname: widget.fname,
          lname: widget.lname,
          phone: widget.phone,
          bankAccName: widget.bankAccName,
          bankName: widget.bankName,
          accNumber: widget.accNumber,
          wallet: widget.wallet,
          assetOunce : widget.assetOunce,
          accType : widget.accType,
          status: widget.status,
          buy: widget.buy,
          sell: widget.sell,
          target: widget.target,
          mGold: widget.mGold,
          mSilver: widget.mSilver,
          email: widget.email
      )));
    }

    httpClient.close();
    // List<String> getTransact = new List<String>.from();
    //
    // print(trac);
    return trac;
  }

  Widget listallQuestions(){
    return ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (context, index){
          return
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Card(
                    elevation: 3,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(child: Text("Question One ", style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                              color: Colors.blue,
                              fontFamily: "Raleway"
                      ),), width: double.infinity,),
                          SizedBox(width: double.infinity, child: (
                          Text(_transactions[index].questionOne + " ?", style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Raleway"
                          ),)
                          ),),
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: questionOneAnswerController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.blue),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 3,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(child: Text("Question Two ", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue,
                              fontFamily: "Raleway"
                          ),), width: double.infinity,),
                          SizedBox(width: double.infinity, child: (
                              Text(_transactions[index].questionTwo + " ?", style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Raleway"
                              ),)
                          ),),
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: questionTwoAnswerController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.blue),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 3,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(child: Text("Question Three ", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue,
                              fontFamily: "Raleway"
                          ),), width: double.infinity,),
                          SizedBox(width: double.infinity, child: (
                              Text(_transactions[index].questionThree + " ?", style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Raleway"
                              ),)
                          ),),
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: questionThreeAnswerController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.blue),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
        });
  }

  Future CheckAnswers() async {
    Map jsonData = {
      "serial": widget.serial,
      "answerOne" : "${questionOneAnswerController.text}",
      "answerTwo" : "${questionTwoAnswerController.text}",
      "answerThree" : "${questionThreeAnswerController.text}"
    };

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(checkSecAnswer));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyTwo = await resp.transform(utf8.decoder).join();
    print("Reply is: " + replyTwo.toString());

    httpClient.close();
    Map <String, dynamic> map = json.decode(replyTwo.toString());

    print(map["message"]);

    if(map["message"] == "Success"){
      changePassword(context);
    }else{
      final successSnackbar = SnackBar(
        backgroundColor: Colors.red[800],
        content: const Text("One or more of your answers are incorrect... try again",
          style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
        ),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Ok',
          onPressed: (){},
        ),
        duration: Duration(milliseconds: 10000),
      );
      ScaffoldMessenger.of(context).showSnackBar(successSnackbar);
    }

  }

  changePassword(context){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context){
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 180,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: double.infinity, height: 5,),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: changePasswordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Change account password"
                      ),
                    ),
                    SizedBox(width: double.infinity, height: 5,),
                    ElevatedButton(
                        onPressed: (){
                          changePasswordNow();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        child: Text("Change password", style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ))
                    ),
                    Text("Do not share your login information with anyone. If you believe your account has been compromised, kindly reachout to us immediately", style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.red
                    ), textAlign: TextAlign.center,),
                  ],
                ),
              )
          );
        }
    );
  }

  Future changePasswordNow() async{

    Map jsonData = {
      "serial" : widget.serial,
      "password" : changePasswordController.text,
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(changePasswordLink));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("Reply is: "+reply.toString());

    Map <String, dynamic> map = json.decode(reply.toString());

    if(map['message'] == "Successful"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }


}
