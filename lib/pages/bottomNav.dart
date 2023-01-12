
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:standardbullionbank/pages/pending.dart';
import 'package:standardbullionbank/pages/profitLoss.dart';
import 'package:standardbullionbank/pages/dashboard.dart';

import 'account.dart';
import 'orderBook.dart';


class BottomNav extends StatefulWidget {
  final String id;
  final String serial;
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

  const BottomNav({
    Key? key,
    required this.id,
    required this.serial,
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
    required this.email,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return bottomNav();
  }
}

class bottomNav extends State<BottomNav> {
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
  String buy = '';
  String sell = '';
  String secure = '';
  int marketGold = 0;
  int marketSilver = 0;
  String email = "";

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screens = [
      Dashboard(id: widget.id,
            serial: widget.serial,
            fname: widget.fname,
            lname: widget.lname,
            phone: widget.phone,
            bankAccName: widget.bankAccName,
            bankName: widget.bankName,
            accNumber: widget.accNumber,
            wallet: widget.wallet,
            assetOunce : widget.assetOunce,
            accType : widget.accType,
            status: widget.status,
            buy: widget.buy,
            sell: widget.sell,
            target: widget.target,
            mGold: widget.mGold,
            secure: widget.secure,
            tpin: widget.tpin,
            mSilver: widget.mSilver,
            email: widget.email),
      ProfitLoss(
              serial: widget.serial,
              target: widget.target,
            ),
      OrderBook(),
      Account(id: widget.id,
          serial: widget.serial,
          fname: widget.fname,
          lname: widget.lname,
          phone: widget.phone,
          bankAccName: widget.bankAccName,
          bankName: widget.bankName,
          accNumber: widget.accNumber,
          wallet: widget.wallet,
          assetOunce : widget.assetOunce,
          accType : widget.accType,
          status: widget.status,
          buy: widget.buy,
          tpin: widget.tpin,
          sell: widget.sell,
          target: widget.target,
          mGold: widget.mGold,
          mSilver: widget.mSilver,
          email: widget.email)
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Loop today", style: TextStyle(
          fontFamily: "Raleway"
        ),),
        backgroundColor: Colors.black,
      ),
      body:  screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard, color: Colors.white,), label: 'Dashboard', backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.area_chart, color: Colors.white,), label: 'P&l Sheet', backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined, color: Colors.white,), label: 'Trade volumes', backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.white,), label: 'My Account', backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
