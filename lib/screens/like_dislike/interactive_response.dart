import 'dart:convert';

class InterActiveResponse {
  String msg;
  int status;

  InterActiveResponse({
    required this.msg,
    required this.status,
  });

  InterActiveResponse copyWith({
    String? msg,
    int? status,
  }) =>
      InterActiveResponse(
        msg: msg ?? this.msg,
        status: status ?? this.status,
      );

  factory InterActiveResponse.fromRawJson(String str) => InterActiveResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InterActiveResponse.fromJson(Map<String, dynamic> json) => InterActiveResponse(
    msg: json["Msg"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Msg": msg,
    "Status": status,
  };
}
