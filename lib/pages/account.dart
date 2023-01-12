
import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:nigerian_banks/models/bank_model.dart';
import 'package:nigerian_banks/utils/test/selector_config.dart';
import 'package:nigerian_banks/widget/banks.dart';
import 'package:standardbullionbank/pages/pending.dart';
import 'package:standardbullionbank/pages/privacyPage.dart';
import 'package:standardbullionbank/pages/support.dart';
import 'package:standardbullionbank/pages/verify.dart';

import 'askQuestions.dart';
import 'bottomNav.dart';
import 'login.dart';

class Account extends StatefulWidget {
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

  const Account({
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
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {


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


  //Nigerian banks
  late BankModel bankModel;
  List<BankModel> banks = [
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
    BankModel(name: "Gtbank", slug: "gt_bank", logo: ""),
  ];
  //variables
  String changeAccountDetails = "https://standardbullion.co/api/changeAccountDetails.php";
  String changeTransactionPinHere = "https://standardbullion.co/api/changeTransactionPin.php";
  String changePasswordLink = "https://standardbullion.co/api/changePasswordHere.php";
  String deleteAccount = "https://standardbullion.co/api/deleteAccount.php";

  TextEditingController bankController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accNumberController = TextEditingController();
  TextEditingController transactionPinController = TextEditingController();
  TextEditingController changePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(width: double.infinity, child:
                Text(widget.fname + " " + widget.lname, style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w700
                ), textAlign: TextAlign.center,),
                ),
                Text(widget.accType, style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w700
                ), textAlign: TextAlign.center,),
                SizedBox(width: double.infinity, height: 5,),
                Text("${widget.serial}", style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700
                ), textAlign: TextAlign.center,),
                SizedBox(height: 30, width: double.infinity,),
                ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Disbursement account details", style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w700,
                          color: Colors.blue
                      )),
                      SizedBox(width: double.infinity, height: 10,),
                      Text(widget.bankAccName.toString(), style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),),
                      Text(widget.accNumber.toString(), style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),),
                      Text(widget.bankName.toString(), style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),),
                      Text("All withdrawal requests will be credited to this account.", style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.red
                      ),),
                    ],
                  ),
                ),
                widget.status == "Unverified" ?
                  GestureDetector(
                  child: ListTile(
                    title: Text("Verify account", style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.blue
                    ),),
                    trailing: Icon(Icons.arrow_circle_right_outlined, color: Colors.white,),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Verify(id: widget.id,
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
                        email: widget.email)));
                  },
                )
                :
                    widget.status == "Approved" ?
                      ListTile(
                        title: Text("Account Status : Approved", style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w700,
                            color: Colors.blue
                        ),),
                      )
                    :
                      ListTile(
                        title: Text("Account Status : Pending", style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w700,
                            color: Colors.blue
                        ),),
                      ),
                widget.tpin == "0" ?
                  GestureDetector(
                  child: ListTile(
                    title: Text("Set transaction pin", style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.blue
                    ),),
                    trailing: Icon(Icons.arrow_circle_right_outlined, color: Colors.white,),
                  ),
                  onTap: (){
                    setTransactionPin(context);
                  },
                )
                :
                  GestureDetector(
                  child: ListTile(
                    title: Text("Change transaction pin", style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.blue
                    ),),
                    trailing: Icon(Icons.arrow_circle_right_outlined, color: Colors.white,),
                  ),
                  onTap: (){
                    setTransactionPin(context);
                  },
                ),
                GestureDetector(
                  child: ListTile(
                    title: Text("Change disbursement account details", style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.blue
                    ),
                    ),
                    trailing: Icon(Icons.arrow_circle_right_outlined, color: Colors.white,),
                  ),
                  onTap: (){
                    _bottomSheet(context);
                  },
                ),
                GestureDetector(
                  child: ListTile(
                    title: Text("Change account password", style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.blue
                    ),),
                    trailing: Icon(Icons.arrow_circle_right_outlined, color: Colors.white,),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Ask(
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
                        email: widget.email,
                        tpin: widget.tpin,
                    )));
                    // changePassword(context);
                  },
                ),
                GestureDetector(
                  child: ListTile(
                    title: Text("FAQs", style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.blue
                    ),
                    ),
                    trailing: Icon(Icons.arrow_circle_right_outlined, color: Colors.white,),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Pending()));
                  },
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>Privacy()));
                  },
                  child: ListTile(
                    title: Text("Privacy & terms of service", style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.blue
                    ),),
                    trailing: Icon(Icons.arrow_circle_right_outlined, color: Colors.white,),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>Support()));
                  },
                  child: ListTile(
                    title: Text("Support", style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.blue
                    ),),
                    trailing: Icon(Icons.arrow_circle_right_outlined, color: Colors.white,),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _showMyDialog();
                  },
                  child: ListTile(
                    title: Text("Delete my account", style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.red
                    ),),
                    trailing: Icon(Icons.cancel_outlined, color: Colors.red,),
                  ),
                ),
                GestureDetector(
                  child: ListTile(
                    title: Text("Logout", style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.red
                    ),),
                    trailing: Icon(Icons.logout, color: Colors.red,),
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => Login()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _bottomSheet(context){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context){
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 320,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: double.infinity, height: 5,),
                    Banks(
                      textFieldController: bankController,
                      inputDecoration: InputDecoration(
                          labelText: "Select payout bank"
                      ),
                      onInputChanged: (BankModel b) => (){
                        print(b.name);
                      },
                      selectorConfig: SelectorConfig(
                          selectorType: BankInputSelectorType.BOTTOM_SHEET,
                          showLogo: true,
                          showCode: true),
                    ),
                    SizedBox(width: double.infinity, height: 5,),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: accountNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Account name"
                      ),
                    ),
                    SizedBox(width: double.infinity, height: 5,),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: accNumberController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Account number"
                      ),
                    ),
                    SizedBox(width: double.infinity, height: 5,),
                    ElevatedButton(
                        onPressed: (){
                          changeAccDets();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        child: Text("Submit change", style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ))
                    ),
                    Text("In some cases, change may take some time to be effected. Usually within 24hrs, within this time, you are adviced not to place a withdrawal request, kindly logout and check back later.", style: TextStyle(
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

  setTransactionPin(context){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context){
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                color: Colors.black,
                height: 180,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: double.infinity, height: 5,),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: transactionPinController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        label: Text("Set transaction pin", style: TextStyle(
                            color: Colors.white
                        ),),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.blue),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(width: double.infinity, height: 5,),
                    ElevatedButton(
                        onPressed: (){
                          changeTransactionPin();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        child: Text("Set pin", style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ))
                    ),
                    Text("This pin will be used to authenticate withdrawals.", style: TextStyle(
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

  Future  changeAccDets() async{

    print("Address is: " + changeAccountDetails);

    Map jsonData = {
      "serial" : widget.serial,
      "bankName" : "${bankController.text}",
      "accountName" : "${accountNameController.text}",
      "accountNumber" : "${accNumberController.text}"
    };


    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(changeAccountDetails));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("Reply is: "+reply.toString());

    Map <String, dynamic> map = json.decode(reply.toString());

    id = map['id'];
    serial = map['serial'];
    fname = map['fname'];
    lname = map['lname'];
    phone = map['phone'];
    bankAccName = map['accountName'];
    bankName = map['bankName'];
    accNumber = map['accountNumber'];
    wallet = map['wallet'];
    assetOunce = map['assetOunce'];
    accType = map['accType'];
    status = map['status'];
    target = map['target'];
    secure = map['secure'];
    tpin = map['tpin'];
    email = map['email'];
    role = map['role'];

    if(map['message'] == "Successful"){

      Navigator.push(context, MaterialPageRoute(builder: (contex) => BottomNav(
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
        accType : accType,
        status: status,
        buy: buy,
        sell: sell,
        secure: secure,
        tpin : tpin,
        target: target,
        mGold: marketGold,
        mSilver: marketSilver,
        email: email,
      )));

    }else{

      final successSnackbar = SnackBar(
        backgroundColor: Colors.red[800],
        content: const Text("Error submitting change request... try again",
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

  Future changeTransactionPin() async{
    print("Address is: " + changeAccountDetails);

    Map jsonData = {
      "serial" : widget.serial,
      "tpin" : "${transactionPinController.text}",
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(changeTransactionPinHere));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("Reply is: "+reply.toString());

    Map <String, dynamic> map = json.decode(reply.toString());

    id = map['id'];
    serial = map['serial'];
    fname = map['fname'];
    lname = map['lname'];
    phone = map['phone'];
    bankAccName = map['accountName'];
    bankName = map['bankName'];
    accNumber = map['accountNumber'];
    wallet = map['wallet'];
    assetOunce = map['assetOunce'];
    accType = map['accType'];
    status = map['status'];
    target = map['target'];
    secure = map['secure'];
    tpin = map['tpin'];
    email = map['email'];
    role = map['role'];

    if(map['message'] == "Successful"){

      Navigator.push(context, MaterialPageRoute(builder: (contex) => BottomNav(
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
        accType : accType,
        status: status,
        buy: buy,
        sell: sell,
        secure: secure,
        tpin : tpin,
        target: target,
        mGold: marketGold,
        mSilver: marketSilver,
        email: email,
      )));

    }else{

      final successSnackbar = SnackBar(
        backgroundColor: Colors.red[800],
        content: const Text("Error submitting change request... try again",
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

  Future changePasswordNow() async{
    print("Address is: " + changeAccountDetails);

    Map jsonData = {
      "serial" : widget.serial,
      "password" : "${transactionPinController.text}",
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

  Future deleteMyAccount() async{
    print("Address is: " + changeAccountDetails);

    Map jsonData = {
      "serial" : widget.serial,
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(deleteAccount));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("Reply is: "+reply.toString());

    Map <String, dynamic> map = json.decode(reply.toString());

    if(map['message'] == "Success"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Before you go!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('We would really love to serve you in a better way. If you can just tell us what you feel we are doing wrong, we believe we can take it into account and make your stay better and profitable.'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('No, Delete my account'),
                  onPressed: () {
                    deleteMyAccount();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

}
