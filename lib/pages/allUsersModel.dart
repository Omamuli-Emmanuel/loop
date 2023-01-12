
import 'dart:convert';

List<AllUsers> allUsersFromJson(String str)
=> List<AllUsers>.from(json.decode(str).map((x) => AllUsers.fromJson(x)));

String allUsersToJson(List<AllUsers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllUsers{
  String id = "";
  String fullname = "";
  String serial = "";
  String phone = "";
  String email = "";
  String status = "";

  AllUsers({
    required this.id,
    required this.fullname,
    required this.serial,
    required this.phone,
    required this.status,
    required this.email
  });

  factory AllUsers.fromJson(Map<String, dynamic> json) => AllUsers(
      id: json["id"],
      fullname: json["fullname"],
      serial: json["serial"],
      phone: json["phone"],
      status : json["status"],
      email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    id : id,
    fullname : fullname,
    email: email,
    phone : phone,
    serial : serial,
    status : status,
  };
}