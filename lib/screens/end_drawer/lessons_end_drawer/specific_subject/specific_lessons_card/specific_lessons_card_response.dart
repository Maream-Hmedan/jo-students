import 'dart:convert';

class SpecificCardResponse {
  String semesterTitleAr;
  int isWorkbook;
  String bookTitle;
  String subjectTitle;
  String bookDescription;
  String semesterTitle;
  String bookDescriptionAndroid;
  String classTitle;
  String numberOfOtherBooks;
  String subjectTitleAr;
  String addedDt;
  String classTitleAr;
  String tFullName;

  SpecificCardResponse({
    required this.semesterTitleAr,
    required this.isWorkbook,
    required this.bookTitle,
    required this.subjectTitle,
    required this.bookDescription,
    required this.semesterTitle,
    required this.bookDescriptionAndroid,
    required this.classTitle,
    required this.numberOfOtherBooks,
    required this.subjectTitleAr,
    required this.addedDt,
    required this.classTitleAr,
    required this.tFullName,
  });

  SpecificCardResponse copyWith({
    String? semesterTitleAr,
    int? isWorkbook,
    String? bookTitle,
    String? subjectTitle,
    String? bookDescription,
    String? semesterTitle,
    String? bookDescriptionAndroid,
    String? classTitle,
    String? numberOfOtherBooks,
    String? subjectTitleAr,
    String? addedDt,
    String? classTitleAr,
    String? tFullName,
  }) =>
      SpecificCardResponse(
        semesterTitleAr: semesterTitleAr ?? this.semesterTitleAr,
        isWorkbook: isWorkbook ?? this.isWorkbook,
        bookTitle: bookTitle ?? this.bookTitle,
        subjectTitle: subjectTitle ?? this.subjectTitle,
        bookDescription: bookDescription ?? this.bookDescription,
        semesterTitle: semesterTitle ?? this.semesterTitle,
        bookDescriptionAndroid: bookDescriptionAndroid ?? this.bookDescriptionAndroid,
        classTitle: classTitle ?? this.classTitle,
        numberOfOtherBooks: numberOfOtherBooks ?? this.numberOfOtherBooks,
        subjectTitleAr: subjectTitleAr ?? this.subjectTitleAr,
        addedDt: addedDt ?? this.addedDt,
        classTitleAr: classTitleAr ?? this.classTitleAr,
        tFullName: tFullName ?? this.tFullName,
      );

  factory SpecificCardResponse.fromRawJson(String str) => SpecificCardResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpecificCardResponse.fromJson(Map<String, dynamic> json) => SpecificCardResponse(
    semesterTitleAr: json["Semester_Title_Ar"]??"",
    isWorkbook: json["Is_Workbook"]??"",
    bookTitle: json["Book_Title"]??"",
    subjectTitle: json["Subject_Title"]??"",
    bookDescription: json["Book_Description"]??"",
    semesterTitle: json["Semester_Title"]??"",
    bookDescriptionAndroid: json["Book_Description_Android"]??"",
    classTitle: json["Class_Title"]??"",
    numberOfOtherBooks: json["Number_of_Other_Books"]??"",
    subjectTitleAr: json["Subject_Title_Ar"]??"",
    addedDt: json["AddedDT"]??"",
    classTitleAr: json["Class_Title_Ar"]??"",
    tFullName: json["t_FullName"]??"",
  );

  Map<String, dynamic> toJson() => {
    "Semester_Title_Ar": semesterTitleAr,
    "Is_Workbook": isWorkbook,
    "Book_Title": bookTitle,
    "Subject_Title": subjectTitle,
    "Book_Description": bookDescription,
    "Semester_Title": semesterTitle,
    "Book_Description_Android": bookDescriptionAndroid,
    "Class_Title": classTitle,
    "Number_of_Other_Books": numberOfOtherBooks,
    "Subject_Title_Ar": subjectTitleAr,
    "AddedDT": addedDt,
    "Class_Title_Ar": classTitleAr,
    "t_FullName": tFullName,
  };
}
