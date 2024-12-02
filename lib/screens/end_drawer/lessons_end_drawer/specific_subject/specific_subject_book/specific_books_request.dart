import 'dart:convert';

class BooksBySubjectIdRequest {
  int subjectId;
  int semesterId;
  int classId;

  BooksBySubjectIdRequest({
    required this.subjectId,
    required this.semesterId,
    required this.classId,
  });

  BooksBySubjectIdRequest copyWith({
    int? subjectId,
    int? semesterId,
    int? classId,
  }) =>
      BooksBySubjectIdRequest(
        subjectId: subjectId ?? this.subjectId,
        semesterId: semesterId ?? this.semesterId,
        classId: classId ?? this.classId,
      );

  factory BooksBySubjectIdRequest.fromRawJson(String str) => BooksBySubjectIdRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksBySubjectIdRequest.fromJson(Map<String, dynamic> json) => BooksBySubjectIdRequest(
    subjectId: json["SubjectID"],
    semesterId: json["SemesterID"],
    classId: json["ClassID"],
  );

  Map<String, dynamic> toJson() => {
    "SubjectID": subjectId,
    "SemesterID": semesterId,
    "ClassID": classId,
  };
}
