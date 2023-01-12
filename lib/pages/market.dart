
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:intl/intl.dart';
import 'package:standardbullionbank/pages/transactions.dart';

import 'bottomNav.dart';
import 'dashboard.dart';
import 'openTransactions.dart';


class Market extends StatefulWidget {

  final String asset;
  final String price;
  final String serial;
  final String balance;
  final double rawPrice;
  final double assetPrice;
  final String target;
  final double buy;
  final double sell;

  const Market({
    Key? key,
    required this.asset,
    required this.serial,
    required this.price,
    required this.balance,
    required this.rawPrice,
    required this.assetPrice,
    required this.target,
    required this.buy,
    required this.sell
  }) : super(key: key);

  @override
  market createState() => market();
}

class market extends State<Market> {
  final ScrollController controller = ScrollController();
  var formatter = NumberFormat('#,###,###,000');

  String buyAsset = "https://standardbullion.co/api/buyAsset.php";
  String sellAsset = "https://standardbullion.co/api/sellAsset.php";

  String allTransactions = "https://standardbullion.co/api/getAllTransactions.php";
  String allOpenTransactions = "https://standardbullion.co/api/getAllOpenTransactions.php";
  String sum = "";
  String amount = "";

  String totalOunce = "https://standardbullion.co/api/getTotalOunce.php";

  //list of all transactions
   List<Transactions> _transactions = List.empty(growable: true);
  //list of opentransactions
  List<OpenTransactions> _opentransactions = List.empty(growable: true);


  double percent = 0;

  @override
  void initState() {
    GallTransactions().then((value){
      setState(() {
        _transactions.addAll(value);
      });
    });

    GallOpenTransactions().then((value){
      setState(() {
        _opentransactions.addAll(value);
      });
    });

    gTotalOunce(widget.asset, widget.serial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Colors.blue[900]!,
              Colors.blue[500]!,
              Colors.blue[900]!,
              Colors.blue[500]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Column(
                  children: [
                    Container(
                        color: Colors.black54.withOpacity(0.7),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(widget.asset, style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Raleway",
                                              color: Colors.white
                                          ),),
                                          Text(" | ", style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Raleway",
                                              color: Colors.white
                                          ),),
                                          Text("₦" + widget.price + " per ounce", style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.green[300]
                                          ),),
                                        ],
                                      )
                                  ),
                                  //PriceEurUsd(),
                                  SafeArea(
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("₦", style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                  color: Colors.white
                                              )),
                                              amount == "" ?
                                                  Text("0.00", style: TextStyle(
                                                     fontSize: 50,
                                                     fontWeight: FontWeight.w500,
                                                      color: Colors.white
                                                  ))
                                                :
                                                  Text(formatter.format(int.parse(amount)), style: TextStyle(
                                                        fontSize: 50,
                                                            fontWeight: FontWeight.w500,
                                                          color: Colors.white
                                                      ),
                                              )
                                            ]
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(sum.toString() + " oz (ounce)", style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white
                                            ),)
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: (){
                                                      _bottomSheet(context);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.green
                                                    ),
                                                    child: Text("Buy"),
                                                  )
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.35,
                        child: Scaffold(
                          appBar : AppBar(
                            backgroundColor: Colors.black54.withOpacity(0.8),
                            title: Text("My " + widget.asset + " Order Book", style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            )),
                            automaticallyImplyLeading: false,
                            bottom: TabBar(
                              indicatorColor: Colors.white,
                                tabs: [
                                  Tab(text: 'Transactions'),
                                  Tab(text: 'Open trades')
                                ]
                            ),
                          ),
                          body: Container(
                            color: Colors.black87,
                            child: TabBarView(
                              children: [
                                listofTransactions(),
                                listofOpenTransactions(),
                              ],
                            ),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _bottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c){
          return Container(
            color: Colors.black87,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text("How many percent of ₦" + formatter.format(int.parse(widget.balance)).toString() + " would your like to spend?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          color: Colors.white
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                              percent = 10;
                            _showMyDialog();
                          },
                          child: Text("10%")
                      ),
                      ElevatedButton(
                          onPressed: (){
                            percent = 20;
                            _showMyDialog();
                          },
                          child: Text("20%")
                      ),
                      ElevatedButton(
                          onPressed: (){
                            percent = 30;
                            _showMyDialog();
                          },
                          child: Text("30%")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600]
                          ),
                          onPressed: (){
                            percent = 40;
                            _showMyDialog();
                          },
                          child: Text("40%")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600]
                          ),
                          onPressed: (){
                            percent = 50;
                            _showMyDialog();
                          },
                          child: Text("50%")
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600]
                          ),
                          onPressed: (){
                            percent = 60;
                            _showMyDialog();
                          },
                          child: Text("60%")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600]
                          ),
                          onPressed: (){
                            percent = 70;
                            _showMyDialog();
                          },
                          child: Text("70%")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600]
                          ),
                          onPressed: (){
                            percent = 80;
                            _showMyDialog();
                          },
                          child: Text("80%")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600]
                          ),
                          onPressed: (){
                            percent = 90;
                            _showMyDialog();
                          },
                          child: Text("90%")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900]
                          ),
                          onPressed: (){
                            percent = 100;
                            _showMyDialog();
                          },
                          child: Text("100%")
                      ),
                    ],
                  ),
                ],
              ),
            )
          );
        }
    );
  }


  Future<void> _showMyDialog() async {
    percent = (percent / 100);
    double actual = percent * int.parse(widget.balance);
    double internationalActual = actual / widget.buy;
    double aa = internationalActual * widget.sell;
    double aprice = widget.assetPrice * widget.buy;
    double ounce = double.parse((aa / aprice).toStringAsFixed(3));
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Buying ₦' + formatter.format(actual) + " worth of " + widget.asset + " at ₦"+ formatter
              .format(widget.buy)+ "/USD",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
            ), textAlign: TextAlign.center, ),
          content: Container(
            height: MediaQuery.of(context).size.height / 5.3,
            child: Column(
              children: [
                SizedBox(width: double.infinity,
                  child: Text("You will get",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Raleway",
                          fontSize: 18
                      ),
                      textAlign: TextAlign.center),
                ),
                SizedBox(width: double.infinity,
                  child: Text(ounce.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30
                      ),
                      textAlign: TextAlign.center),
                ),
                SizedBox(width: double.infinity,
                  child: Text("ounce",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Raleway",
                          fontSize: 30
                      ),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 10, width: double.infinity,),
                SizedBox(width: double.infinity,
                  child: Text("Would you like to continue with this purchase ?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Raleway",
                          fontSize: 18
                      ),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('YES, CONTINUE'),
                  onPressed: () {
                    Buy(ounce, widget.asset, actual);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<String>  gTotalOunce(String asset, String serial) async{

    Map jsonData = {
      "serial" : serial,
      "asset" : asset,
    };

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(totalOunce));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyRate = await resp.transform(utf8.decoder).join();
    print("Sum is: "+ replyRate.toString());

    httpClient.close();
    Map <String, dynamic> getRate = json.decode(replyRate.toString());

    print(getRate);
    sum = getRate["sum"].toString();
    amount = getRate["amount"].toString();
    return replyRate;
  }

  Future<List<Transactions>>  GallTransactions() async {
    Map jsonData = {
      "serial": widget.serial,
      "asset" : widget.asset
    };

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(allTransactions));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyTwo = await resp.transform(utf8.decoder).join();
    print("Reply is: " + replyTwo.toString());

    var transacts = json.decode(replyTwo);

    List<Transactions> trac = List.empty(growable: true);

    for(var transact in transacts){
      trac.add(Transactions.fromJson(transact));
    }

    httpClient.close();
    // List<String> getTransact = new List<String>.from();
    //
    // print(getTransact);

    return trac;
  }

  Future<List<OpenTransactions>>  GallOpenTransactions() async {
    Map jsonData = {
      "serial": widget.serial,
      "asset" : widget.asset
    };

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(allOpenTransactions));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyTwo = await resp.transform(utf8.decoder).join();
    print("Reply is: " + replyTwo.toString());

    var transacts = json.decode(replyTwo);

    List<OpenTransactions> trac = List.empty(growable: true);

    for(var transact in transacts){
      trac.add(OpenTransactions.fromJson(transact));
    }

    httpClient.close();
    // List<String> getTransact = new List<String>.from();
    //
    // print(getTransact);

    return trac;
  }

  Widget listofTransactions(){
    return ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (context, index){
          return _transactions.length > 0 ?
            Container(
              child:
              _transactions[index].type == "Buy" ?
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Quantity : ${_transactions[index].ounce} Ounce",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white
                                  )),
                              SizedBox(width: 5,),
                            ],
                          ),
                          SizedBox(height: 5, width: double.infinity,),
                          // Text("Transaction Id",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w600,
                          //         fontFamily: "Raleway",
                          //         fontSize: 15,
                          //         color: Colors.white
                          //     )),
                          // Text("${_transactions[index].transactionId}",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 15,
                          //         color: Colors.white
                          //     )),
                          // SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Type: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white
                                          )),
                                      _transactions[index].type == "Buy" ?
                                      Text("${_transactions[index].type}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.green
                                          ))
                                          :
                                      Text("${_transactions[index].type}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.red
                                          ))
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Bought at: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white

                                          )),
                                      Text("₦${formatter.format(int.parse(_transactions[index].price)).toString()} / ounce",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white
                                          ))
                                    ],
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Status: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white
                                          )),
                                      _transactions[index].status == "Open" ?
                                      Text("${_transactions[index].status}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.green
                                          ))
                                          :
                                      Text("${_transactions[index].status}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.red
                                          ))
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Date: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white
                                          )),
                                      Text("${_transactions[index].date}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.white
                                          ))
                                    ],
                                  )
                              )
                            ],
                          ),
                        ],
                      )
                  )
              )
                  :
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Quantity : ${_transactions[index].ounce} Ounce",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white
                                  )),
                              SizedBox(width: 5,),
                            ],
                          ),
                          SizedBox(height: 5, width: double.infinity,),
                          // Text("Transaction Id",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w600,
                          //         fontFamily: "Raleway",
                          //         fontSize: 15,
                          //         color: Colors.white
                          //     )),
                          // Text("${_transactions[index].transactionId}",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 15,
                          //         color: Colors.white
                          //     )),
                          // SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Type: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white
                                          )),
                                      _transactions[index].type == "Buy" ?
                                      Text("${_transactions[index].type}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.green
                                          ))
                                          :
                                      Text("${_transactions[index].type}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.red
                                          ))
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Bought at: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white

                                          )),
                                      Text("₦${formatter.format(int.parse(_transactions[index].price)).toString()} / ounce",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white
                                          ))
                                    ],
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Status: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white
                                          )),
                                      _transactions[index].status == "Open" ?
                                      Text("${_transactions[index].status}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.green
                                          ))
                                          :
                                      Text("${_transactions[index].status}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.red
                                          ))
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Date: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white
                                          )),
                                      Text("${_transactions[index].date}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.white
                                          ))
                                    ],
                                  )
                              )
                            ],
                          ),
                        ],
                      )
                  )
              )
          )
          :
            Center(
            child: Text("You have no transactions for this asset at the moment", style: TextStyle(
              color: Colors.white,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w500
            )),
          );
        });
  }
  Widget listofOpenTransactions(){
    return ListView.builder(
        itemCount: _opentransactions.length,
        itemBuilder: (context, index){
          return _opentransactions.length > 0 ?
                Container(
              child: Card(
                  color: Colors.black45,
                  shadowColor: Colors.green,
                  child: Padding(
                      padding: EdgeInsets.only(top: 10,left: 10,bottom: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text("Quantity : ${_opentransactions[index].ounce} Ounce",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.white
                                    )),
                              ),

                              int.parse(_opentransactions[index].sellAt) - int.parse(_opentransactions[index].amount) < 0 ?

                              Expanded(
                                  child: Text("${formatter.format(int.parse(_opentransactions[index].sellAt) - int.parse(_opentransactions[index].amount)).toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.red
                                      )),
                              )
                              :
                              Expanded(
                                child: Text("${formatter.format(int.parse(_opentransactions[index].sellAt) - int.parse(_opentransactions[index].amount)).toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.green
                                    )),
                              ),

                            ],
                          ),
                          SizedBox(height: 5, width: double.infinity,),
                          // Text("Transaction Id",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w600,
                          //         fontFamily: "Raleway",
                          //         fontSize: 15,
                          //         color: Colors.white
                          //     )),
                          // Text("${_transactions[index].transactionId}",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 15,
                          //         color: Colors.white
                          //     )),
                          // SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Type: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white
                                          )),
                                      _opentransactions[index].type == "Buy" ?
                                      Text("${_opentransactions[index].type}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.green
                                          ))
                                          :
                                      Text("${_opentransactions[index].type}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.red
                                          ))
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Bought at: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white

                                          )),
                                      Text("₦${formatter.format(int.parse(_opentransactions[index].price)).toString()} / ounce",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white
                                          ))
                                    ],
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Status: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white
                                          )),
                                      _opentransactions[index].status == "Open" ?
                                      Text("${_opentransactions[index].status}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.green
                                          ))
                                          :
                                      Text("${_opentransactions[index].status}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.red
                                          ))
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Date: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Raleway",
                                              fontSize: 13,
                                              color: Colors.white
                                          )),
                                      Text("${_opentransactions[index].date}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.white
                                          ))
                                    ],
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: 5, width: double.infinity,),
                          Row(
                            children: [
                              TextButton(onPressed: (){
                                Sell(_opentransactions[index].transactionId, _opentransactions[index].ounce);
                              },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.red)
                                  ),
                                  child: Column(
                                    children: [
                                      Text("Sell", style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13
                                      ),),
                                      Text("₦${formatter.format(int.parse(_opentransactions[index].sellAt)).toString()}", style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12
                                      ),)
                                    ],
                                  )
                              ),
                              Expanded(
                                child: TextButton(onPressed: (){
                                  print(2);
                                },
                                    child: Text("Fix this order for 1.5% monthly returns")
                                ),
                                flex: 1,
                              ),
                            ],
                          )
                        ],
                      )
                  )
              )
          )
              :
                Center(
                child: Text("You have no open trades for this asset at the moment", style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w500
                )),
              );
        });
  }

  Future<String>  Buy(double ounce, String asset, double actual) async{

    Map jsonData = {
      "serial" : widget.serial,
      "ounce" : ounce,
      "asset" : asset,
      "amount" : actual,
      "assetPrice" : widget.assetPrice,
    };

    print(widget.assetPrice);

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(buyAsset));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyRate = await resp.transform(utf8.decoder).join();
    print("Reply is: "+ replyRate.toString());

    httpClient.close();
    Map <String, dynamic> getRate = json.decode(replyRate.toString());

    // print(getRate);

    if(getRate.containsKey("serial")){

      String id = getRate["id"];
      String serial = getRate["serial"];
      String fname = getRate["fname"];
      String lname = getRate["lname"];
      String phone = getRate["bankName"];
      String bankAccName = getRate["accountName"];
      String bankName = getRate["bankName"];
      String accNumber = getRate["accNumber"];
      String wallet = getRate["wallet"];
      String assetOunce = getRate["assetOunce"];
      String accType = getRate["accType"];
      String status = getRate["status"];
      String buy = getRate["buy"];
      String sell = getRate["sell"];
      String target = getRate["target"];
      String secure = getRate["secure"];
      String tpin = getRate["tpin"];
      int marketGold = int.parse(getRate["goldTwo"]);
      int marketSilver = int.parse(getRate["silverTwo"]);
      String email = getRate["email"];


      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav(
        id: id,
        serial: serial,
        fname: fname,
        lname: lname,
        phone: phone,
        bankAccName: bankAccName,
        bankName: bankName,
        accNumber: accNumber,
        wallet: wallet,
        accType: accType,
        status: status,
        assetOunce: assetOunce,
        buy: buy,
        target: target,
        secure: secure,
        sell: sell,
        tpin : tpin,
        mGold: marketGold,
        mSilver: marketSilver,
        email: email,
      )));
    }
    return replyRate;
  }

  Future<String>  Sell(String transactionId, String quantity ) async{

    Map jsonData = {
      "transactionId" : transactionId,
      "ounce" : quantity,
    };

    // print(widget.assetPrice);

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(sellAsset));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyRate = await resp.transform(utf8.decoder).join();
    print("Reply is: "+ replyRate.toString());

    httpClient.close();
    Map <String, dynamic> getRate = json.decode(replyRate.toString());

    // print(getRate);

    if(getRate.containsKey("serial")){

      String id = getRate["id"];
      String serial = getRate["serial"];
      String fname = getRate["fname"];
      String lname = getRate["lname"];
      String phone = getRate["bankName"];
      String bankAccName = getRate["accountName"];
      String bankName = getRate["bankName"];
      String accNumber = getRate["accNumber"];
      String wallet = getRate["wallet"];
      String assetOunce = getRate["assetOunce"];
      String accType = getRate["accType"];
      String status = getRate["status"];
      String buy = getRate["buy"];
      String target = getRate["target"];
      String sell = getRate["sell"];
      String secure = getRate["secure"];
      String tpin = getRate["tpin"];
      int marketGold = int.parse(getRate["goldTwo"]);
      int marketSilver = int.parse(getRate["silverTwo"]);
      String email = getRate["email"];


      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav(
        id: id,
        serial: serial,
        fname: fname,
        lname: lname,
        phone: phone,
        bankAccName: bankAccName,
        bankName: bankName,
        accNumber: accNumber,
        wallet: wallet,
        assetOunce : assetOunce,
        accType: accType,
        status: status,
        buy: buy,
        sell: sell,
        target: target,
        secure: secure,
        tpin : tpin,
        mGold: marketGold,
        mSilver: marketSilver,
        email: email,
      )));
    }
    return replyRate;
  }

}
