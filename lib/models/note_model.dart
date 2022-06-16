import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String? title;
  final String? notes;

  const Note({required this.id, this.title, this.notes});

  static const empty = Note(id: '');

  bool get isEmpty => this == Note.empty;
  bool get isNotEmpty => this != Note.empty;

  @override
  List get props => [id, title, notes];

  Note.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()!["title"],
        notes = doc.data()!["notes"];

  Map<String, dynamic> toDocument() {
    return {"title": title, "notes": notes};
  }
}
