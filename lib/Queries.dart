import 'package:firebase_database/firebase_database.dart';
import 'Users.dart';

var refUsers = FirebaseDatabase.instance.ref().child("users_table");

Future<void> limitedData() async {
  var searched = refUsers.limitToFirst(2);

  searched.onValue.listen((event) {
    var getInfo = event.snapshot.value as Map;
    if (getInfo != null) {
      getInfo.forEach((key, value) {
        var getUser = Users.fromJson(value);
        print("*********");
        print("User Key : ${key} ");
        print("User Name : ${getUser.user_name} ");
        print("User Age : ${getUser.user_age} ");
      });
    }
  });
}

Future<void> ValuedData() async {
  var searched = refUsers.orderByChild("user_age").startAt(30);

  searched.onValue.listen((event) {
    var getInfo = event.snapshot.value as Map;
    if (getInfo != null) {
      getInfo.forEach((key, value) {
        var getUser = Users.fromJson(value);
        print("*********");
        print("User Key : ${key} ");
        print("User Name : ${getUser.user_name} ");
        print("User Age : ${getUser.user_age} ");
      });
    }
  });
}
