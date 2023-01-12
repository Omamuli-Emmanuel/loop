
import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";

class DollarRate extends StatefulWidget {
  const DollarRate({Key? key}) : super(key: key);

  @override
  State<DollarRate> createState() => _DollarRateState();
}

class _DollarRateState extends State<DollarRate> {
  //declear controlelrs
  TextEditingController BuyController = TextEditingController();
  TextEditingController SellController = TextEditingController();

  String updateDollar = "https://standardbullion.co/api/updateDollarRate.php";
  String rates = "https://standardbullion.co/api/getNairaRate.php";

  String buy = "";
  String sell = "";


  @override
  void initState() {
    runRates();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update dollar rate"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(height: 50, width: double.infinity,),
            // Text("Update price",textAlign: TextAlign.start, style: TextStyle(
            //   fontSize: 20,
            //   fontFamily: "RaleWay",
            //   fontWeight: FontWeight.w700
            // ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Buy : ₦${buy.toString()}/USD", style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.green[500]
                ),),
                SizedBox(width: 20),
                Text("Sell : ₦${sell.toString()}/USD", style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.red[500]
                ),),
              ],
            ),
            SizedBox(height: 10, width: double.infinity,),
            TextField(
              keyboardType: TextInputType.number,
              controller: BuyController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Buy rate"
              ),
            ),
            SizedBox(height: 8, width: double.infinity,),
            TextField(
              keyboardType: TextInputType.number,
              controller: SellController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Sell Rate",)
              ),
            SizedBox(height: 10, width: double.infinity,),
            ElevatedButton(onPressed: (){
              UpdateRate();
            },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Update Dollar Price", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Raleway"
                  ),)
                ],
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.0)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future  UpdateRate() async{

    Map jsonData = {
      "Buy" : "${BuyController.text}",
      "Sell" : "${SellController.text}"
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(updateDollar));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("Reply is: "+reply.toString());

    Map <String, dynamic> map = json.decode(reply.toString());

    if(map['message'] == "Successful"){
      final successSnackbar = SnackBar(
        backgroundColor: Colors.green[800],
        content: const Text("Dollar rates updated successfully.",
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

      runRates();
    }else{
      final failedSnackbar =  SnackBar(
        backgroundColor: Colors.red[800],
        content: const Text("Failed to update dollar rates, try again.",
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

  Future<String?> runRates() async{

    Map jsonData = {
      "email" : "",
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

    buy = getRate['Buy'];
    sell = getRate['Sell'];

    //automatically refreshes page
    setState(() {});

  }
}
