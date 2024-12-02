
import 'package:Jo_Students/check_user/check_user_response.dart';

class CurrentSession {
  static final CurrentSession _shared = CurrentSession._private();

  factory CurrentSession() => _shared;

  CurrentSession._private();

  CheckUserResponse? _user;

  void setUser(CheckUserResponse user) {
    _user = user;
  }

  CheckUserResponse? getUser() {
    if (isAuth()) return _user;
    return null;
  }

  bool isAuth() => _user != null;
}
