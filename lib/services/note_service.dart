import 'package:brain_saver_flutter/models/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String collectionName = "notes";

  Future<Note> fetchUserNote(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await _firestore.collection(collectionName).doc(userId).get();
    return docSnapshot.exists
        ? Note.fromDocumentSnapshot(docSnapshot)
        : Note.empty;
  }

  Future<void> saveNote(Note note) async {
    await _firestore
        .collection(collectionName)
        .doc(note.id)
        .set(note.toDocument());
  }
}
