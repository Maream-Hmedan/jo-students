import 'dart:convert';

class MyReviewsListResponse {
  String listHDescription;
  String createdDt;
  String booksCount;
  int listHId;
  String listHTitle;
  String studentId;

  MyReviewsListResponse({
    required this.listHDescription,
    required this.createdDt,
    required this.booksCount,
    required this.listHId,
    required this.listHTitle,
    required this.studentId,
  });

  MyReviewsListResponse copyWith({
    String? listHDescription,
    String? createdDt,
    String? booksCount,
    int? listHId,
    String? listHTitle,
    String? studentId,
  }) =>
      MyReviewsListResponse(
        listHDescription: listHDescription ?? this.listHDescription,
        createdDt: createdDt ?? this.createdDt,
        booksCount: booksCount ?? this.booksCount,
        listHId: listHId ?? this.listHId,
        listHTitle: listHTitle ?? this.listHTitle,
        studentId: studentId ?? this.studentId,
      );

  factory MyReviewsListResponse.fromRawJson(String str) => MyReviewsListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyReviewsListResponse.fromJson(Map<String, dynamic> json) => MyReviewsListResponse(
    listHDescription: json["ListH_Description"]??"",
    createdDt: json["CreatedDT"]??"",
    booksCount: json["books_count"]??"",
    listHId: json["ListH_ID"]??"",
    listHTitle: json["ListH_Title"]??"",
    studentId: json["StudentID"]??"",
  );

  Map<String, dynamic> toJson() => {
    "ListH_Description": listHDescription,
    "CreatedDT": createdDt,
    "books_count": booksCount,
    "ListH_ID": listHId,
    "ListH_Title": listHTitle,
    "StudentID": studentId,
  };
}
