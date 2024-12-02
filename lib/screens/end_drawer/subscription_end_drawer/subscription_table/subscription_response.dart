import 'dart:convert';

class SubscriptionResponse {
  String systemSemesterTitleAr;
  String subYear;
  String subjectTitleAr;
  String classTitleAr;
  String cardCode;
  int subjectId;
  int studentSubId;
  String subDt;

  SubscriptionResponse({
    required this.systemSemesterTitleAr,
    required this.subYear,
    required this.subjectTitleAr,
    required this.classTitleAr,
    required this.cardCode,
    required this.subjectId,
    required this.studentSubId,
    required this.subDt,
  });

  SubscriptionResponse copyWith({
    String? systemSemesterTitleAr,
    String? subYear,
    String? subjectTitleAr,
    String? classTitleAr,
    String? cardCode,
    int? subjectId,
    int? studentSubId,
    String? subDt,
  }) =>
      SubscriptionResponse(
        systemSemesterTitleAr: systemSemesterTitleAr ?? this.systemSemesterTitleAr,
        subYear: subYear ?? this.subYear,
        subjectTitleAr: subjectTitleAr ?? this.subjectTitleAr,
        classTitleAr: classTitleAr ?? this.classTitleAr,
        cardCode: cardCode ?? this.cardCode,
        subjectId: subjectId ?? this.subjectId,
        studentSubId: studentSubId ?? this.studentSubId,
        subDt: subDt ?? this.subDt,
      );

  factory SubscriptionResponse.fromRawJson(String str) => SubscriptionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) => SubscriptionResponse(
    systemSemesterTitleAr: json["System_Semester_Title_Ar"]??'',
    subYear: json["Sub_year"]??'',
    subjectTitleAr: json["Subject_Title_Ar"]??'',
    classTitleAr: json["Class_Title_Ar"]??'',
    cardCode: json["Card_Code"]??'',
    subjectId: json["SubjectID"]??'',
    studentSubId: json["Student_SubID"]??'',
    subDt: json["Sub_DT"]??'',
  );

  Map<String, dynamic> toJson() => {
    "System_Semester_Title_Ar": systemSemesterTitleAr,
    "Sub_year": subYear,
    "Subject_Title_Ar": subjectTitleAr,
    "Class_Title_Ar": classTitleAr,
    "Card_Code": cardCode,
    "SubjectID": subjectId,
    "Student_SubID": studentSubId,
    "Sub_DT": subDt,
  };
}
