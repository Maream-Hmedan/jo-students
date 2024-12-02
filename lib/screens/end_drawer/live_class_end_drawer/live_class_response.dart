import 'dart:convert';

class LiveClassResponse {
  String semesterTitleAr;
  String liveSubjectTitle;
  String semesterId;
  String classId;
  String timeOfLiveDt;
  String recordedLiveFileNameMp4;
  int liveSessionId;
  String subjectTitleAr;
  String recordedLiveFileName;
  String classTitleAr;
  String tProfilePic;
  String isLive;
  String subjectId;
  dynamic startedDt;
  String finishedDt;
  String tFullName;

  LiveClassResponse({
    required this.semesterTitleAr,
    required this.liveSubjectTitle,
    required this.semesterId,
    required this.classId,
    required this.timeOfLiveDt,
    required this.recordedLiveFileNameMp4,
    required this.liveSessionId,
    required this.subjectTitleAr,
    required this.recordedLiveFileName,
    required this.classTitleAr,
    required this.tProfilePic,
    required this.isLive,
    required this.subjectId,
    required this.startedDt,
    required this.finishedDt,
    required this.tFullName,
  });

  LiveClassResponse copyWith({
    String? semesterTitleAr,
    String? liveSubjectTitle,
    String? semesterId,
    String? classId,
    String? timeOfLiveDt,
    String? recordedLiveFileNameMp4,
    int? liveSessionId,
    String? subjectTitleAr,
    String? recordedLiveFileName,
    String? classTitleAr,
    String? tProfilePic,
    String? isLive,
    String? subjectId,
    dynamic startedDt,
    String? finishedDt,
    String? tFullName,
  }) =>
      LiveClassResponse(
        semesterTitleAr: semesterTitleAr ?? this.semesterTitleAr,
        liveSubjectTitle: liveSubjectTitle ?? this.liveSubjectTitle,
        semesterId: semesterId ?? this.semesterId,
        classId: classId ?? this.classId,
        timeOfLiveDt: timeOfLiveDt ?? this.timeOfLiveDt,
        recordedLiveFileNameMp4: recordedLiveFileNameMp4 ?? this.recordedLiveFileNameMp4,
        liveSessionId: liveSessionId ?? this.liveSessionId,
        subjectTitleAr: subjectTitleAr ?? this.subjectTitleAr,
        recordedLiveFileName: recordedLiveFileName ?? this.recordedLiveFileName,
        classTitleAr: classTitleAr ?? this.classTitleAr,
        tProfilePic: tProfilePic ?? this.tProfilePic,
        isLive: isLive ?? this.isLive,
        subjectId: subjectId ?? this.subjectId,
        startedDt: startedDt ?? this.startedDt,
        finishedDt: finishedDt ?? this.finishedDt,
        tFullName: tFullName ?? this.tFullName,
      );

  factory LiveClassResponse.fromRawJson(String str) => LiveClassResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LiveClassResponse.fromJson(Map<String, dynamic> json) => LiveClassResponse(
    semesterTitleAr: json["Semester_Title_Ar"]??"",
    liveSubjectTitle: json["Live_SubjectTitle"]??"",
    semesterId: json["SemesterID"]??"",
    classId: json["ClassID"]??"",
    timeOfLiveDt: json["Time_Of_Live_DT"]??"",
    recordedLiveFileNameMp4: json["Recorded_Live_FileName_Mp4"]??"",
    liveSessionId: json["LiveSessionID"]??"",
    subjectTitleAr: json["Subject_Title_Ar"]??"",
    recordedLiveFileName: json["Recorded_Live_FileName"]??"",
    classTitleAr: json["Class_Title_Ar"]??"",
    tProfilePic: json["t_ProfilePic"]??"",
    isLive: json["IsLive"]??"",
    subjectId: json["SubjectID"]??"",
    startedDt: json["StartedDT"]??"",
    finishedDt: json["FinishedDT"]??"",
    tFullName: json["t_FullName"]??"",
  );

  Map<String, dynamic> toJson() => {
    "Semester_Title_Ar": semesterTitleAr,
    "Live_SubjectTitle": liveSubjectTitle,
    "SemesterID": semesterId,
    "ClassID": classId,
    "Time_Of_Live_DT": timeOfLiveDt,
    "Recorded_Live_FileName_Mp4": recordedLiveFileNameMp4,
    "LiveSessionID": liveSessionId,
    "Subject_Title_Ar": subjectTitleAr,
    "Recorded_Live_FileName": recordedLiveFileName,
    "Class_Title_Ar": classTitleAr,
    "t_ProfilePic": tProfilePic,
    "IsLive": isLive,
    "SubjectID": subjectId,
    "StartedDT": startedDt,
    "FinishedDT": finishedDt,
    "t_FullName": tFullName,
  };
}
