// ignore_for_file: non_constant_identifier_names

class ApiEndPoint {
  static String BASE_URL = "https://jostudents.com/api_website?req=";
  static String CURRICULUMS_URL = "${BASE_URL}Subjects";
  static String REGISTER_URL = "${BASE_URL}Register_Student_Json";
  static String LOGIN_URL = "${BASE_URL}Login_Student_Json";
  static String CLASSES_URL = "${BASE_URL}Classes";
  static String LIKE_URL = "${BASE_URL}Add_Like_To_Book";
  static String DISLIKE_URL = "${BASE_URL}Add_DisLike_To_Book";
  static String CLASSES_NAME_URL = "${BASE_URL}Get_Class_Name_ByID";
  static String CLASSES_UPDATE_URL = "${BASE_URL}Change_Class_Student_Json";
  static String CHECK_USER_URL = "${BASE_URL}Check_Login_Student_Json";
  static String LOAD_BOOK_DETAILS = "${BASE_URL}Load_Book_Details_ByID";
  static String LOAD_SUBJECT_NAME_BYID= "${BASE_URL}Get_Subject_Name_ByID";
  static String LOAD_BOOKS_BY_SUBJECTID= "${BASE_URL}Books_By_SubjectID";
  static String LOAD_BOOKS_VIDEO_SUBJECTID= "${BASE_URL}Books_Videos_By_SubjectID";
  static String LOAD_BOOKS_WORKBOOKS_SUBJECTID= "${BASE_URL}Workbooks_By_SubjectID";
  static String LOAD_BOOKS_WORKBOOKS_DETAILS= "${BASE_URL}Load_WorkBook_Details_ByID";
  static String LOAD_BOOKS_TEST_SUBJECTID= "${BASE_URL}Exams_By_SubjectID";
  static String MY_QUESTION_URL= "${BASE_URL}MyQuestions";
  static String MY_QUESTION_BY_ID_URL= "${BASE_URL}MyQuestion_ByID";
  static String ADD_QUESTION_URL= "${BASE_URL}AddMyQuestion";
  static String DELETE_QUESTION_URL= "${BASE_URL}Delete_MyQuestion";
  static String LIVE_CLASSES_URL= "${BASE_URL}Get_All_Live_Sessions";
  static String SUBSCRIPTION_URL= "${BASE_URL}Load_My_Subscriptions";
  static String NOTIFICATION_URL= "${BASE_URL}Load_Users_Notifications";
  static String MY_REVIEWS_LISTS_URL= "${BASE_URL}MyLists";
  static String ADD_REVIEWS_LISTS_URL= "${BASE_URL}Add_MyList";
  static String REVIEWS_DETAILS_URL= "${BASE_URL}MyLists_ByListID";
  static String DELETE_REVIEWS_LISTS_URL= "${BASE_URL}Delete_MyList";
  static String ADD_BOOK_TO_REVIEWS_LISTS_URL= "${BASE_URL}Add_Book_To_My_List";
  static String UPDATE_SETTINGS_URL= "${BASE_URL}Update_MySettings";
  static String UPDATE_PROFILE_URL= "${BASE_URL}Update_MyProfile";
  static String LIBRARY_URL= "${BASE_URL}Load_Library_Books";
  static String LIBRARY_ID_URL= "${BASE_URL}Load_Library_Book_ByID";
}
