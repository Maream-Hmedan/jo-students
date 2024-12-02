import 'dart:convert';

class BooksVideoResponse {
  String bookId;
  String bookTitle;

  BooksVideoResponse({
    required this.bookId,
    required this.bookTitle,
  });

  BooksVideoResponse copyWith({
    String? bookId,
    String? bookTitle,
  }) =>
      BooksVideoResponse(
        bookId: bookId ?? this.bookId,
        bookTitle: bookTitle ?? this.bookTitle,
      );

  factory BooksVideoResponse.fromRawJson(String str) => BooksVideoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksVideoResponse.fromJson(Map<String, dynamic> json) => BooksVideoResponse(
    bookId: json["BookID"]??"",
    bookTitle: json["Book_Title"]??"",
  );

  Map<String, dynamic> toJson() => {
    "BookID": bookId,
    "Book_Title": bookTitle,
  };
}
