
import 'dart:convert';

List<ProfitLossList> ProfitLossFromJson(String str)
=> List<ProfitLossList>.from(json.decode(str).map((x) => ProfitLossList.fromJson(x)));

String profitlossToJson(List<ProfitLossList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfitLossList{
  String oldWallet = "";
  String newWallet = "";
  String diff = "";
  String transactionId = "";
  String marker = "";
  String date = "";

  ProfitLossList({
    required this.oldWallet,
    required this.newWallet,
    required this.diff,
    required this.transactionId,
    required this.marker,
    required this.date,
  });

  factory ProfitLossList.fromJson(Map<String, dynamic> json) => ProfitLossList(
      oldWallet: json["oldWallet"],
      newWallet: json["newWallet"],
      diff: json["diff"],
      transactionId: json["transactionId"],
      marker : json["marker"],
      date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    oldWallet: oldWallet,
    newWallet: newWallet,
    diff : diff,
    transactionId : transactionId,
    marker : marker,
    date: date,
  };
}