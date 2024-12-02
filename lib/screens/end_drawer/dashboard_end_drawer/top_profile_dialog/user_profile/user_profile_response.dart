import 'dart:convert';

class UpdateProfileResponse {
  String msg;
  int status;

  UpdateProfileResponse({
    required this.msg,
    required this.status,
  });

  UpdateProfileResponse copyWith({
    String? msg,
    int? status,
  }) =>
      UpdateProfileResponse(
        msg: msg ?? this.msg,
        status: status ?? this.status,
      );

  factory UpdateProfileResponse.fromRawJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
    msg: json["Msg"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Msg": msg,
    "Status": status,
  };
}
