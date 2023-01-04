import 'dart:collection';

import 'package:firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var refUsers = FirebaseDatabase.instance.ref().child("users_table");

  Future<void> userAdd() async {
    var info = HashMap<String, dynamic>();
    info["user_name"] = "Bora";
    info["user_age"] = 28;
    refUsers.push().set(info);
    print("Done!");
  }

  Future<void> userDelete() async {
    refUsers.child("-NKyRMoznhJ4_R8KI_If").remove();
  }

  Future<void> userUpdate() async {
    var updatedInfo = HashMap<String, dynamic>();
    updatedInfo["user_name"] = "New Bora";
    updatedInfo["user_age"] = 31;

    refUsers.child("-NKySrL1vATioTiOXYmd").update(updatedInfo);
  }

  Future<void> getAll() async {
    refUsers.onValue.listen((event) {
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

  Future<void> getAllOnce() async {
    refUsers.once().then((event) {
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

  @override
  void initState() {
    getAllOnce();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireBase"),
      ),
      body: Center(),
    );
  }
}
