import 'dart:convert';

class AddBookToListResponse {
  int status;
  String msg;

  AddBookToListResponse({
    required this.status,
    required this.msg,
  });

  AddBookToListResponse copyWith({
    int? status,
    String? msg,
  }) =>
      AddBookToListResponse(
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory AddBookToListResponse.fromRawJson(String str) => AddBookToListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddBookToListResponse.fromJson(Map<String, dynamic> json) => AddBookToListResponse(
    status: json["Status"],
    msg: json["Msg"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Msg": msg,
  };
}
