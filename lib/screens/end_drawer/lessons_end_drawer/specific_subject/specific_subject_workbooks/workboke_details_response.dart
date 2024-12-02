import 'dart:convert';

class WorkBookDetailsResponse {
  String subjectTitle;
  String semesterTitleAr;
  String bookDescription;
  int isWorkbook;
  String semesterTitle;
  String classTitle;
  String bookTitle;
  String numberOfOtherBooks;
  String subjectTitleAr;
  String addedDt;
  String classTitleAr;
  String tFullName;

  WorkBookDetailsResponse({
    required this.subjectTitle,
    required this.semesterTitleAr,
    required this.bookDescription,
    required this.isWorkbook,
    required this.semesterTitle,
    required this.classTitle,
    required this.bookTitle,
    required this.numberOfOtherBooks,
    required this.subjectTitleAr,
    required this.addedDt,
    required this.classTitleAr,
    required this.tFullName,
  });

  WorkBookDetailsResponse copyWith({
    String? subjectTitle,
    String? semesterTitleAr,
    String? bookDescription,
    int? isWorkbook,
    String? semesterTitle,
    String? classTitle,
    String? bookTitle,
    String? numberOfOtherBooks,
    String? subjectTitleAr,
    String? addedDt,
    String? classTitleAr,
    String? tFullName,
  }) =>
      WorkBookDetailsResponse(
        subjectTitle: subjectTitle ?? this.subjectTitle,
        semesterTitleAr: semesterTitleAr ?? this.semesterTitleAr,
        bookDescription: bookDescription ?? this.bookDescription,
        isWorkbook: isWorkbook ?? this.isWorkbook,
        semesterTitle: semesterTitle ?? this.semesterTitle,
        classTitle: classTitle ?? this.classTitle,
        bookTitle: bookTitle ?? this.bookTitle,
        numberOfOtherBooks: numberOfOtherBooks ?? this.numberOfOtherBooks,
        subjectTitleAr: subjectTitleAr ?? this.subjectTitleAr,
        addedDt: addedDt ?? this.addedDt,
        classTitleAr: classTitleAr ?? this.classTitleAr,
        tFullName: tFullName ?? this.tFullName,
      );

  factory WorkBookDetailsResponse.fromRawJson(String str) => WorkBookDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkBookDetailsResponse.fromJson(Map<String, dynamic> json) => WorkBookDetailsResponse(
    subjectTitle: json["Subject_Title"],
    semesterTitleAr: json["Semester_Title_Ar"],
    bookDescription: json["Book_Description"],
    isWorkbook: json["Is_Workbook"],
    semesterTitle: json["Semester_Title"],
    classTitle: json["Class_Title"],
    bookTitle: json["Book_Title"],
    numberOfOtherBooks: json["Number_of_Other_Books"],
    subjectTitleAr: json["Subject_Title_Ar"],
    addedDt: json["AddedDT"],
    classTitleAr: json["Class_Title_Ar"],
    tFullName: json["t_FullName"],
  );

  Map<String, dynamic> toJson() => {
    "Subject_Title": subjectTitle,
    "Semester_Title_Ar": semesterTitleAr,
    "Book_Description": bookDescription,
    "Is_Workbook": isWorkbook,
    "Semester_Title": semesterTitle,
    "Class_Title": classTitle,
    "Book_Title": bookTitle,
    "Number_of_Other_Books": numberOfOtherBooks,
    "Subject_Title_Ar": subjectTitleAr,
    "AddedDT": addedDt,
    "Class_Title_Ar": classTitleAr,
    "t_FullName": tFullName,
  };
}
