import 'dart:convert';

class LibraryResponse {
  String libraryCatTitle;
  List<Book> books;
  int booksNumber;
  int libraryCatId;

  LibraryResponse({
    required this.libraryCatTitle,
    required this.books,
    required this.booksNumber,
    required this.libraryCatId,
  });

  LibraryResponse copyWith({
    String? libraryCatTitle,
    List<Book>? books,
    int? booksNumber,
    int? libraryCatId,
  }) =>
      LibraryResponse(
        libraryCatTitle: libraryCatTitle ?? this.libraryCatTitle,
        books: books ?? this.books,
        booksNumber: booksNumber ?? this.booksNumber,
        libraryCatId: libraryCatId ?? this.libraryCatId,
      );

  factory LibraryResponse.fromRawJson(String str) => LibraryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LibraryResponse.fromJson(Map<String, dynamic> json) => LibraryResponse(
    libraryCatTitle: json["Library_Cat_Title"],
    books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
    booksNumber: json["books_number"],
    libraryCatId: json["Library_CatID"],
  );

  Map<String, dynamic> toJson() => {
    "Library_Cat_Title": libraryCatTitle,
    "books": List<dynamic>.from(books.map((x) => x.toJson())),
    "books_number": booksNumber,
    "Library_CatID": libraryCatId,
  };
}

class Book {
  int libraryBookId;
  String libraryBookThumpnailMobile;
  String libraryBookThumpnail;
  String libraryBookTitle;

  Book({
    required this.libraryBookId,
    required this.libraryBookThumpnailMobile,
    required this.libraryBookThumpnail,
    required this.libraryBookTitle,
  });

  Book copyWith({
    int? libraryBookId,
    String? libraryBookThumpnailMobile,
    String? libraryBookThumpnail,
    String? libraryBookTitle,
  }) =>
      Book(
        libraryBookId: libraryBookId ?? this.libraryBookId,
        libraryBookThumpnailMobile: libraryBookThumpnailMobile ?? this.libraryBookThumpnailMobile,
        libraryBookThumpnail: libraryBookThumpnail ?? this.libraryBookThumpnail,
        libraryBookTitle: libraryBookTitle ?? this.libraryBookTitle,
      );

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    libraryBookId: json["Library_BookID"],
    libraryBookThumpnailMobile: json["Library_Book_Thumpnail_Mobile"],
    libraryBookThumpnail: json["Library_Book_Thumpnail"],
    libraryBookTitle: json["Library_BookTitle"],
  );

  Map<String, dynamic> toJson() => {
    "Library_BookID": libraryBookId,
    "Library_Book_Thumpnail_Mobile": libraryBookThumpnailMobile,
    "Library_Book_Thumpnail": libraryBookThumpnail,
    "Library_BookTitle": libraryBookTitle,
  };
}
