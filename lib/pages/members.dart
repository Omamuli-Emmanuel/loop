
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'allUsersModel.dart';

class Members extends StatefulWidget {

  const Members(
      {Key? key})
      : super(key: key);

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {


  String allusers = "https://standardbullion.co/api/allUsers.php";
  String actionUrl = "https://standardbullion.co/api/userAction.php";


  //list of all transactions
  List<AllUsers> _Users = List.empty(growable: true);


  @override
  void initState() {
    getAllUsers().then((value){
      setState(() {
        _Users.addAll(value);
      });
    });
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
      ),
      body: Container(
        child: Column(
          children: [
            listallUsers()
          ],
        ),
      ),
    );
  }


  Future<List<AllUsers>>  getAllUsers() async {
    Map jsonData = {
      "serial": "",
      "asset" : ""
    };

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(allusers));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyTwo = await resp.transform(utf8.decoder).join();
    print("Reply is: " + replyTwo.toString());

    var transacts = json.decode(replyTwo);

    List<AllUsers> trac = List.empty(growable: true);

    for(var transact in transacts){
      trac.add(AllUsers.fromJson(transact));
    }

    httpClient.close();

    return trac;
  }


  Widget listallUsers(){
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _Users.length,
        itemBuilder: (context, index){
          return Container(
              child: Card(
                  color: Colors.black,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_Users[index].fullname, style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w700
                          ),
                          ),
                          SizedBox(height: 5,),
                          Text(_Users[index].email, style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700
                          ),),
                          SizedBox(height: 2,),
                          Text(_Users[index].phone, style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700
                          ),),
                          SizedBox(height: 2,),
                          Text(_Users[index].status, style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700
                          ),),
                          SizedBox(height: 2,),
                          _Users[index].status == "Approved" ?
                            Row(
                            children: [
                              Expanded(
                                  child: TextButton(onPressed: (){
                                    approveUser("Pending", _Users[index].serial);
                                  },
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.red[500])
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.verified_user, color: Colors.white,),
                                          SizedBox(width: 10,),
                                          Text("Deactivate User", style: TextStyle(
                                              color : Colors.white
                                          ),)
                                        ],
                                      ))
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child:  TextButton(onPressed: (){},
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.blue[500])
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.phone_android, color: Colors.white,),
                                        SizedBox(width: 10,),
                                        Text("Call User", style: TextStyle(
                                            color : Colors.white
                                        ),)
                                      ],
                                    )),
                              ),
                            ],
                          )
                          :
                            _Users[index].status == "Pending" ?
                                Row(
                              children: [
                                Expanded(
                                    child: TextButton(onPressed: (){
                                      approveUser("Approved", _Users[index].serial);
                                    },
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.green[500])
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.verified_user, color: Colors.white,),
                                            SizedBox(width: 10,),
                                            Text("Approve User", style: TextStyle(
                                                color : Colors.white
                                            ),)
                                          ],
                                        ))
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child:  TextButton(onPressed: (){},
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.blue[500])
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.phone_android, color: Colors.white,),
                                          SizedBox(width: 10,),
                                          Text("Call User", style: TextStyle(
                                              color : Colors.white
                                          ),)
                                        ],
                                      )),
                                ),
                              ],
                            )
                            :
                                Row(
                              children: [
                                Expanded(
                                  child:  TextButton(onPressed: (){},
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.blue[500])
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.phone_android, color: Colors.white,),
                                          SizedBox(width: 10,),
                                          Text("Call User", style: TextStyle(
                                              color : Colors.white
                                          ),)
                                        ],
                                      )),
                                ),
                              ],
                            )
                        ],
                      )
                  )
              )
          );
        });
  }

  Future<String?>  approveUser(String action, String serial) async {
    Map jsonData = {
      "serial": serial,
      "action": action,

    };

    //get buy and sell rate
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(actionUrl));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonData)));
    HttpClientResponse resp = await request.close();
    String replyRate = await resp.transform(utf8.decoder).join();
    print("Reply is: " + replyRate.toString());

    httpClient.close();
    Map <String, dynamic> getRate = json.decode(replyRate.toString());

    // print(getRate);

    if(getRate["message"] == "Successful"){
      final successSnackbar = SnackBar(
        backgroundColor: Colors.green[800],
        content: const Text("User status updated successfully.",
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
    final failedSnackbar =  SnackBar(
        backgroundColor: Colors.red[800],
        content: const Text("Failed to update user status, try again.",
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


      return replyRate;
    }

}
