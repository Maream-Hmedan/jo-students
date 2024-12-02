import 'dart:convert';

class ReviewDetailsResponse {
  String listHDescription;
  int listDId;
  String bookId;
  String bookTitle;
  int listHId;
  String listHTitle;
  String subjectId;

  ReviewDetailsResponse({
    required this.listHDescription,
    required this.listDId,
    required this.bookId,
    required this.bookTitle,
    required this.listHId,
    required this.listHTitle,
    required this.subjectId,
  });

  ReviewDetailsResponse copyWith({
    String? listHDescription,
    int? listDId,
    String? bookId,
    String? bookTitle,
    int? listHId,
    String? listHTitle,
    String? subjectId,
  }) =>
      ReviewDetailsResponse(
        listHDescription: listHDescription ?? this.listHDescription,
        listDId: listDId ?? this.listDId,
        bookId: bookId ?? this.bookId,
        bookTitle: bookTitle ?? this.bookTitle,
        listHId: listHId ?? this.listHId,
        listHTitle: listHTitle ?? this.listHTitle,
        subjectId: subjectId ?? this.subjectId,
      );

  factory ReviewDetailsResponse.fromRawJson(String str) => ReviewDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewDetailsResponse.fromJson(Map<String, dynamic> json) => ReviewDetailsResponse(
    listHDescription: json["ListH_Description"],
    listDId: json["ListD_ID"],
    bookId: json["BookID"],
    bookTitle: json["Book_Title"],
    listHId: json["ListH_ID"],
    listHTitle: json["ListH_Title"],
    subjectId: json["SubjectID"],
  );

  Map<String, dynamic> toJson() => {
    "ListH_Description": listHDescription,
    "ListD_ID": listDId,
    "BookID": bookId,
    "Book_Title": bookTitle,
    "ListH_ID": listHId,
    "ListH_Title": listHTitle,
    "SubjectID": subjectId,
  };
}
