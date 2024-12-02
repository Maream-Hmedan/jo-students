import 'dart:convert';

class UpdateProfileRequest {
  String txtemail;
  String cmbgender;
  String txtfullname;
  String  ? txtschoolname;
  String cmbcountry;
  String ?txtaboutme;
  String userid;
  String ? txtprofilepic;
  String txtphonenumber;

  UpdateProfileRequest({
    required this.txtemail,
    required this.cmbgender,
    required this.txtfullname,
    required this.txtschoolname,
    required this.cmbcountry,
    required this.txtaboutme,
    required this.userid,
    required this.txtprofilepic,
    required this.txtphonenumber,
  });

  UpdateProfileRequest copyWith({
    String? txtemail,
    String? cmbgender,
    String? txtfullname,
    String? txtschoolname,
    String? cmbcountry,
    String? txtaboutme,
    String? userid,
    String? txtprofilepic,
    String? txtphonenumber,
  }) =>
      UpdateProfileRequest(
        txtemail: txtemail ?? this.txtemail,
        cmbgender: cmbgender ?? this.cmbgender,
        txtfullname: txtfullname ?? this.txtfullname,
        txtschoolname: txtschoolname ?? this.txtschoolname,
        cmbcountry: cmbcountry ?? this.cmbcountry,
        txtaboutme: txtaboutme ?? this.txtaboutme,
        userid: userid ?? this.userid,
        txtprofilepic: txtprofilepic ?? this.txtprofilepic,
        txtphonenumber: txtphonenumber ?? this.txtphonenumber,
      );

  factory UpdateProfileRequest.fromRawJson(String str) => UpdateProfileRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) => UpdateProfileRequest(
    txtemail: json["txtemail"],
    cmbgender: json["cmbgender"],
    txtfullname: json["txtfullname"],
    txtschoolname: json["txtschoolname"]??"",
    cmbcountry: json["cmbcountry"],
    txtaboutme: json["txtaboutme"]??"",
    userid: json["userid"],
    txtprofilepic: json["txtprofilepic"]??"",
    txtphonenumber: json["txtphonenumber"],
  );

  Map<String, String> toJson() => {
    "txtemail": txtemail,
    "cmbgender": cmbgender,
    "txtfullname": txtfullname,
    "txtschoolname": txtschoolname.toString(),
    "cmbcountry": cmbcountry,
    "txtaboutme": txtaboutme.toString(),
    "userid": userid,
    "txtphonenumber": txtphonenumber,
  };
}
