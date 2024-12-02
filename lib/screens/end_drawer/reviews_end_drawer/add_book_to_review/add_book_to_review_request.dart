import 'dart:convert';

class AddBookToListRequest {
  int bookId;
  int listId;

  AddBookToListRequest({
    required this.bookId,
    required this.listId,
  });

  AddBookToListRequest copyWith({
    int? bookId,
    int? listId,
  }) =>
      AddBookToListRequest(
        bookId: bookId ?? this.bookId,
        listId: listId ?? this.listId,
      );

  factory AddBookToListRequest.fromRawJson(String str) => AddBookToListRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddBookToListRequest.fromJson(Map<String, dynamic> json) => AddBookToListRequest(
    bookId: json["BookID"],
    listId: json["ListID"],
  );

  Map<String, dynamic> toJson() => {
    "BookID": bookId,
    "ListID": listId,
  };
}
