import 'package:brain_saver_flutter/models/models.dart';
import 'package:brain_saver_flutter/views/screens/todo/cubit/todo_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // constant to get collections name
  static const String collectionName = "todos";

  //
  Future<List<Todo>> fetchListTodoOfUser(
      String userId, ListTodoStatus status) async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    // Condition to get list of todos according to the filtre selected
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
    // Transform QueryDocuement to List<Todo>
    return snapshot.docs
        .map((docSnapshot) => Todo.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  // Save new Todo in Firestore
  Future<void> saveTodo(String userId, String title) async {
    Todo todo = Todo(id: '', title: title, complete: false);
    await _firestore.collection(collectionName).add(todo.toDocument(userId));
  }

  // Set completion of specific todo
  Future<void> completeTodo(String todoId, bool complete) async {
    await _firestore
        .collection(collectionName)
        .doc(todoId)
        .update({'complete': complete});
  }

  // Delete todo in Firestore collections
  Future<void> deleteTodo(Todo todo) async {
    await _firestore.collection(collectionName).doc(todo.id).delete();
  }
}
