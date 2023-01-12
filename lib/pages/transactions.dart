
import 'dart:convert';

List<Transactions> transactionFromJson(String str)
=> List<Transactions>.from(json.decode(str).map((x) => Transactions.fromJson(x)));

String transactionToJson(List<Transactions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transactions{
  String transactionId = "";
  String sum = "";
  String price = "";
  String date = "";
  String status = "";
  String type = "";
  String asset = "";
  String ounce = "";
  String target = "";
  String sellAt = "";

  Transactions({
    required this.transactionId,
    required this.sum,
    required this.price,
    required this.asset,
    required this.ounce,
    required this.date,
    required this.status,
    required this.type,
    required this.target,
    required this.sellAt
});

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
    transactionId: json["transactionId"],
    sum: json["sum"],
    price: json["price"],
    asset: json["asset"],
    ounce: json["ounce"],
    date: json["date"],
    status: json["status"],
    target: json["target"],
    type: json["type"],
    sellAt: json["sellAt"]
  );

  Map<String, dynamic> toJson() => {
      transactionId: transactionId,
      sum: sum,
      price: price,
      asset: asset,
      ounce: ounce,
      date : date,
      status : status,
      target : target,
      type: type,
      sellAt : sellAt
  };
}