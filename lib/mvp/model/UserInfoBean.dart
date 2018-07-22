/**
 * 用户信息
 */
class UserInfoBean {
  String _userName;
  String _userSex;
  int _userAge;
  int _userVIP = 0;
  int _actions = 0;//动态
  int _attentions = 0;//关注
  int _fans = 0;//粉丝

  UserInfoBean(this._userName,
      this._userSex,
      this._userAge,
      this._userVIP) {
  }

  int get actions => _actions;

  set actions(int value) {
    _actions = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get userSex => _userSex;

  int get userVIP => _userVIP;

  set userVIP(int value) {
    _userVIP = value;
  }

  int get userAge => _userAge;

  set userAge(int value) {
    _userAge = value;
  }

  set userSex(String value) {
    _userSex = value;
  }

  int get attentions => _attentions;

  int get fans => _fans;

  set fans(int value) {
    _fans = value;
  }

  set attentions(int value) {
    _attentions = value;
  }


}