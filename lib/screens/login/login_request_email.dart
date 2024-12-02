import 'dart:convert';

class LoginRequestEmail {
  String sPassword;
  String reqType;
  String sEmailAdd;

  LoginRequestEmail({
    required this.sPassword,
    required this.reqType,
    required this.sEmailAdd,
  });

  factory LoginRequestEmail.fromRawJson(String str) => LoginRequestEmail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRequestEmail.fromJson(Map<String, dynamic> json) => LoginRequestEmail(
    sPassword: json["s_Password"],
    reqType: json["ReqType"],
    sEmailAdd: json["s_EmailAdd"],
  );

  Map<String, dynamic> toJson() => {
    "s_Password": sPassword,
    "ReqType": reqType,
    "s_EmailAdd": sEmailAdd,
  };
}
