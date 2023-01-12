
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'newAsk.dart';
import 'nosecure.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {

  TextEditingController numberController = TextEditingController();
  String address = "https://standardbullion.co/api/checkNumber.php";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox( height: 50, width: double.infinity, child:
              Text("Loop", style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700
              ), textAlign: TextAlign.center,),
              ),
              Text("live only on profits", style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700
              ), textAlign: TextAlign.center,),
              SizedBox(width: double.infinity, height: 20,),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(width: double.infinity,
                        child: Text("Enter account number OR registered phone number", style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w700
                        )),),
                        SizedBox(height: 5, width: double.infinity,),
                        TextField(
                        keyboardType: TextInputType.number,
                        controller: numberController,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.white),
                          ),
                          border: OutlineInputBorder(

                          ),
                        ),
                      ),
                        SizedBox(width: double.infinity, height: 10,),
                        ElevatedButton(onPressed: (){
                        checkAccountNumber();
                      },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Get account", style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Raleway",
                                color: Colors.black
                            ),)
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 40.0),
                            backgroundColor: Colors.white
                        ),
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
        )
    );
  }

  Future  checkAccountNumber() async{

    Map jsonData = {
      "number" : "${numberController.text}",
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(address));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("Reply is: "+reply.toString());

    Map <String, dynamic> map = json.decode(reply.toString());
    String serial = map["serial"];
    
    if(map["message"] == "Successful"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewAsk(serial: serial,)));
    }else if(map["message"] == "No"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoSecure(serial: serial,)));
    }else{
      final successSnackbar = SnackBar(
              backgroundColor: Colors.red[800],
              content: const Text("We couldn't find your account ... try again",
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

    // if(map.containsKey("serial") && map["serial"] != null){
    //   id = map['id'];
    //   serial = map['serial'];
    //   fname = map['fname'];
    //   lname = map['lname'];
    //   phone = map['phone'];
    //   bankAccName = map['accountName'];
    //   bankName = map['bankName'];
    //   accNumber = map['accountNumber'];
    //   wallet = map['wallet'];
    //   assetOunce = map['assetOunce'];
    //   accType = map['accType'];
    //   status = map['status'];
    //   target = map['target'];
    //   secure = map['secure'];
    //   tpin = map['tpin'];
    //   email = map['email'];
    //   role = map['role'];
    //
    //   if(role == "Admin" && status == "Active"){
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => adminDashboard()));
    //   }else{
    //     runRates();
    //   }
    // }else{
    //   final successSnackbar = SnackBar(
    //     backgroundColor: Colors.red[800],
    //     content: const Text("User not found... try again",
    //       style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
    //     ),
    //     action: SnackBarAction(
    //       textColor: Colors.white,
    //       label: 'Ok',
    //       onPressed: (){},
    //     ),
    //     duration: Duration(milliseconds: 10000),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(successSnackbar);
    // }
  }
}

