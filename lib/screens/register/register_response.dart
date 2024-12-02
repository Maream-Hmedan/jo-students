import 'dart:convert';

class RegisterResponse {
  int? status;
  String? msg;
  String? regHash;
  int? userid;

  RegisterResponse({
    this.status,
    this.msg,
    this.regHash,
    this.userid,
  });

  factory RegisterResponse.fromRawJson(String str) => RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    status: json["Status"] != null ? json["Status"] as int : null,
    msg: json["Msg"] as String?,
    regHash: json["Reg_Hash"] as String?,
    userid: json["userid"] != null ? json["userid"] as int : null,
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Msg": msg,
    "Reg_Hash": regHash,
    "userid": userid,
  };
}

