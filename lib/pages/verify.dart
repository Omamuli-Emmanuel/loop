
import 'dart:convert';
import 'dart:io';

import 'package:nigerian_banks/nigerian_banks.dart';
import 'package:flutter/material.dart';
import 'package:nigerian_banks/utils/test/selector_config.dart';
import 'package:standardbullionbank/pages/pending.dart';

import 'dashboard.dart';


class Verify extends StatefulWidget {

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

  const Verify({
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
  verify createState() => verify();
}

class verify extends State<Verify> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bvnController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accNumberController = TextEditingController();

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
  String address = "https://standardbullion.co/api/updateProfile.php";


  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => _showMyDialog());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("New Member Verification"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity, height: 30,),
              SizedBox(width: double.infinity, child: Text("First Name", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
                TextField(
                keyboardType: TextInputType.text,
                controller: firstNameController,
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
              SizedBox(width: double.infinity, child: Text("Last Name", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
                TextField(
                keyboardType: TextInputType.text,
                controller: lastNameController,
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
              SizedBox(width: double.infinity, child: Text("Payout informaton", style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500
              ),),),
              SizedBox(width: double.infinity, height: 8,),
              SizedBox(width: double.infinity, child: Text("Bank Verification Number (BVN)", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
              TextField(
                keyboardType: TextInputType.number,
                controller: bvnController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(width: double.infinity, height: 8,),
              SizedBox(width: double.infinity, child: Text("Select Bank", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
              Banks(
                textFieldController: bankController,
                textStyle: TextStyle(
                  color: Colors.white,
                ),
                inputDecoration: InputDecoration(
                  labelText: "Select payout bank",
                  fillColor: Colors.white,
                  suffixIconColor: Colors.white,
                  iconColor: Colors.white,
                  prefixIconColor: Colors.white
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
              SizedBox(width: double.infinity, child: Text("Account Name", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
              TextField(
                keyboardType: TextInputType.text,
                controller: accountNameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(width: double.infinity, height: 8,),
              SizedBox(width: double.infinity, child: Text("Account Number", style : TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: "Raleway"
              ))),
              TextField(
                keyboardType: TextInputType.number,
                controller: accNumberController,
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
                    _login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue
                  ),
                  child: Text("Submit for verification", style: TextStyle(
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

  Future  _login() async{

    print("Address is: "+address);

    Map jsonData = {
      "serial" : "${int.parse(widget.serial)}",
      "fname" : "${firstNameController.text}",
      "lname" : "${lastNameController.text}",
      "bvn" : "${int.parse(bvnController.text)}",
      "bank" : "${bankController.text}",
      "accName" : "${accountNameController.text}",
      "accNumber" : "${int.parse(accNumberController.text)}"
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

    if(map["message"] == "Successful"){
      Navigator.pop(context);
    }
  }

  Future<void> _showMyDialog() async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hello Champ!', style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 20.0,
              fontWeight: FontWeight.w700
          ),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Welcome to the Standard Bullion trading app.', style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 10.0, width: double.infinity,),
                Text('Here, trading is different. It is easier to understand and easier to execute buy and sell orders, plus you will be trading actual commodities e.g Gold, Silver and the likes so your money will always have value here.', style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600
                ),),
                SizedBox(height: 10.0, width: double.infinity,),
                Text('Before we put you on track to start earning, we would like to get to know you more. So start your verification and we can proceed.', style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Start Verification'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
