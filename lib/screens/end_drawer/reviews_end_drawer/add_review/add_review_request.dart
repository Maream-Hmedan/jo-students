import 'dart:convert';

class AddMyReviewsListRequest {
  int userid;
  String txtname;
  String txtdescription;

  AddMyReviewsListRequest({
    required this.userid,
    required this.txtname,
    required this.txtdescription,
  });

  AddMyReviewsListRequest copyWith({
    int? userid,
    String? txtname,
    String? txtdescription,
  }) =>
      AddMyReviewsListRequest(
        userid: userid ?? this.userid,
        txtname: txtname ?? this.txtname,
        txtdescription: txtdescription ?? this.txtdescription,
      );

  factory AddMyReviewsListRequest.fromRawJson(String str) => AddMyReviewsListRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddMyReviewsListRequest.fromJson(Map<String, dynamic> json) => AddMyReviewsListRequest(
    userid: json["userid"],
    txtname: json["txtname"],
    txtdescription: json["txtdescription"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "txtname": txtname,
    "txtdescription": txtdescription,
  };
}
