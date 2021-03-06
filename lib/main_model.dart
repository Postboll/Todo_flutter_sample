import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_test/todo.dart';

class MainModel extends ChangeNotifier {

  List<Todo> todoList = [];

  Future getTodoList() async {
    final snapshot = await  FirebaseFirestore.instance.collection('todoList').get();
    final docs = snapshot.docs;
    final todoList = docs.map((doc) => Todo(doc)).toList();
    this.todoList = todoList;
    notifyListeners();

  }


  void getTodoListRealTime(){
    final snapshots =
        FirebaseFirestore.instance.collection('todoList').snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final todoList = docs.map((doc) => Todo(doc)).toList();
      todoList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.todoList = todoList;
      notifyListeners();
    });

  }

}