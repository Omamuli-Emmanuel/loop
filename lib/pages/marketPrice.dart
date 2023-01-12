
import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class MarketPrice extends StatefulWidget {
  const MarketPrice({Key? key}) : super(key: key);

  @override
  State<MarketPrice> createState() => _MarketPriceState();
}

class _MarketPriceState extends State<MarketPrice> {

  //number formatter
  var formatter = NumberFormat('#,###,###,000');

  String updateMarketPrice = "https://standardbullion.co/api/updateMarketPrice.php";
  String market = "https://standardbullion.co/api/getMarketPriceTwo.php";

  //declear controlelrs
  TextEditingController GoldController = TextEditingController();
  TextEditingController SilverController = TextEditingController();
  TextEditingController PlatinumController = TextEditingController();
  TextEditingController PalladiumController = TextEditingController();

  String gold = "";
  String silver = "";
  String platinum = "";
  String palladium = "";

  @override
  void initState() {
    getBullionRates();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update asset market price"),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  gold == "" ?
                  Text("Gold : 0.00", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.blue[500]
                  ),)
                      :
                  Text("Gold : ${formatter.format(int.parse(gold)).toString()}", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.blue[500]
                  ),),
                  SizedBox(width: 20),
                  silver == "" ?
                  Text("Silver : 0.00", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.blue[500]
                  ),)
                      :
                  Text("Silver : ${formatter.format(int.parse(silver)).toString()}", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.blue[500]
                  ),),
                ],
              ),
              SizedBox(height: 10, width: double.infinity,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  platinum == "" ?
                  Text("Platinum : 0.00", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.blue[500]
                  ),)
                      :
                  Text("Platinum : ${formatter.format(int.parse(platinum)).toString()}", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.blue[500]
                  ),),
                  SizedBox(width: 20),
                  palladium == "" ?
                  Text("Palladium : 0.00", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.blue[500]
                  ),)
                      :
                  Text("Palladium : ${formatter.format(int.parse(palladium)).toString()}", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.blue[500]
                  ),),
                ],
              ),
              SizedBox(height: 10, width: double.infinity,),
              TextField(
                keyboardType: TextInputType.number,
                controller: GoldController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Gold Spot Price"
                ),
              ),
              SizedBox(height: 8, width: double.infinity,),
              TextField(
                  keyboardType: TextInputType.number,
                  controller: SilverController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Silver Spot Price",)
              ),
              SizedBox(height: 10, width: double.infinity,),
              SizedBox(height: 10, width: double.infinity,),
              TextField(
                keyboardType: TextInputType.number,
                controller: PlatinumController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Platinum Spot Price"
                ),
              ),
              SizedBox(height: 8, width: double.infinity,),
              TextField(
                  keyboardType: TextInputType.number,
                  controller: PalladiumController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Palladium Spot Price",)
              ),
              SizedBox(height: 10, width: double.infinity,),
              ElevatedButton(onPressed: (){
                UpdateRate();
              },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Update Market Price", style: TextStyle(
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
      ),
    );
  }

  Future  UpdateRate() async{

    Map jsonData = {
      "Gold" : "${GoldController.text}",
      "Silver" : "${SilverController.text}",
      "Platinum" : "${PlatinumController.text}",
      "Palladium" : "${PalladiumController.text}"
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(updateMarketPrice));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("Reply is: "+reply.toString());

    Map <String, dynamic> map = json.decode(reply.toString());

    print(reply.toString());

    if(map['message'] == "Successful"){
      final successSnackbar = SnackBar(
        backgroundColor: Colors.green[800],
        content: const Text("Market spot prices updated successfully.",
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

      getBullionRates();
    }else{
      final failedSnackbar =  SnackBar(
        backgroundColor: Colors.red[800],
        content: const Text("Failed to update market spot price, try again.",
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

  Future<String?> getBullionRates() async{

    Map jsonData = {
      "email" : "",
      "password" : ""
    };

    print(market);
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(market));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyRate = await resp.transform(utf8.decoder).join();
    print("Reply is: "+replyRate.toString());

    httpClient.close();
    Map <String, dynamic> getBullion = json.decode(replyRate.toString());

    gold = getBullion['gold'].toString();
    silver = getBullion['silver'].toString();
    platinum = getBullion['platinum'].toString();
    palladium = getBullion['palladium'].toString();

    //automatically refreshes page
    setState(() {});
  }

}
