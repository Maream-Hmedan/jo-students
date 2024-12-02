import 'dart:convert';

class BooksBySubjectIdResponse {
  String bookId;
  String bookTitle;
  int isVideo;

  BooksBySubjectIdResponse({
    required this.bookId,
    required this.bookTitle,
    required this.isVideo,
  });

  BooksBySubjectIdResponse copyWith({
    String? bookId,
    String? bookTitle,
    int? isVideo,
  }) =>
      BooksBySubjectIdResponse(
        bookId: bookId ?? this.bookId,
        bookTitle: bookTitle ?? this.bookTitle,
        isVideo: isVideo ?? this.isVideo,
      );

  factory BooksBySubjectIdResponse.fromRawJson(String str) => BooksBySubjectIdResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksBySubjectIdResponse.fromJson(Map<String, dynamic> json) => BooksBySubjectIdResponse(
    bookId: json["BookID"]??"",
    bookTitle: json["Book_Title"]??"",
    isVideo: json["is_Video"],
  );

  Map<String, dynamic> toJson() => {
    "BookID": bookId,
    "Book_Title": bookTitle,
    "is_Video": isVideo,
  };
}
