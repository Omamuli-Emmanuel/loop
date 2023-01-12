
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:standardbullionbank/pages/questionsmodal.dart';

import 'login.dart';

class NewAsk extends StatefulWidget {

  final String serial;

  const NewAsk({
    Key? key,
    required this.serial,
  }) : super(key: key);

  @override
  State<NewAsk> createState() => _NewAskState();
}

class _NewAskState extends State<NewAsk> {

  //list of all profit n loss
  List<QuestionsAnswerList> _transactions = List.empty(growable: true);

  TextEditingController questionOneAnswerController = TextEditingController();
  TextEditingController questionTwoAnswerController = TextEditingController();
  TextEditingController questionThreeAnswerController = TextEditingController();
  TextEditingController changePasswordController = TextEditingController();
  TextEditingController transactionPinController = TextEditingController();

  String getallthequestions = "https://standardbullion.co/api/getAllTheQuestions.php";
  String checkSecAnswer = "https://standardbullion.co/api/checkSecurityAnswers.php";
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
