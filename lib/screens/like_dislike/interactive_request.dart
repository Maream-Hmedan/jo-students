import 'dart:convert';

class InterActiveRequest {
  int userid;
  int bookId;

  InterActiveRequest({
    required this.userid,
    required this.bookId,
  });

  InterActiveRequest copyWith({
    int? userid,
    int? bookId,
  }) =>
      InterActiveRequest(
        userid: userid ?? this.userid,
        bookId: bookId ?? this.bookId,
      );

  factory InterActiveRequest.fromRawJson(String str) => InterActiveRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InterActiveRequest.fromJson(Map<String, dynamic> json) => InterActiveRequest(
    userid: json["userid"],
    bookId: json["BookID"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "BookID": bookId,
  };
}
