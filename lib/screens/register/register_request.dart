import 'dart:convert';

class RegisterRequest {
  String txtemail;
  String txtfullname;
  String txtpass;
  String txtphone;

  RegisterRequest({
    required this.txtemail,
    required this.txtfullname,
    required this.txtpass,
    required this.txtphone,
  });

  factory RegisterRequest.fromRawJson(String str) => RegisterRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => RegisterRequest(
    txtemail: json["txtemail"],
    txtfullname: json["txtfullname"],
    txtpass: json["txtpass"],
    txtphone: json["txtphone"],
  );

  Map<String, dynamic> toJson() => {
    "txtemail": txtemail,
    "txtfullname": txtfullname,
    "txtpass": txtpass,
    "txtphone": txtphone,
  };
}
