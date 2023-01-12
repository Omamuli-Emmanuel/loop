
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:standardbullionbank/pages/passwordreset.dart';
import 'package:standardbullionbank/pages/register.dart';

import 'admin.dart';
import 'bottomNav.dart';
import 'dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  login createState() => login();
}

class login extends State<Login> {
  //formkey
  final _formKey = GlobalKey<FormState>();

  //declear controlelrs
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  //declear variables
  late bool _passwordVisible;
  String address = "https://standardbullion.co/api/login.php";
  String rates = "https://standardbullion.co/api/getNairaRate.php";
  String market = "https://standardbullion.co/api/getMarketPrice.php";

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

  //init state
  @override
  void initState(){
    _passwordVisible = false;
  }

  bool isClicked = false;

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
            Container(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50, width: double.infinity,),
                        SizedBox(width: double.infinity,
                          child: Text("Email", style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w700
                        )),),
                        SizedBox(height: 5, width: double.infinity,),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontroller,
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
                        SizedBox(height: 8, width: double.infinity,),
                        SizedBox(width: double.infinity,
                          child: Text("Password", style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700
                          )),),
                        SizedBox(height: 5, width: double.infinity,),
                        TextField(
                          obscureText: !_passwordVisible,
                          keyboardType: TextInputType.emailAddress,
                          controller: passwordcontroller,
                          style: TextStyle(
                            color: Colors.white
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(onPressed: (){
                                setState((){
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                                  icon: Icon(
                                    _passwordVisible ?
                                    Icons.visibility
                                        :
                                    Icons.visibility_off,
                                    color: Colors.white,
                                  ))
                          ),
                        ),
                        SizedBox(height: 10, width: double.infinity,),
                        ElevatedButton(onPressed: (){
                          setState(() {
                            isClicked = true;
                          });
                          _login();
                        },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isClicked == true ?
                                CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 1.0,
                              )
                              :
                              Text("login", style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Raleway",
                                  color: Colors.black
                              ),),

                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50.0),
                              backgroundColor: Colors.white
                          ),
                        ),
                        SizedBox(width: double.infinity, height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center ,
                          children: [
                            Text("Not a member ?", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Raleway",
                                color: Colors.white
                            ),),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                            },
                                child: Text("Sign up here", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Raleway"
                                )))
                          ],
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordReset()));
                        },
                            child: Text("Forgot password ?", style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway",
                              fontSize: 15
                            ),)),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Future  _login() async{

    print("Address is: " + address);

    Map jsonData = {
      "email" : "${emailcontroller.text}",
      "password" : "${passwordcontroller.text}"
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(address));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print("Reply is: "+reply.toString());

    Map <String, dynamic> map = json.decode(reply.toString());

    if(map.containsKey("serial") && map["serial"] != null){
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

      if(status == "Decommissioned"){
        final successSnackbar = SnackBar(
          backgroundColor: Colors.red[800],
          content: const Text("User not found... try again",
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
      }else{
        if(role == "Admin" && status == "Active"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => adminDashboard()));
        }else{
          runRates();
        }
      }

  }else{
      final successSnackbar = SnackBar(
        backgroundColor: Colors.red[800],
        content: const Text("User not found... try again",
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
  void runRates() async{
    
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
    
    getBullionRates();
}

  void getBullionRates() async{

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

    marketGold = int.parse(getBullion['gold']);
    marketSilver = int.parse(getBullion['silver']);

    if(getBullion.containsKey("gold")){
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
      var snackbar = SnackBar(
        content: Text("Wrong email or password, try again.."),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
  }
