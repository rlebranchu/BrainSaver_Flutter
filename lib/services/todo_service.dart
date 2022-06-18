import 'package:brain_saver_flutter/models/models.dart';
import 'package:brain_saver_flutter/views/screens/todo/cubit/todo_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String collectionName = "todos";

  Future<List<Todo>> fetchListTodoOfUser(
      String userId, ListTodoStatus status) async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if (status == ListTodoStatus.all) {
      snapshot = await _firestore
          .collection(collectionName)
          .where('userId', isEqualTo: userId)
          .get();
    } else {
      snapshot = await _firestore
          .collection(collectionName)
          .where('userId', isEqualTo: userId)
          .where('complete',
              isEqualTo: status == ListTodoStatus.done ? true : false)
          .get();
    }
    return snapshot.docs
        .map((docSnapshot) => Todo.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<void> saveTodo(String userId, String title) async {
    Todo todo = Todo(id: '', title: title, complete: false);
    await _firestore.collection(collectionName).add(todo.toDocument(userId));
  }

  Future<void> completeTodo(String todoId, bool complete) async {
    await _firestore
        .collection(collectionName)
        .doc(todoId)
        .update({'complete': complete});
  }

  Future<void> deleteTodo(Todo todo) async {
    await _firestore.collection(collectionName).doc(todo.id).delete();
  }
}
