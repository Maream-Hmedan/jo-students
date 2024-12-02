import 'dart:convert';

class SpecificCardRequest {
  int bookId;
  int semesterId;
  int classId;
  int subjectId;

  SpecificCardRequest({
    required this.bookId,
    required this.semesterId,
    required this.classId,
    required this.subjectId,
  });

  SpecificCardRequest copyWith({
    int? bookId,
    int? semesterId,
    int? classId,
    int? subjectId,
  }) =>
      SpecificCardRequest(
        bookId: bookId ?? this.bookId,
        semesterId: semesterId ?? this.semesterId,
        classId: classId ?? this.classId,
        subjectId: subjectId ?? this.subjectId,
      );

  factory SpecificCardRequest.fromRawJson(String str) => SpecificCardRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpecificCardRequest.fromJson(Map<String, dynamic> json) => SpecificCardRequest(
    bookId: json["BookID"],
    semesterId: json["SemesterID"],
    classId: json["ClassID"],
    subjectId: json["SubjectID"],
  );

  Map<String, dynamic> toJson() => {
    "BookID": bookId,
    "SemesterID": semesterId,
    "ClassID": classId,
    "SubjectID": subjectId,
  };
}
