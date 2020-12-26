import 'package:flutter/material.dart';
import 'taskModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoModel extends ChangeNotifier {
  List<Task> tasks = [];
  SharedPreferences prefs;

  TodoModel() {
    setup();
  }

  void setup() async {
    prefs = await SharedPreferences.getInstance();
    List<String> listString = prefs.getStringList('list');

    if (listString != null) {
      this.tasks =
          listString.map((item) => Task.fromMap(json.decode(item))).toList();
    }
    notifyListeners();
  } // end of setup

  void saveData() {
    List<String> stringList =
        tasks.map((item) => json.encode(item.toMap())).toList();

    prefs.setStringList('list', stringList);
  }

  void addTask(Task task) {
    this.tasks.add(task);
    // saveData();
    notifyListeners();
  }

  void removeItem(Task item) {
    tasks.remove(item);
    saveData();
    notifyListeners();
  }
} // end of TodoModel
