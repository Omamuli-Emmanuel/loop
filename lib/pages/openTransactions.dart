
import 'dart:convert';

List<OpenTransactions> transactionFromJson(String str)
=> List<OpenTransactions>.from(json.decode(str).map((x) => OpenTransactions.fromJson(x)));

String transactionToJson(List<OpenTransactions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OpenTransactions{
  String transactionId = "";
  String price = "";
  String date = "";
  String status = "";
  String type = "";
  String asset = "";
  String ounce = "";
  String sellAt = "";
  String amount = "";

  OpenTransactions({
    required this.transactionId,
    required this.price,
    required this.asset,
    required this.ounce,
    required this.date,
    required this.status,
    required this.type,
    required this.sellAt,
    required this.amount
  });

  factory OpenTransactions.fromJson(Map<String, dynamic> json) => OpenTransactions(
      transactionId: json["transactionId"],
      price: json["price"],
      asset: json["asset"],
      ounce: json["ounce"],
      date: json["date"],
      status: json["status"],
      type: json["type"],
      sellAt: json["sellAt"],
      amount: json["amount"]
  );

  Map<String, dynamic> toJson() => {
    transactionId: transactionId,
    price: price,
    asset: asset,
    ounce: ounce,
    date : date,
    status : status,
    type: type,
    sellAt : sellAt,
    amount : amount
  };
}