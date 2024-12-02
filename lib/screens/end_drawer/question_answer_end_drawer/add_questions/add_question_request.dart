import 'dart:convert';

class AddQuestionRequest {
  int userid;
  int classid;
  int semesterId;
  int txtchkid;
  String txtMessage;

  AddQuestionRequest({
    required this.userid,
    required this.classid,
    required this.semesterId,
    required this.txtchkid,
    required this.txtMessage,
  });

  AddQuestionRequest copyWith({
    int? userid,
    int? classid,
    int? semesterId,
    int? txtchkid,
    String? txtMessage,
  }) =>
      AddQuestionRequest(
        userid: userid ?? this.userid,
        classid: classid ?? this.classid,
        semesterId: semesterId ?? this.semesterId,
        txtchkid: txtchkid ?? this.txtchkid,
        txtMessage: txtMessage ?? this.txtMessage,
      );

  factory AddQuestionRequest.fromRawJson(String str) => AddQuestionRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddQuestionRequest.fromJson(Map<String, dynamic> json) => AddQuestionRequest(
    userid: json["userid"],
    classid: json["classid"],
    semesterId: json["SemesterID"],
    txtchkid: json["txtchkid"],
    txtMessage: json["txtMessage"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "classid": classid,
    "SemesterID": semesterId,
    "txtchkid": txtchkid,
    "txtMessage": txtMessage,
  };
}
