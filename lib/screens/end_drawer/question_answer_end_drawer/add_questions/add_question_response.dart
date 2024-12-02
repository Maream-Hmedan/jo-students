import 'dart:convert';

class AddQuestionResponse {
  int status;
  String msg;

  AddQuestionResponse({
    required this.status,
    required this.msg,
  });

  AddQuestionResponse copyWith({
    int? status,
    String? msg,
  }) =>
      AddQuestionResponse(
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory AddQuestionResponse.fromRawJson(String str) => AddQuestionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddQuestionResponse.fromJson(Map<String, dynamic> json) => AddQuestionResponse(
    status: json["Status"],
    msg: json["Msg"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Msg": msg,
  };
}
