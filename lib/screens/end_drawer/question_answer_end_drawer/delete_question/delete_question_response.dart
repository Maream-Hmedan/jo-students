import 'dart:convert';

class DeleteQuestionResponse {
  int status;
  String msg;

  DeleteQuestionResponse({
    required this.status,
    required this.msg,
  });

  DeleteQuestionResponse copyWith({
    int? status,
    String? msg,
  }) =>
      DeleteQuestionResponse(
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory DeleteQuestionResponse.fromRawJson(String str) => DeleteQuestionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteQuestionResponse.fromJson(Map<String, dynamic> json) => DeleteQuestionResponse(
    status: json["Status"],
    msg: json["Msg"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Msg": msg,
  };
}
