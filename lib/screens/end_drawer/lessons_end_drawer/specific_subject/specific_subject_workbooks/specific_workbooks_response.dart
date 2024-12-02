import 'dart:convert';

class WorkBooksResponse {
  String bookId;
  String bookTitle;

  WorkBooksResponse({
    required this.bookId,
    required this.bookTitle,
  });

  WorkBooksResponse copyWith({
    String? bookId,
    String? bookTitle,
  }) =>
      WorkBooksResponse(
        bookId: bookId ?? this.bookId,
        bookTitle: bookTitle ?? this.bookTitle,
      );

  factory WorkBooksResponse.fromRawJson(String str) => WorkBooksResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkBooksResponse.fromJson(Map<String, dynamic> json) => WorkBooksResponse(
    bookId: json["BookID"]??"",
    bookTitle: json["Book_Title"]??"",
  );

  Map<String, dynamic> toJson() => {
    "BookID": bookId,
    "Book_Title": bookTitle,
  };
}
