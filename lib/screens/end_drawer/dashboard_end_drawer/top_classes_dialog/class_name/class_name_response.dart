import 'dart:convert';

class ClassNameResponse {
  String msg;
  String className;

  ClassNameResponse({
    required this.msg,
    required this.className,
  });

  ClassNameResponse copyWith({
    String? msg,
    String? className,
  }) =>
      ClassNameResponse(
        msg: msg ?? this.msg,
        className: className ?? this.className,
      );

  factory ClassNameResponse.fromRawJson(String str) => ClassNameResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClassNameResponse.fromJson(Map<String, dynamic> json) => ClassNameResponse(
    msg: json["Msg"],
    className: json["ClassName"],
  );

  Map<String, dynamic> toJson() => {
    "Msg": msg,
    "ClassName": className,
  };
}
