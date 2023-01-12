
import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

import 'login.dart';

class Onboarding extends StatefulWidget {

  @override
  onboarding createState() => onboarding();
}

class onboarding extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroScreenOnboarding(
        skipTextStyle: TextStyle(
          fontFamily: "Raleway",
          fontSize: 18,
          fontWeight: FontWeight.w500
        ),
        introductionList: [
          Introduction(
            titleTextStyle: TextStyle(
                fontFamily: "Raleway",
                fontSize: 25,
                fontWeight: FontWeight.w700,
              color: Colors.white
            ),
            subTitleTextStyle: TextStyle(
                fontFamily: "Raleway",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
            title: "Buy & Sell",
            subTitle: "We offer you the cheapest way to buy & sell Gold or Silver at competitive rates.",
            imageUrl: "assets/trade.png",
          ),
          Introduction(
            titleTextStyle: TextStyle(
                fontFamily: "Raleway",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.white
            ),
            subTitleTextStyle: TextStyle(
                fontFamily: "Raleway",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
            title: "Automate your earnings",
            subTitle: "Earn 10% from every profit your referees make for life. Stay ahead of your needs with easy commissions.",
            imageUrl: "assets/invest.png",
          ),
          Introduction(
            titleTextStyle: TextStyle(
                fontFamily: "Raleway",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.white
            ),
            subTitleTextStyle: TextStyle(
                fontFamily: "Raleway",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
            title: "Your gold is safe",
            subTitle: "With as little as 1000 NGN, you can purchase Gold or Silver stored in some of the world's most secure vaults. Cashout your assets anytime.",
            imageUrl: "assets/swap.png",
          ),
        ],
        backgroudColor: Colors.black,
        onTapSkipButton: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
        },
      ),
    );
  }
}
