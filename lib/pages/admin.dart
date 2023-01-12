
import 'package:flutter/material.dart';
import 'package:standardbullionbank/pages/marketPrice.dart';
import 'package:standardbullionbank/pages/members.dart';

import 'dollarRate.dart';
import 'login.dart';

class adminDashboard extends StatefulWidget {
  const adminDashboard({Key? key}) : super(key: key);

  @override
  State<adminDashboard> createState() => _adminDashboardState();
}

class _adminDashboardState extends State<adminDashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Admin console"),
      ),
      body: Center(
        child: Text("Welcome to the admin console"),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                // image: DecorationImage(
                //     fit: BoxFit.fill,
                //     image: AssetImage('assets/images/cover.jpg'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.verified_user, color: Colors.green,),
            title: Text('All Users'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Members()))},
          ),
          ListTile(
            leading: Icon(Icons.price_change, color: Colors.green),
            title: Text('Update Dollar rate'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=> DollarRate()))},
          ),
          ListTile(
            leading: Icon(Icons.area_chart, color : Colors.green),
            title: Text('Update Bullion Market Price'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => MarketPrice()))},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => Login()))},
          ),
        ],
      ),
    );
  }
}
