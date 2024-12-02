import 'dart:convert';

class CheckUserResponse {
  int intIsSubActive;
  String msg;
  int intNumberOfLoginStreak;
  String sEmailAdd;
  String strLoginStreakText;
  int userid;
  int semesterid;
  int classid;
  String strLoginStreakImage;
  String sFirstName;
  String strLoginStreakOuterImage;
  int isDarkMode;
  String profilePic;
  String sPhoneNumber;

  CheckUserResponse({
    required this.intIsSubActive,
    required this.msg,
    required this.intNumberOfLoginStreak,
    required this.sEmailAdd,
    required this.strLoginStreakText,
    required this.userid,
    required this.semesterid,
    required this.classid,
    required this.strLoginStreakImage,
    required this.sFirstName,
    required this.strLoginStreakOuterImage,
    required this.isDarkMode,
    required this.profilePic,
    required this.sPhoneNumber,
  });

  CheckUserResponse copyWith({
    int? intIsSubActive,
    String? msg,
    int? intNumberOfLoginStreak,
    String? sEmailAdd,
    String? strLoginStreakText,
    int? userid,
    int? semesterid,
    int? classid,
    String? strLoginStreakImage,
    String? sFirstName,
    String? strLoginStreakOuterImage,
    int? isDarkMode,
    String? profilePic,
    String? sPhoneNumber,
  }) =>
      CheckUserResponse(
        intIsSubActive: intIsSubActive ?? this.intIsSubActive,
        msg: msg ?? this.msg,
        intNumberOfLoginStreak: intNumberOfLoginStreak ?? this.intNumberOfLoginStreak,
        sEmailAdd: sEmailAdd ?? this.sEmailAdd,
        strLoginStreakText: strLoginStreakText ?? this.strLoginStreakText,
        userid: userid ?? this.userid,
        semesterid: semesterid ?? this.semesterid,
        classid: classid ?? this.classid,
        strLoginStreakImage: strLoginStreakImage ?? this.strLoginStreakImage,
        sFirstName: sFirstName ?? this.sFirstName,
        strLoginStreakOuterImage: strLoginStreakOuterImage ?? this.strLoginStreakOuterImage,
        isDarkMode: isDarkMode ?? this.isDarkMode,
        profilePic: profilePic ?? this.profilePic,
        sPhoneNumber: sPhoneNumber ?? this.sPhoneNumber,
      );

  factory CheckUserResponse.fromRawJson(String str) => CheckUserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckUserResponse.fromJson(Map<String, dynamic> json) => CheckUserResponse(
    intIsSubActive: json["int_is_Sub_Active"]??"",
    msg: json["Msg"]??"",
    intNumberOfLoginStreak: json["int_Number_of_LoginStreak"]??"",
    sEmailAdd: json["s_EmailAdd"]??"",
    strLoginStreakText: json["str_Login_Streak_Text"]??"",
    userid: json["userid"]??"",
    semesterid: json["semesterid"]??"",
    classid: json["classid"]??"",
    strLoginStreakImage: json["str_Login_Streak_Image"]??"",
    sFirstName: json["s_FirstName"]??"",
    strLoginStreakOuterImage: json["str_Login_Streak_OuterImage"]??"",
    isDarkMode: json["Is_Dark_Mode"]??"",
    profilePic: json["ProfilePic"]??"",
    sPhoneNumber: json["s_PhoneNumber"]??"",
  );

  Map<String, dynamic> toJson() => {
    "int_is_Sub_Active": intIsSubActive,
    "Msg": msg,
    "int_Number_of_LoginStreak": intNumberOfLoginStreak,
    "s_EmailAdd": sEmailAdd,
    "str_Login_Streak_Text": strLoginStreakText,
    "userid": userid,
    "semesterid": semesterid,
    "classid": classid,
    "str_Login_Streak_Image": strLoginStreakImage,
    "s_FirstName": sFirstName,
    "str_Login_Streak_OuterImage": strLoginStreakOuterImage,
    "Is_Dark_Mode": isDarkMode,
    "ProfilePic": profilePic,
    "s_PhoneNumber": sPhoneNumber,
  };
}
