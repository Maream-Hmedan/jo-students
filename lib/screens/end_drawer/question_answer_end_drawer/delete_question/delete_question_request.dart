import 'dart:convert';

class DeleteQuestionRequest {
  int txtqid;
  int userid;
  int classid;
  int semesterId;

  DeleteQuestionRequest({
    required this.txtqid,
    required this.userid,
    required this.classid,
    required this.semesterId,
  });

  DeleteQuestionRequest copyWith({
    int? txtqid,
    int? userid,
    int? classid,
    int? semesterId,
  }) =>
      DeleteQuestionRequest(
        txtqid: txtqid ?? this.txtqid,
        userid: userid ?? this.userid,
        classid: classid ?? this.classid,
        semesterId: semesterId ?? this.semesterId,
      );

  factory DeleteQuestionRequest.fromRawJson(String str) => DeleteQuestionRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteQuestionRequest.fromJson(Map<String, dynamic> json) => DeleteQuestionRequest(
    txtqid: json["txtqid"],
    userid: json["userid"],
    classid: json["classid"],
    semesterId: json["SemesterID"],
  );

  Map<String, dynamic> toJson() => {
    "txtqid": txtqid,
    "userid": userid,
    "classid": classid,
    "SemesterID": semesterId,
  };
}
