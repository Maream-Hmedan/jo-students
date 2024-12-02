import 'dart:convert';

class UpdateMySettingsResponse {
  int status;
  String msg;

  UpdateMySettingsResponse({
    required this.status,
    required this.msg,
  });

  UpdateMySettingsResponse copyWith({
    int? status,
    String? msg,
  }) =>
      UpdateMySettingsResponse(
        status: status ?? this.status,
        msg: msg ?? this.msg,
      );

  factory UpdateMySettingsResponse.fromRawJson(String str) => UpdateMySettingsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateMySettingsResponse.fromJson(Map<String, dynamic> json) => UpdateMySettingsResponse(
    status: json["Status"],
    msg: json["Msg"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Msg": msg,
  };
}
