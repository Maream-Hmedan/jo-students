import 'dart:convert';

CheckUserRequest checkUserRequestFromJson(String str) => CheckUserRequest.fromJson(json.decode(str));

String checkUserRequestToJson(CheckUserRequest data) => json.encode(data.toJson());

class CheckUserRequest {
  String loginTrx;

  CheckUserRequest({
    required this.loginTrx,
  });

  factory CheckUserRequest.fromJson(Map<String, dynamic> json) => CheckUserRequest(
    loginTrx: json["LoginTrx"],
  );

  Map<String, dynamic> toJson() => {
    "LoginTrx": loginTrx,
  };
}