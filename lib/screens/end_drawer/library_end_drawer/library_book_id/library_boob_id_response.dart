import 'dart:convert';

class LibraryBookIdResponse {
  int libraryBookId;
  String libraryBookThumpnailMobile;
  String libraryBookDt;
  String libraryBookPdfFile;
  String libraryBookPagesNo;
  String libraryBookThumpnail;
  String libraryBookDesc;
  String libraryBookPdfFileMobile;
  String libraryBookTitle;
  String libraryCatId;
  String libraryBookAuthor;

  LibraryBookIdResponse({
    required this.libraryBookId,
    required this.libraryBookThumpnailMobile,
    required this.libraryBookDt,
    required this.libraryBookPdfFile,
    required this.libraryBookPagesNo,
    required this.libraryBookThumpnail,
    required this.libraryBookDesc,
    required this.libraryBookPdfFileMobile,
    required this.libraryBookTitle,
    required this.libraryCatId,
    required this.libraryBookAuthor,
  });

  LibraryBookIdResponse copyWith({
    int? libraryBookId,
    String? libraryBookThumpnailMobile,
    String? libraryBookDt,
    String? libraryBookPdfFile,
    String? libraryBookPagesNo,
    String? libraryBookThumpnail,
    String? libraryBookDesc,
    String? libraryBookPdfFileMobile,
    String? libraryBookTitle,
    String? libraryCatId,
    String? libraryBookAuthor,
  }) =>
      LibraryBookIdResponse(
        libraryBookId: libraryBookId ?? this.libraryBookId,
        libraryBookThumpnailMobile: libraryBookThumpnailMobile ?? this.libraryBookThumpnailMobile,
        libraryBookDt: libraryBookDt ?? this.libraryBookDt,
        libraryBookPdfFile: libraryBookPdfFile ?? this.libraryBookPdfFile,
        libraryBookPagesNo: libraryBookPagesNo ?? this.libraryBookPagesNo,
        libraryBookThumpnail: libraryBookThumpnail ?? this.libraryBookThumpnail,
        libraryBookDesc: libraryBookDesc ?? this.libraryBookDesc,
        libraryBookPdfFileMobile: libraryBookPdfFileMobile ?? this.libraryBookPdfFileMobile,
        libraryBookTitle: libraryBookTitle ?? this.libraryBookTitle,
        libraryCatId: libraryCatId ?? this.libraryCatId,
        libraryBookAuthor: libraryBookAuthor ?? this.libraryBookAuthor,
      );

  factory LibraryBookIdResponse.fromRawJson(String str) => LibraryBookIdResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LibraryBookIdResponse.fromJson(Map<String, dynamic> json) => LibraryBookIdResponse(
    libraryBookId: json["Library_BookID"],
    libraryBookThumpnailMobile: json["Library_Book_Thumpnail_Mobile"],
    libraryBookDt: json["Library_Book_DT"],
    libraryBookPdfFile: json["Library_Book_PDFFile"],
    libraryBookPagesNo: json["Library_Book_PagesNo"],
    libraryBookThumpnail: json["Library_Book_Thumpnail"],
    libraryBookDesc: json["Library_Book_Desc"],
    libraryBookPdfFileMobile: json["Library_Book_PDFFile_Mobile"],
    libraryBookTitle: json["Library_BookTitle"],
    libraryCatId: json["Library_CatID"],
    libraryBookAuthor: json["Library_Book_Author"],
  );

  Map<String, dynamic> toJson() => {
    "Library_BookID": libraryBookId,
    "Library_Book_Thumpnail_Mobile": libraryBookThumpnailMobile,
    "Library_Book_DT": libraryBookDt,
    "Library_Book_PDFFile": libraryBookPdfFile,
    "Library_Book_PagesNo": libraryBookPagesNo,
    "Library_Book_Thumpnail": libraryBookThumpnail,
    "Library_Book_Desc": libraryBookDesc,
    "Library_Book_PDFFile_Mobile": libraryBookPdfFileMobile,
    "Library_BookTitle": libraryBookTitle,
    "Library_CatID": libraryCatId,
    "Library_Book_Author": libraryBookAuthor,
  };
}
