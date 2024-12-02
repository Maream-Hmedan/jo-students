import 'dart:convert';

class DeleteReviewResponse {
  int status;
  String msg;

  DeleteReviewResponse({
    required this.status,
    required this.msg,
  });

  DeleteReviewResponse copyWith({
    int? status,
    String? msg,
  }) =>
      DeleteReviewResponse(
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory DeleteReviewResponse.fromRawJson(String str) => DeleteReviewResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteReviewResponse.fromJson(Map<String, dynamic> json) => DeleteReviewResponse(
    status: json["Status"],
    msg: json["Msg"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Msg": msg,
  };
}
