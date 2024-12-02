import 'dart:convert';

List<ClassesResponse> classesResponseFromJson(String str) =>
    List<ClassesResponse>.from(
        json.decode(str).map((x) => ClassesResponse.fromJson(x)));

String classesResponseToJson(List<ClassesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassesResponse {
  String classTitle;
  String classNumber;
  int classId;
  String classTitleAr;

  ClassesResponse({
    required this.classTitle,
    required this.classNumber,
    required this.classId,
    required this.classTitleAr,
  });

  factory ClassesResponse.fromJson(Map<String, dynamic> json) =>
      ClassesResponse(
        classTitle: json["Class_Title"],
        classNumber: json["ClassNumber"],
        classId: json["ClassID"],
        classTitleAr: json["Class_Title_Ar"],
      );

  Map<String, dynamic> toJson() => {
        "Class_Title": classTitle,
        "ClassNumber": classNumber,
        "ClassID": classId,
        "Class_Title_Ar": classTitleAr,
      };
}
