
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:intl/intl.dart';

import 'bottomNav.dart';
import 'dashboard.dart';

class Fund extends StatefulWidget {

  final String serial;
  final String fname;
  final String lname;
  final String phone;
  final String email;
  final String sell;
  final int mGold;
  final int mSilver;
  final String buy;
  final String accType;

  const Fund({
    Key? key,
    required this.serial,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.email,
    required this.buy,
    required this.mGold,
    required this.mSilver,
    required this.sell,
    required this.accType
  }) : super(key: key);

  @override
  State<Fund> createState() => fund();
}

class fund extends State<Fund> {
  var formatter = NumberFormat('#,###,###,000');

  String fundAcc = "https://standardbullion.co/api/fundAccount.php";

  bool isTestMode = true;

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String amount = "";
  double amtOunce = 0;
  int assPrice = 0;

  // implementing paystack

  String publicKeyTest = 'pk_test_1956a429a90ded276788abfcf9f5503bf3db8a21';
  String publicKeyLive = 'pk_live_50cdf1e26d72e32e3729cfe26936066d42003719';//pass in the public test key here
  final plugin = PaystackPlugin();
  @override
  void initState() {
    plugin.initialize(publicKey: publicKeyLive);
    super.initState();
  }
  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  @override
  Widget build(BuildContext context) {
    widget.accType == "Gold account" ?
    assPrice = widget.mGold * int.parse(widget.buy)
        :
    assPrice = (widget.mSilver * int.parse(widget.buy));

    return Scaffold(
      body: Container(
          width: double.infinity,
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 1.0,
                    color: Colors.black,
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
                                Text("Make a deposit", style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Raleway",
                                    color: Colors.white
                                ),)
                              ],
                            )
                        ),
                        Expanded(
                          child: Container(
                              color: Colors.black,
                              child: CustomKeyBoard(
                                pinTheme: PinTheme(
                                    textColor: Colors.white,
                                    keysColor: Colors.white,
                                    submitColor : Colors.black
                                ),
                                onChanged: (v) {
                                  // if (kDebugMode) {
                                  //   print(v);
                                  //   amount = v.toString();
                                  //   setState(() {
                                  //     amtOunce = int.parse(amount).toInt() / assPrice;
                                  //   });
                                  //   print(amtOunce);
                                  // }

                                  print(v);
                                  amount = v.toString();
                                  setState(() {
                                    amtOunce = int.parse(amount).toInt() / assPrice;
                                  });
                                  print(amtOunce);

                                },
                                onbuttonClick: () {
                                  // if (kDebugMode) {
                                  //   // _handlePaymentInitialization();
                                  //   chargeCard();
                                  //   print('clicked');
                                  // }

                                  chargeCard();
                                  print('clicked');
                                },
                                maxLength: 100,
                                submitLabel: Column(
                                  children: [
                                    Text(
                                      'Continue to payment',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22,
                                          fontFamily: "Raleway"
                                      ),
                                    ),
                                    showConvert()
                                  ],
                                ),
                                // ),
                              )
                          ),
                        )
                      ],
                    )
                ),
              ],
            ),
          )
      ),
    );
  }


  Widget showConvert(){
    return Text("You will get ${amtOunce.toStringAsFixed(4)} ounce", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),);
  }

  chargeCard() async {
    var charge = Charge()
      ..amount = int.parse(amount) * 100 //the money should be in kobo hence the need to multiply the value by 100
      ..reference = _getReference()
      ..putCustomField('custom_id', getRandomString(15)) //to pass extra parameters to be retrieved on the response from Paystack
      ..email = widget.email.toString();
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    if (response.status == true) {
        creditAccount();
      _showMessage('Payment was successful!!!');
    } else {
      _showMessage('Payment Failed!!!');
    }
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  Future<String>  creditAccount() async{

    Map jsonData = {
      "serial" : widget.serial,
      "amount" : amount,
      "accType" : widget.accType
    };

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(fundAcc));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyRate = await resp.transform(utf8.decoder).join();
    print("Reply is: "+ replyRate.toString());

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
      String secure = getRate["secure"];
      String target = getRate["target"];
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
        buy: buy,
        sell: sell,
        target: target,
        mGold: marketGold,
        secure: secure,
        tpin : tpin,
        mSilver: marketSilver,
        email: email,
      )));
    }
    return replyRate;
  }

}
