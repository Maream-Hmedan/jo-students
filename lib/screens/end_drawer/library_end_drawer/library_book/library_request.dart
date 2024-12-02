import 'dart:convert';

class LibraryRequest {
  int classid;

  LibraryRequest({
    required this.classid,
  });

  LibraryRequest copyWith({
    int? classid,
  }) =>
      LibraryRequest(
        classid: classid ?? this.classid,
      );

  factory LibraryRequest.fromRawJson(String str) => LibraryRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LibraryRequest.fromJson(Map<String, dynamic> json) => LibraryRequest(
    classid: json["classid"],
  );

  Map<String, dynamic> toJson() => {
    "classid": classid,
  };
}
