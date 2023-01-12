
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:standardbullionbank/pages/menu.dart';
import 'package:standardbullionbank/pages/pending.dart';
import 'package:standardbullionbank/pages/profitLoss.dart';
import 'package:standardbullionbank/pages/secure.dart';
import 'package:standardbullionbank/pages/transactions.dart';
import 'package:standardbullionbank/pages/verify.dart';
import 'package:standardbullionbank/pages/withdraw.dart';
import 'package:swipe_to/swipe_to.dart';

import 'fund.dart';
import 'login.dart';
import 'market.dart';

class Dashboard extends StatefulWidget {
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
  final String secure;
  final String tpin;
  final int mGold;
  final int mSilver;
  final String email;

  const Dashboard({
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
    required this.tpin,
    required this.target,
    required this.mGold,
    required this.secure,
    required this.mSilver,
    required this.email,
  }) : super(key: key);

  @override
  dashboard createState() => dashboard();
}

class dashboard extends State<Dashboard> {

//all variables
  late String secure = this.widget.secure;
  late String status = this.widget.status;
  late String fname = this.widget.fname;

  //Other variables
  late String MMbuy = this.widget.buy;
  late String MMsell = this.widget.sell;
  late int gold = this.widget.mGold;
  late int silver = this.widget.mSilver;
  late String MMwallet = this.widget.wallet;
  late String MMassetOunce = this.widget.assetOunce;

  //timer code
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 10);
  late Map response;
  var formatter = NumberFormat('#,###,###,000');


  String rates = "https://standardbullion.co/api/getNairaRate.php";
  String market = "https://standardbullion.co/api/getMarketPrice.php";
  String currentUser = "https://standardbullion.co/api/getCurrentUserDetails.php";


  String allTransactions = "https://standardbullion.co/api/getAllTransactions.php";


  //list of all transactions
  List<Transactions> _transactions = List.empty(growable: true);

  String price = "";
  String asset = "";
  double raw = 0;


  @override
  void initState() {
    GallTransactions().then((value){
      setState(() {
        _transactions.addAll(value);
      });
    });


    super.initState();
    startTimer();
  }

  var payments = ['Payment on delivery'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    //timer variables
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      body:  Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Colors.grey[900]!,
              Colors.grey[700]!,
              Colors.grey[900]!,
              Colors.grey[700]!,
            ],
          ),
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height / 2.0,
                child: Column(
                  children: <Widget>[
                    //PriceEurUsd(),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child:
                        status == "Unverified" ?
                          Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child:
                              Text("Welcome to loop. Its great to have you join us. Next, fill a simple form so we can get to know you and verify your account ", style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Raleway",
                                  color: Colors.white
                              ),),
                            ),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Verify(
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
                            }, child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.verified_outlined, color: Colors.white,),
                                SizedBox(width: 10,),
                                Text("Verify my account", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                ),)
                              ],
                            ), style: TextButton.styleFrom(
                              backgroundColor: Colors.black
                            )),
                          ],
                        )
                        :
                          secure == "No" ?
                            Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child:
                                Text("Hello " + fname, style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Raleway",
                                    color: Colors.white
                                ),),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text("It's important to us that your account is protected from fraudulent transactions. Secure your account below by setting your custom security questions", style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Raleway",
                                    color: Colors.white
                                ),),
                              ),
                              TextButton(onPressed: (){
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
                              }, child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.shield, color: Colors.white,),
                                  SizedBox(width: 10,),
                                  Text("Secure my account", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                  ),)
                                ],
                              ), style: TextButton.styleFrom(
                                  backgroundColor: Colors.black
                              )),
                            ],
                          )
                          :
                            Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child:
                                Text("Hello " + widget.fname, style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Raleway",
                                    color: Colors.white
                                ),),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text("It's a great day to trade and make that extra cash! ", style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Raleway",
                                    color: Colors.white
                                ),),
                              ),
                            ],
                          )
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSwitcher(
                                duration: Duration(seconds: 10),
                              child: accBalance(),
                              key: ValueKey(1),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.assetOunce + " Ounce", style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: Colors.white
                                )),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => Fund(
                                        serial: widget.serial,
                                        phone:  widget.phone,
                                        fname: widget.fname,
                                        lname: widget.lname,
                                        email: widget.email,
                                        sell: widget.sell,
                                        buy: widget.buy,
                                        mGold: widget.mGold,
                                        mSilver: widget.mSilver,
                                        accType: widget.accType,
                                      )));
                                },
                                    child:
                                    widget.accType == "Gold account" ?
                                      Text("Buy Gold",
                                        style: TextStyle(
                                            fontFamily: "Raleway",
                                            color: Colors.white
                                        ),)
                                    :
                                      Text("Buy Silver",
                                      style: TextStyle(
                                          fontFamily: "Raleway",
                                          color: Colors.white
                                      ),)),
                                SizedBox(width: 5,),
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WithdrawFunds(
                                    id: widget.id,
                                    amountNaira: MMwallet,
                                    totalOunce: MMassetOunce,
                                    serial : widget.serial,
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
                                      tpin: widget.tpin,
                                      sell: widget.sell,
                                      target: widget.target,
                                      mGold: widget.mGold,
                                      mSilver: widget.mSilver,
                                      email: widget.email, secure: widget.secure,
                                  )));
                                },
                                    child: Text("withdraw funds",
                                      style: TextStyle(
                                          fontFamily: "Raleway",
                                          color: Colors.white
                                      ),)),
                              ],
                            ),
                            SizedBox(width: 5,),
                            widget.accType == "Gold account" ?
                              MMbuy == "" ?
                                SizedBox(width: double.infinity,
                                  child: Text("Loading..", style: TextStyle(
                                    color : Colors.white,
                                    fontSize: 10,
                                  ), textAlign: TextAlign.center,))
                              :
                                SizedBox(width: double.infinity,
                                  child: Text("Buy Gold : ₦${formatter.format(gold * int.parse(MMbuy))}/Ounce | Sell Gold : ₦${formatter.format(gold * int.parse(MMsell))}/Ounce", style: TextStyle(
                                    color : Colors.white,
                                    fontSize: 10,
                                  ), textAlign: TextAlign.center,))
                            :
                              MMbuy == "" ?
                                SizedBox(width: double.infinity,
                                  child: Text("Loading..", style: TextStyle(
                                    color : Colors.white,
                                    fontSize: 10,
                                  ), textAlign: TextAlign.center,))
                              :
                                SizedBox(width: double.infinity,
                                  child: Text("Buy Silver : ₦${formatter.format(silver * int.parse(MMbuy))}/Ounce | Sell Silver : ₦${formatter.format(silver * int.parse(MMsell))}/Ounce", style: TextStyle(
                                    color : Colors.white,
                                    fontSize: 10,
                                  ), textAlign: TextAlign.center,))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: double.infinity, height: 5,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Rates will reload in : ", style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Raleway",
                      color: Colors.white
                  ),),
                  Text(
                    "$hours:$minutes:$seconds",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ]),
            SizedBox(width: double.infinity, height: 3,),

            Expanded(
              child: listofTransactions()
            )
          ],
        ),
      ),
        floatingActionButton:  FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: Colors.green[800],
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Fund(
                    serial: widget.serial,
                    phone:  widget.phone,
                    fname: widget.fname,
                    lname: widget.lname,
                    email: widget.email,
                    sell: widget.sell,
                    buy: widget.buy,
                    mGold: widget.mGold,
                    mSilver: widget.mSilver,
                    accType: widget.accType,
                  )));
            }
        )
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
    setState(() => myDuration = Duration(seconds: 10));
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
        GallTransactions();
        runRates();
        getUserCurrent();

        startTimer();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  Future<String> runRates() async{

    print(widget.target);

    Map jsonData = {
      "serial" : widget.serial,
      "accType" : widget.accType,
      "password" : ""
    };

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(rates));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyRate = await resp.transform(utf8.decoder).join();
    print("Reply is: "+replyRate.toString());

    httpClient.close();
    Map <String, dynamic> getRate = json.decode(replyRate.toString());

    this.MMbuy = getRate['Buy'];
    this.MMsell = getRate['Sell'];
    this.MMwallet = getRate['wallet'];
    this.MMassetOunce = getRate['assetOunce'];


    getBullionRates();
    //automatically refreshes page
    // setState(() {});

    return replyRate;
  }

  Future<String> getBullionRates() async{

    Map jsonData = {
      "email" : "",
      "password" : ""
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(market));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyRate = await resp.transform(utf8.decoder).join();
    print("Reply is: "+replyRate.toString());

    httpClient.close();
    Map <String, dynamic> getBullion = json.decode(replyRate.toString());

    gold = int.parse(getBullion['gold']);
    silver = int.parse(getBullion['silver']);

    //automatically refreshes page
    // setState(() {});

    return replyRate;
  }

  Future<String> getUserCurrent() async{

    Map jsonData = {
      "serial" : widget.serial,
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(currentUser));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyRate = await resp.transform(utf8.decoder).join();
    print("Reply is: "+replyRate.toString());

    httpClient.close();
    Map <String, dynamic> getBullion = json.decode(replyRate.toString());

    this.secure = getBullion['secure'];
    this.status = getBullion['status'];
    this.fname = getBullion['fname'];

    return replyRate;
  }

  Future<List<Transactions>>  GallTransactions() async {
    Map jsonData = {
      "serial": widget.serial,
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

  Widget accBalance(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("₦", style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white
        )),
        widget.wallet == "0" ?
        Text("0.00", style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 50,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),)
            :
        Text(formatter.format(int.parse(MMwallet)).toString(), style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),),
      ],
    );
  }

  Widget ounceBalance(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.wallet == "0" ?
        Text("0.00 Ounce", style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 50,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),)
            :
        Text(formatter.format(int.parse(widget.assetOunce)).toString(), style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),),
      ],
    );
  }

  Widget listofTransactions(){
    return ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (context, index){
          return _transactions.length > 0 ?
          Container(
              child: _transactions[index].type == "Credit" ?
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
                              Text("Amount : ₦${formatter.format(int.parse(_transactions[index].sellAt)).toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white
                                  )),
                              SizedBox(width: 5,),
                              Text("|",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white
                                  )),
                              SizedBox(width: 5,),
                              Text("Quantity : ${double.parse(_transactions[index].ounce).toStringAsFixed(4)} Ounce",
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
                                      _transactions[index].type == "Credit" ?
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
                                      Text("₦${formatter.format(int.parse(_transactions[index].price)).toString()} / Ounce",
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
                                      Text("${_transactions[index].status}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.green
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
                              Text("Amount ₦${formatter.format(int.parse(_transactions[index].sellAt)).toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white
                                  )),
                              SizedBox(width: 5,),
                              Text("|",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white
                                  )),
                              SizedBox(width: 5,),
                              Text("Quantity : ${double.parse(_transactions[index].ounce).toStringAsFixed(4)} Ounce",
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
                                      _transactions[index].type == "Credit" ?
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
                                      Text("${_transactions[index].status}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Raleway",
                                              fontSize: 12,
                                              color: Colors.green
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
}

