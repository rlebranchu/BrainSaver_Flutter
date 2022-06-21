import 'package:brain_saver_flutter/models/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // constant to get collections name
  static const String collectionName = "notes";

  // Get the unique note of user : Note ID = User ID
  Future<Note> fetchUserNote(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await _firestore.collection(collectionName).doc(userId).get();
    return docSnapshot.exists
        ? Note.fromDocumentSnapshot(docSnapshot)
        : Note.empty;
  }

  // Save the unique to service to
  Future<void> saveNote(Note note) async {
    await _firestore
        .collection(collectionName)
        .doc(note.id)
        .set(note.toDocument());
  }
}
