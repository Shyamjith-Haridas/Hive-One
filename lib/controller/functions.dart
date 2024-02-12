import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sharedpref_login/model/todo_model.dart';

// create
ValueNotifier<List<TodoModel>> notifierList = ValueNotifier([]);

// add
void addTask(TodoModel todoModelValues) async {
  final hiveDatabase = await Hive.openBox<TodoModel>("todo_database");
  final hive_id = await hiveDatabase.add(todoModelValues);
  todoModelValues.taskId = hive_id;
  notifierList.value.add(todoModelValues);
  notifierList.notifyListeners();
}

// get
void getFunction() async {
  final hiveDatabase = await Hive.openBox<TodoModel>("todo_database");
  notifierList.value.clear();
  notifierList.value.addAll(hiveDatabase.values);
  notifierList.notifyListeners();
}

// update / delete
void updateFunction() {}

// delete
void deleteFunction(int deleteKey) async {
  final hiveDatabase = await Hive.openBox<TodoModel>("todo_database");
  await hiveDatabase.delete(deleteKey);
  getFunction();
}
