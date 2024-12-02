import 'dart:convert';

class DeleteReviewRequest {
  int userid;
  int txtqid;

  DeleteReviewRequest({
    required this.userid,
    required this.txtqid,
  });

  DeleteReviewRequest copyWith({
    int? userid,
    int? txtqid,
  }) =>
      DeleteReviewRequest(
        userid: userid ?? this.userid,
        txtqid: txtqid ?? this.txtqid,
      );

  factory DeleteReviewRequest.fromRawJson(String str) => DeleteReviewRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteReviewRequest.fromJson(Map<String, dynamic> json) => DeleteReviewRequest(
    userid: json["userid"],
    txtqid: json["txtqid"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "txtqid": txtqid,
  };
}
