import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String? title;
  final bool? complete;

  const Todo({required this.id, this.title, this.complete});

  static const empty = Todo(id: '');

  bool get isEmpty => this == Todo.empty;
  bool get isNotEmpty => this != Todo.empty;

  @override
  List get props => [id, title, complete];

  Todo.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()!["title"],
        complete = doc.data()!["complete"];

  Map<String, dynamic> toDocument(String userId) {
    return {"userId": userId, "title": title, "complete": complete};
  }
}
