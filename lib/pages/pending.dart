
import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';

class Pending extends StatelessWidget {

  @override
  Pending createState() {
    return Pending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQs"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity, child: Text("Some common Loop questions", style: TextStyle(
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white
              ), textAlign: TextAlign.center,),),
              SizedBox(height: 10, width: double.infinity,),
              ExpandableTheme(
                  data: const ExpandableThemeData(
                      useInkWell: true,
                      iconColor: Colors.blue
                  ),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Card1(),
                      Card2(),
                      Card3(),
                      Card4(),
                      Card5(),
                      Card6(),
                      Card7(),
                      Card8(),
                      Card9(),
                      Card10(),
                      Card11(),
                    ],
                  ))
            ],
          )
        ),
      ),
    );
  }
}


const loremIpsumOne = "Loop is acronym for (Live Only On Profits). Loop was established to level the investment playing field for all levels of income (low, middle, upper class earners. We strongly believe that no matter your income level, you can and should be able to live soly on the profits of your savings.)";


const loremIpsumTwo =
    "The effects of the inflation in the world has thrown third world and developing economies into a serious state or recession. This has forced well meaning income earner to start banking in other currencies like the U.S dollar, the British pounds, etc in a bid to earn profit from the price difference over time. However, access to these foreign currencies are limited and only those who really earn enough can afford to access it, and only those who possess a high skill level can earn their pay in it. ";

const loremIpsumTwoSub =
    "With Loop, even those with very little income levels can now afford to buy quality investment assets and earn a healthy profit to better improve their financial state.";

const loremIpsumThree =
    "Loop simply affords you as a user, the ability to save your spare cash or investment budget in Gold or in Silver. Every deposit you make into your account automatically buys you a certain quantity of Gold if your account is a Gold account, or Silver if your account is a Silver account";

const loremIpsumThreeSub =
    "As the price of either Gold or Silver increases in the international market, so does your savings balance. This way you can make spontaneous profits. Consequently when the price of Gold or silver drops, you will experience a drop in your savings balance, but not to worry, all you have to do is hold and wait for the price to come back up.";

const loremIpsumFour =
    "Loop is not a get rich quick scheme. It requires come level of patience and calmness. However, the more Gold or Silver you buy, the higher your profits will be when price moves in your favor. The only way you will loose your money in Loop is if you decide to withdraw all your money when your account is in a state of loss during price downtime. In this case, we strongly urge you to remain calm and wait for price to come back up.";

const loremIpsumFive =
    "The price of Naira / USD at black market rate can result in profit or loss in your account just like it does when you save in USD. The price of Gold and Silver can also result in profit or loss as your account grows when price grows as well.";

const loremIpsumSix =
    "Unlike Crypto assets that are intangible, at Loop, you are buying and storing actual Gold and Silver whenever you make a deposit. These assets are stored safely at one out of the four locations our partners offers (Singapore, London, Zurich, New York). So what you have is the asset, even if your account drops to zero or a negative due to drastic price drop, you still have these assets. all you have to do is wait for the price to come back up and you will start earning again.";

const loremIpsumSeven =
    "You can withdraw your funds at anytime. Although we would recommend you stick to withdrawing only a portion of your profit you absolutely need. This will help your account accumulate more money and grow faster so you can earn better.";

const loremIpsumEight =
    "This is absolutely fine. Loop deals on premium grade and quality 24 karats Gold and Silver with 99.99% purity . You will need to cover the cost of shipping the asset down and getting it delivered to your doorstep. Do note that the asset will be delivered to you in bars form and not as jewelries.";

const loremIpsumNine =
    "You can deposit a minimum of 1,000 NGN , but by regulation, our integrated payment gateway is restricted from allowing you deposit above 500,000 NGN per day. In order to make a higher deposit, you will need to contact us and we can assist you in getting this done.";

const loremIpsumTen =
    "Withdrawals can take anytime between 24hrs to 7 working days to reflect in your account. This is due to the various channels the funds will have to go through before it gets to us from our international partner.";


const loremIpsumEleven =
    "You will find more answered FAQs on our landing page https://www.standardbullion.co/FAQs. Alterntively, you can engage us in a conversation via any of our social media outlets and we will give you all the attention you need in order for you to make a decision.";


class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "What is Loop ?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Text(
                      loremIpsumOne,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumOne,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Why Loop ?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Column(
                      children: [
                        Text(
                          loremIpsumTwo,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      ],
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumTwo,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                        SizedBox(width: double.infinity, height: 10,),
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumTwoSub,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "How does Loop work generally ?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Text(
                      loremIpsumThree,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumThree,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                        SizedBox(width: double.infinity, height: 10,),
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumThreeSub,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
class Card4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Will i loose my money ?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Text(
                      loremIpsumFour,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumFour,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
class Card5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "What are the prices that can affect my savings ?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Text(
                      loremIpsumFive,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumFive,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
class Card6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Will my account ever zero out ?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Text(
                      loremIpsumSix,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumSix,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
class Card7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "When can i withdraw funds?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Text(
                      loremIpsumSeven,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumSeven,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
class Card8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "What if i want my Gold or Silver delievered to me ?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Text(
                      loremIpsumEight,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumEight,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
class Card9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "What are the minimum and maximum amounts i can deposit ?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Text(
                      loremIpsumNine,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumNine,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
class Card10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "How long does it take to process withdrawals requests ?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Text(
                      loremIpsumTen,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumTen,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
class Card11 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "I have more questions",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Raleway"
                          ),
                        )),
                    collapsed: Text(
                      loremIpsumEleven,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              loremIpsumEleven,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}




