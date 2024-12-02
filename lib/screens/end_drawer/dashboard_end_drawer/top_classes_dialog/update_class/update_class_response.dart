import 'dart:convert';

class UpdateClassResponse {
  int status;
  String msg;

  UpdateClassResponse({
    required this.status,
    required this.msg,
  });

  UpdateClassResponse copyWith({
    int? status,
    String? msg,
  }) =>
      UpdateClassResponse(
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory UpdateClassResponse.fromRawJson(String str) => UpdateClassResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateClassResponse.fromJson(Map<String, dynamic> json) => UpdateClassResponse(
    status: json["Status"],
    msg: json["Msg"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Msg": msg,
  };
}
