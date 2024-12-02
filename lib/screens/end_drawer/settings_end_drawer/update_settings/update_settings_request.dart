import 'dart:convert';

class UpdateMySettingsRequest {
  int userid;
  String txtemailadd;
  String txtphonenumber;
  String txtpass;

  UpdateMySettingsRequest({
    required this.userid,
    required this.txtemailadd,
    required this.txtphonenumber,
    required this.txtpass,
  });

  UpdateMySettingsRequest copyWith({
    int? userid,
    String? txtemailadd,
    String? txtphonenumber,
    String? txtpass,
  }) =>
      UpdateMySettingsRequest(
        userid: userid ?? this.userid,
        txtemailadd: txtemailadd ?? this.txtemailadd,
        txtphonenumber: txtphonenumber ?? this.txtphonenumber,
        txtpass: txtpass ?? this.txtpass,
      );

  factory UpdateMySettingsRequest.fromRawJson(String str) => UpdateMySettingsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateMySettingsRequest.fromJson(Map<String, dynamic> json) => UpdateMySettingsRequest(
    userid: json["userid"],
    txtemailadd: json["txtemailadd"],
    txtphonenumber: json["txtphonenumber"],
    txtpass: json["txtpass"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "txtemailadd": txtemailadd,
    "txtphonenumber": txtphonenumber,
    "txtpass": txtpass,
  };
}
