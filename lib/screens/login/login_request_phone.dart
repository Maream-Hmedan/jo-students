import 'dart:convert';

class LoginRequestPhone {
  String sPassword;
  String reqType;
  String txtphone;

  LoginRequestPhone({
    required this.sPassword,
    required this.reqType,
    required this.txtphone,
  });

  factory LoginRequestPhone.fromRawJson(String str) => LoginRequestPhone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRequestPhone.fromJson(Map<String, dynamic> json) => LoginRequestPhone(
    sPassword: json["s_Password"],
    reqType: json["ReqType"],
    txtphone: json["txtphone"],
  );

  Map<String, dynamic> toJson() => {
    "s_Password": sPassword,
    "ReqType": reqType,
    "txtphone": txtphone,
  };
}
