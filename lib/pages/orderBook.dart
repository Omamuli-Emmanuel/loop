
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:standardbullionbank/pages/profitLossModel.dart';

class OrderBook extends StatefulWidget {
  const OrderBook({Key? key}) : super(key: key);

  @override
  State<OrderBook> createState() => _OrderBookState();
}

class _OrderBookState extends State<OrderBook> {

  String getallAccountStatements = "https://standardbullion.co/api/getAllTransactionsStatements.php";

  //list of all profit n loss
  List<ProfitLossList> _transactions = List.empty(growable: true);
  var formatter = NumberFormat('#,###,###,000');
  //timer code
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 30);

  late String isIt = "";

  @override
  void initState() {
    GallProfitLoss().then((value) {
      setState(() {
        _transactions.addAll(value);
      });
    });

    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            child: Column(
              children: [
                SizedBox(height: 10, width: double.infinity,),
                Text("Live Order Book", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),),
                Expanded(child: listofTransactions())
              ],
            ),
          )
      ),
    );
  }


  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
    resetTimer();
  }

  void resetTimer() {
    setState(() => myDuration = Duration(seconds: 30));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        stopTimer();
        //show snakbar
        // var snackBar = SnackBar(content: Text("Checking best available rates..."));
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        GallProfitLoss();
        startTimer();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  Future<List<ProfitLossList>>  GallProfitLoss() async {
    Map jsonData = {
      "nothing": "",
    };

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(getallAccountStatements));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyTwo = await resp.transform(utf8.decoder).join();
    print("Reply is: " + replyTwo.toString());

    var transacts = json.decode(replyTwo);

    List<ProfitLossList> trac = List.empty(growable: true);

    for(var transact in transacts){
      trac.add(ProfitLossList.fromJson(transact));
    }

    if (trac.isEmpty){
      isIt = "Yes";
    }

    httpClient.close();
    // List<String> getTransact = new List<String>.from();
    //
    // print(trac);

    return trac;
  }

  Widget listofTransactions(){
    return ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (context, index){
          return Container(
              child :
              int.parse(_transactions[index].diff) < 0 ?
              Card(
                  color: Colors.black45,
                  shadowColor: Colors.red,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("Balance From: ", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontFamily: "Raleway"
                                    ),),
                                    Text("₦"+formatter.format(int.parse(_transactions[index].oldWallet)).toString(), style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                    ),)
                                  ],
                                ),
                              ),
                              Expanded(child:
                              Column(
                                children: [
                                  Icon(Icons.arrow_circle_down_outlined, color: Colors.white,),
                                  Text("₦"+formatter.format(int.parse(_transactions[index].diff)).toString(), style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              )
                              ),
                              Expanded(child: Column(
                                children: [
                                  Text("New Balance: ", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontFamily: "Raleway"
                                  ),),
                                  Text("₦"+formatter.format(int.parse(_transactions[index].newWallet)).toString(), style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              ))
                            ],
                          ),
                          SizedBox(height: 10, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(child: Column(
                                children: [
                                  Text("Date : ${_transactions[index].date.toString()}", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),)
                                ],
                              )),
                              Expanded(child: Text("")),
                              Expanded(
                                child: Text("Transaction Hash : ${_transactions[index].transactionId} ", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontFamily: "Raleway"
                                ),),
                              )
                            ],
                          )
                        ],
                      )
                  )
              )
                  :
              _transactions[index].marker.toString() == "Withdrawn" ?
              Card(
                  color: Colors.black45,
                  shadowColor: Colors.blue,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("Balance From: ", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontFamily: "Raleway"
                                    ),),
                                    Text("₦"+formatter.format(int.parse(_transactions[index].oldWallet)).toString(), style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                    ),)
                                  ],
                                ),
                              ),
                              Expanded(child:
                              Column(
                                children: [
                                  Icon(Icons.wallet, color: Colors.white,),
                                  Text("₦"+formatter.format(int.parse(_transactions[index].diff)).toString(), style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              )
                              ),
                              Expanded(child: Column(
                                children: [
                                  Text("New Balance: ", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontFamily: "Raleway"
                                  ),),
                                  Text("₦"+formatter.format(int.parse(_transactions[index].newWallet)).toString(), style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              ))
                            ],
                          ),
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(child: Column(
                                children: [
                                  Text("Date : ${_transactions[index].date.toString()}", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),)
                                ],
                              )),
                              Expanded(child: Text("")),
                              Expanded(
                                child: Text("Transaction Hash : ${_transactions[index].transactionId} ", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontFamily: "Raleway"
                                ),),
                              )
                            ],
                          )
                        ],
                      )
                  )
              )
                  :
              _transactions[index].marker.toString() == "Commission" ?
                Card(
                  color: Colors.black45,
                  shadowColor: Colors.purple,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("Balance From: ", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontFamily: "Raleway"
                                    ),),
                                    Text("₦"+formatter.format(int.parse(_transactions[index].oldWallet)).toString(), style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                    ),)
                                  ],
                                ),
                              ),
                              Expanded(child:
                              Column(
                                children: [
                                  Icon(Icons.arrow_circle_up_outlined, color: Colors.white,),
                                  Text("₦"+formatter.format(int.parse(_transactions[index].diff)).toString(), style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              )
                              ),
                              Expanded(child: Column(
                                children: [
                                  Text("New Balance: ", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontFamily: "Raleway"
                                  ),),
                                  Text("₦"+formatter.format(int.parse(_transactions[index].newWallet)).toString(), style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              ))
                            ],
                          ),
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(child: Column(
                                children: [
                                  Text("Date : ${_transactions[index].date.toString()}", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),)
                                ],
                              )),
                              Expanded(child: Text("")),
                              Expanded(
                                child: Text("Transaction Hash : ${_transactions[index].transactionId} ", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontFamily: "Raleway"
                                ),),
                              )
                            ],
                          )
                        ],
                      )
                  )
              )
              :
                Card(
                  color: Colors.black45,
                  shadowColor: Colors.green,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("Balance From: ", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontFamily: "Raleway"
                                    ),),
                                    Text("₦"+formatter.format(int.parse(_transactions[index].oldWallet)).toString(), style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                    ),)
                                  ],
                                ),
                              ),
                              Expanded(child:
                              Column(
                                children: [
                                  Icon(Icons.arrow_circle_up_outlined, color: Colors.white,),
                                  Text("₦"+formatter.format(int.parse(_transactions[index].diff)).toString(), style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              )
                              ),
                              Expanded(child: Column(
                                children: [
                                  Text("New Balance: ", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontFamily: "Raleway"
                                  ),),
                                  Text("₦"+formatter.format(int.parse(_transactions[index].newWallet)).toString(), style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              ))
                            ],
                          ),
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(child: Column(
                                children: [
                                  Text("Date : ${_transactions[index].date.toString()}", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),)
                                ],
                              )),
                              Expanded(child: Text("")),
                              Expanded(
                                child: Text("Transaction Hash : ${_transactions[index].transactionId} ", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontFamily: "Raleway"
                                ),),
                              )
                            ],
                          )
                        ],
                      )
                  )
              )

            );

        });
  }
}
