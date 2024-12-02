import 'dart:convert';

class LoginResponse {
  int status;
  String msg;

  LoginResponse({
    required this.status,
    required this.msg,
  });

  factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["Status"],
    msg: json["Msg"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Msg": msg,
  };
}
