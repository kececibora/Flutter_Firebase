class Users {
  String user_name;
  int user_age;

  Users(this.user_name, this.user_age);

  factory Users.fromJson(Map<dynamic, dynamic> json) {
    return Users(json["user_name"] as String, json["user_age"] as int);
  }
}
