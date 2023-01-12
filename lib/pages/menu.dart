
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:standardbullionbank/pages/MenuItemMe.dart';
import 'package:standardbullionbank/pages/login.dart';

class MenuItemsMe {
  static const orderBook =  MenuItemMe('Order Book', Icons.list);
  static const fixed =  MenuItemMe('Fixed contracts', Icons.list);
  static const learn =  MenuItemMe('Tutorials', Icons.list);
  static const settings =  MenuItemMe('settings', Icons.list);
}

class MenuScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
  backgroundColor: Colors.black54,
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 250,
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Standard",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w500,
                          fontSize: 42
                      ),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Bullion",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w400,
                            fontSize: 28
                        ),
                      ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
            children: [
              ListTile(
                minLeadingWidth: 20,
                leading: Icon(Icons.list, color: Colors.white,),
                title: Text("Order Book", style: TextStyle(color: Colors.white),),
                onTap: (){},
              ),
              ListTile(
                minLeadingWidth: 20,
                leading: Icon(Icons.verified, color: Colors.white,),
                title: Text("Fixed Contracts", style: TextStyle(color: Colors.white),),
                onTap: (){},
              ),
              ListTile(
                minLeadingWidth: 20,
                leading: Icon(Icons.book, color: Colors.white,),
                title: Text("Tutorials", style: TextStyle(color: Colors.white),),
                onTap: (){},
              ),
              ListTile(
                minLeadingWidth: 20,
                leading: Icon(Icons.settings, color: Colors.white,),
                title: Text("Settings", style: TextStyle(color: Colors.white),),
                onTap: (){},
              ),
              ListTile(
                minLeadingWidth: 20,
                leading: Icon(Icons.logout, color: Colors.red,),
                title: Text("Logout", style: TextStyle(color: Colors.white),),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => Login()));
                },
              ),
            ],
          ),),
        ],
      )
    ),
  );
  //
  // Widget buildMenuItem(MenuItemMe item) => ListTile(
  //     minLeadingWidth: 20,
  //     leading: Icon(item.icon),
  //     title: Text(item.title),
  //     onTap: (){},
  // );
}
