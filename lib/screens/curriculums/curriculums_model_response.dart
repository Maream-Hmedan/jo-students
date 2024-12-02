import 'dart:convert';

class CurriculumsModelResponse {
  String subjectTitle;
  String semesterId;
  String subjectColor;
  String subjectTitleAr;
  int classId;
  String subjectIconHref;
  int subjectId;
  String subjectIcon;

  CurriculumsModelResponse({
    required this.subjectTitle,
    required this.semesterId,
    required this.subjectColor,
    required this.subjectTitleAr,
    required this.classId,
    required this.subjectIconHref,
    required this.subjectId,
    required this.subjectIcon,
  });

  factory CurriculumsModelResponse.fromRawJson(String str) => CurriculumsModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurriculumsModelResponse.fromJson(Map<String, dynamic> json) => CurriculumsModelResponse(
    subjectTitle: json["Subject_Title"] ?? '',
    semesterId: json["SemesterID"] ?? '',
    subjectColor: json["Subject_Color"] ?? '',
    subjectTitleAr: json["Subject_Title_Ar"] ?? '',
    classId: json["ClassID"] ?? 0,
    subjectIconHref: json["Subject_Icon_Href"] ?? '',
    subjectId: json["SubjectID"] ?? 0,
    subjectIcon: json["Subject_Icon"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "Subject_Title": subjectTitle,
    "SemesterID": semesterId,
    "Subject_Color": subjectColor,
    "Subject_Title_Ar": subjectTitleAr,
    "ClassID": classId,
    "Subject_Icon_Href": subjectIconHref,
    "SubjectID": subjectId,
    "Subject_Icon": subjectIcon,
  };
}
