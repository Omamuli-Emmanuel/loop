import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:standardbullionbank/pages/account.dart';

import 'bottomNav.dart';
import 'bottomNavToAccount.dart';

class WithdrawFunds extends StatefulWidget {
  final String amountNaira;
  final String totalOunce;
  final String serial;

  final String id;
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
  final String secure;
  final int mGold;
  final int mSilver;
  final String email;

  const WithdrawFunds({
  Key? key,
  required this.serial,
  required this.id,
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
  required this.mGold,
  required this.target,
  required this.secure,
  required this.tpin,
  required this.mSilver,
  required this.email, required this.amountNaira, required this.totalOunce,
  }) : super(key: key);

  @override
  State<WithdrawFunds> createState() => _WithdrawFundsState();
}

class _WithdrawFundsState extends State<WithdrawFunds> {
  TextEditingController amountController = TextEditingController();
  var formatter = NumberFormat('#,###,###,000');
  //formkey
  final _formKey = GlobalKey<FormState>();
  String message = "";
  String withdrawLink = "https://standardbullion.co/api/withdraw.php";
  String verifyTpin = "https://standardbullion.co/api/verifytPin.php";
  TextEditingController transactionPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 50, width: double.infinity,),
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
                      Text("Withdraw to bank", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Raleway",
                          color: Colors.white
                      ),)
                    ],
                  )
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(width: double.infinity, height: 20,),
                    Text("It's always a great feeling to get paid, so let's do this.", style : TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontFamily: "Raleway"
                    )),

                    SizedBox(width: double.infinity, height: 30,),
                    SizedBox(width: double.infinity, child: Text("Amount to withdraw", style : TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        fontFamily: "Raleway"
                    ))),
                    SizedBox(width: double.infinity, height: 10,),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: checkAmounts,
                        controller: amountController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.blue),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: double.infinity, height: 5,),
                    Text("Account Balance: ₦${formatter.format(int.parse(widget.amountNaira))}", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),),
                    SizedBox(width: double.infinity, height: 5,),
                    ElevatedButton(onPressed: (){

                      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                        setTransactionPin(context);
                      }

                    },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 40.0)
                        ),
                        child: Text("Withdraw", style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            fontFamily: "Raleway"
                        ),)),
                    SizedBox(width: double.infinity, height: 20,),
                    SizedBox(width: double.infinity, child:
                    Text("Withdraw as physical asset", style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "Raleway"),),),
                    SizedBox(width: double.infinity, height: 10,),
                    SizedBox(width: double.infinity, child:
                    Text("Its exciting to know you can have your bullion asset delivered to your door step. However, please note the following:", style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13, fontFamily: "Raleway"),),),
                    ListTile(
                      leading: Icon(Icons.circle_outlined, color: Colors.blue,),
                      title: Text("Physical assets are stored in one of our four locations (Singapore, London, New York, Switzerland) and will attract a logistics fee to get them delievered.", style: TextStyle(fontFamily: "Raleway", fontSize: 13, color: Colors.white),),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle_outlined, color: Colors.blue,),
                      title: Text("Assets less than 10 ounces are not eligible for physical withdrawals", style: TextStyle(fontFamily: "Raleway", fontSize: 13, color: Colors.white),),
                    ),
                    ListTile(
                      leading: Icon(Icons.circle_outlined, color: Colors.blue,),
                      title: Text("Your physical asset may be delivered to you in bars. It will be your responsibility to make them into whatever form you desire.", style: TextStyle(fontFamily: "Raleway", fontSize: 13, color: Colors.white),),
                    ),
                    Text("To get started, send us a mail to the address below, stating your account number, registred mobile phone number and qauntity to be withdrawn. We would be delighted to reach out and work with you till you have your bullion safe at home.", style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13, fontFamily: "Raleway"),),
                    SizedBox(width: double.infinity, height: 10,),
                    Text("hello@standardbullion.co", style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "Raleway"),),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  String? checkAmounts(String? amount){
    if (int.parse(amountController.text) < 1000) {
      return 'You can only withdraw a minimum of ₦1,000';
    }else if(int.parse(amountController.text) > int.parse(widget.amountNaira)) {
      return "You have insufficient funds.";
    }
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
                        label: Text("Enter transaction pin", style: TextStyle(
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
                          verifyPin();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        child: Text("Process funds", style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ))
                    ),
                    Text("This pin will be used to authenticate withdrawals", style: TextStyle(
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

  Future verifyPin() async{
    Navigator.pop(context);
    Map jsonData = {
      "serial" : widget.serial,
      "tpin" : "${transactionPinController.text}",
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(verifyTpin));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("Reply is: "+reply.toString());

    Map <String, dynamic> map = json.decode(reply.toString());


    if(map['message'] == "Successful"){
      withdraw();
    }else{
      final failedSnackbar =  SnackBar(
        backgroundColor: Colors.red[800],
        content: const Text("Incorrect transaction pin, try again.",
          style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
        ),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Ok',
          onPressed: (){},
        ),
        duration: Duration(milliseconds: 10000),
      );

      ScaffoldMessenger.of(context).showSnackBar(failedSnackbar);
    }
  }

  Future<String> withdraw() async{

    Map jsonData = {
      "serial" : widget.serial,
      "amount" : int.parse(amountController.text)
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(withdrawLink));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyRate = await resp.transform(utf8.decoder).join();
    print("Reply is: "+replyRate.toString());

    httpClient.close();
    Map <String, dynamic> getRate = json.decode(replyRate.toString());

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
      double assetOunce = getRate["assetOunce"];
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
        assetOunce: assetOunce.toString(),
        accType: accType,
        status: status,
        target: target,
        buy: buy,
        sell: sell,
        secure: secure,
        tpin: tpin,
        mGold: marketGold,
        mSilver: marketSilver,
        email: email,
      )));
    }

    return replyRate;
  }

}
