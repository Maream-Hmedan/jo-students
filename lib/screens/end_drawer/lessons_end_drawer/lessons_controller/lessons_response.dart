import 'dart:convert';

class SubjectByIdResponse {
  String subjectTitle;
  String msg;
  String subjectColor;
  String subjectTitleAr;
  String tProfilePic;
  String subjectIconHref;
  String subjectIcon;
  String tFullName;

  SubjectByIdResponse({
    required this.subjectTitle,
    required this.msg,
    required this.subjectColor,
    required this.subjectTitleAr,
    required this.tProfilePic,
    required this.subjectIconHref,
    required this.subjectIcon,
    required this.tFullName,
  });

  SubjectByIdResponse copyWith({
    String? subjectTitle,
    String? msg,
    String? subjectColor,
    String? subjectTitleAr,
    String? tProfilePic,
    String? subjectIconHref,
    String? subjectIcon,
    String? tFullName,
  }) =>
      SubjectByIdResponse(
        subjectTitle: subjectTitle ?? this.subjectTitle,
        msg: msg ?? this.msg,
        subjectColor: subjectColor ?? this.subjectColor,
        subjectTitleAr: subjectTitleAr ?? this.subjectTitleAr,
        tProfilePic: tProfilePic ?? this.tProfilePic,
        subjectIconHref: subjectIconHref ?? this.subjectIconHref,
        subjectIcon: subjectIcon ?? this.subjectIcon,
        tFullName: tFullName ?? this.tFullName,
      );

  factory SubjectByIdResponse.fromRawJson(String str) => SubjectByIdResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubjectByIdResponse.fromJson(Map<String, dynamic> json) => SubjectByIdResponse(
    subjectTitle: json["Subject_Title"] ?? '',
    msg: json["Msg"] ?? '',
    subjectColor: json["Subject_Color"] ?? '',
    subjectTitleAr: json["Subject_Title_Ar"] ?? '',
    tProfilePic: json["t_ProfilePic"] ?? '',
    subjectIconHref: json["Subject_Icon_Href"] ?? '',
    subjectIcon: json["Subject_Icon"] ?? '',
    tFullName: json["t_FullName"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "Subject_Title": subjectTitle,
    "Msg": msg,
    "Subject_Color": subjectColor,
    "Subject_Title_Ar": subjectTitleAr,
    "t_ProfilePic": tProfilePic,
    "Subject_Icon_Href": subjectIconHref,
    "Subject_Icon": subjectIcon,
    "t_FullName": tFullName,
  };
}
