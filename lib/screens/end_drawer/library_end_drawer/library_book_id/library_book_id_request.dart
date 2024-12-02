import 'dart:convert';

class LibraryBookIdRequest {
  int libraryBookId;

  LibraryBookIdRequest({
    required this.libraryBookId,
  });

  LibraryBookIdRequest copyWith({
    int? libraryBookId,
  }) =>
      LibraryBookIdRequest(
        libraryBookId: libraryBookId ?? this.libraryBookId,
      );

  factory LibraryBookIdRequest.fromRawJson(String str) => LibraryBookIdRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LibraryBookIdRequest.fromJson(Map<String, dynamic> json) => LibraryBookIdRequest(
    libraryBookId: json["Library_BookID"],
  );

  Map<String, dynamic> toJson() => {
    "Library_BookID": libraryBookId,
  };
}
