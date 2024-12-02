import 'dart:convert';

class SubscriptionRequest {
  int userid;

  SubscriptionRequest({
    required this.userid,
  });

  SubscriptionRequest copyWith({
    int? userid,
  }) =>
      SubscriptionRequest(
        userid: userid ?? this.userid,
      );

  factory SubscriptionRequest.fromRawJson(String str) => SubscriptionRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubscriptionRequest.fromJson(Map<String, dynamic> json) => SubscriptionRequest(
    userid: json["userid"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
  };
}
