import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String? title;
  final String? notes;

  const Note({required this.id, this.title, this.notes});

  static const empty = Note(id: '');

  // Functions to define if object is empty or not
  bool get isEmpty => this == Note.empty;
  bool get isNotEmpty => this != Note.empty;

  @override
  List get props => [id, title, notes];

  // Convertion function : Firestore Document to Note Object
  Note.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()!["title"],
        notes = doc.data()!["notes"];

  // Convertion function : Note Object to Firestore Document
  Map<String, dynamic> toDocument() {
    return {"title": title, "notes": notes};
  }
}
