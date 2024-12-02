import 'dart:convert';

class SubjectByIdRequest {
  int subjectId;

  SubjectByIdRequest({
    required this.subjectId,
  });

  SubjectByIdRequest copyWith({
    int? subjectId,
  }) =>
      SubjectByIdRequest(
        subjectId: subjectId ?? this.subjectId,
      );

  factory SubjectByIdRequest.fromRawJson(String str) => SubjectByIdRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubjectByIdRequest.fromJson(Map<String, dynamic> json) => SubjectByIdRequest(
    subjectId: json["SubjectID"],
  );

  Map<String, dynamic> toJson() => {
    "SubjectID": subjectId,
  };
}
