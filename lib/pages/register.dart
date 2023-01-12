
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:standardbullionbank/pages/bottomNav.dart';
import 'dashboard.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  register createState() => register();
}

class register extends State<Register> {

  //formkey
  final _formKey = GlobalKey<FormState>();


  //declear controlelrs
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController phoneNumberControler = TextEditingController();
  TextEditingController referredByController = TextEditingController();

  var _currentItemSelected = 'Select preferred account type';
  var _stores = [
    'Select preferred account type',
    'Gold account',
    'Silver account',
  ];

  //declear variables
  late bool _passwordVisible;
  late bool _password2Visible;
  String regStatus = "";

  String address = "https://standardbullion.co/api/register.php";
  //init state
  @override
  void initState(){
    _passwordVisible = false;
    _password2Visible = false;
  }

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(width: double.infinity, height: 50,),
                    SizedBox(width: double.infinity, height: 20,),
                    Text("Create a free account", style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Raleway",
                        color: Colors.white
                    )),
                    SizedBox(height: 20, width: double.infinity,),
                    SizedBox(width: double.infinity, child: Text("Email", style : TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        fontFamily: "Raleway"
                    ))),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.blue),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8, width: double.infinity,),
                    SizedBox(width: double.infinity, child: Text("Veridied phone  number", style : TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        fontFamily: "Raleway"
                    ))),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneNumberControler,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.blue),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8, width: double.infinity,),
                    SizedBox(width: double.infinity, child: Text("Referred by (Enter account number of your referee)", style : TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        fontFamily: "Raleway"
                    ))),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: referredByController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.blue),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15, width: double.infinity,),
                    Text("Your deposits will be converted to your "
                        "seleted account type asset. Select Gold for a gold based account, "
                        "select Silver for a silver based account", style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Raleway",
                        color: Colors.white
                    ),),
                    SizedBox(height: 8, width: double.infinity,),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: DropdownButtonFormField<String?>(
                          dropdownColor: Colors.black,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          items: _stores.map((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(
                                  color: Colors.white
                              ),),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String? newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          }),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.grey)
                      ),
                    ),
                    SizedBox(height: 8, width: double.infinity,),
                    SizedBox(width: double.infinity, child: Text("Password", style : TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        fontFamily: "Raleway"
                    ))),
                    TextFormField(
                      validator: passwordvalidate,
                      obscureText: !_passwordVisible,
                      keyboardType: TextInputType.emailAddress,
                      controller: passwordcontroller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.blue),
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
                                color: Theme.of(context).primaryColor,
                              ))
                      ),
                    ),
                    SizedBox(height: 8, width: double.infinity,),
                    SizedBox(width: double.infinity, child: Text("Confirm password", style : TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        fontFamily: "Raleway"
                    ))),
                    TextFormField(
                      validator: passwordvalidate,
                      obscureText: !_password2Visible,
                      keyboardType: TextInputType.emailAddress,
                      controller: confirmpassword,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.blue),
                          ),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(onPressed: (){
                            setState((){
                              _password2Visible = !_password2Visible;
                            });
                          },
                              icon: Icon(
                                _password2Visible ?
                                Icons.visibility
                                    :
                                Icons.visibility_off,
                                color: Theme.of(context).primaryColor,
                              ))
                      ),
                    ),
                    SizedBox(height: 10, width: double.infinity,),
                    ElevatedButton(onPressed: (){
                      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                        setState(() {
                          isClicked = true;
                        });
                        _signUp();
                      }
                    },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isClicked == true ?
                            CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.0,
                          )
                          :
                            Text("Create account", style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Raleway"
                          ),)
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.0)
                      ),
                    ),
                    SizedBox(width: double.infinity, height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        Text("Already a member ?", style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Raleway",
                            color: Colors.white
                        ),),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                            child: Text("Login up here", style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Raleway"
                            )))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? passwordvalidate(String? pass){
    if (pass == null || pass
        .trim()
        .isEmpty) {
      return 'This field is required';
    }
    if (passwordcontroller.text != confirmpassword.text) {
      return "Passwords do not match";
    }
  }

  void _onDropDownItemSelected(String? newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected!;
    });
  }


  Future  _signUp() async{

    print("Address is: "+address);

    Map jsonData = {
      "email" : "${emailcontroller.text}",
      "phone" : "${phoneNumberControler.text}",
      "password" : "${passwordcontroller.text}",
      "accType" : "${_currentItemSelected}",
      "referredBy" : "${referredByController.text}",
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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Login()));
    }else if(map["message"] == "Exists"){
      final successSnackbar = SnackBar(
        backgroundColor: Colors.green[800],
        content: const Text("Account already exisits.. try loging in instead.",
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
      final successSnackbar = SnackBar(
        backgroundColor: Colors.green[800],
        content: const Text("We had trouble creating your account, try again..",
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
}
