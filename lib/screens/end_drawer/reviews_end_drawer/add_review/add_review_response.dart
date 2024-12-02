import 'dart:convert';

class AddMyReviewsListResponse {
  int status;
  String msg;

  AddMyReviewsListResponse({
    required this.status,
    required this.msg,
  });

  AddMyReviewsListResponse copyWith({
    int? status,
    String? msg,
  }) =>
      AddMyReviewsListResponse(
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory AddMyReviewsListResponse.fromRawJson(String str) => AddMyReviewsListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddMyReviewsListResponse.fromJson(Map<String, dynamic> json) => AddMyReviewsListResponse(
    status: json["Status"],
    msg: json["Msg"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Msg": msg,
  };
}
