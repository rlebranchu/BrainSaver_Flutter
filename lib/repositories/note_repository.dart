import 'package:brain_saver_flutter/models/models.dart';
import 'package:brain_saver_flutter/services/services.dart';

class NoteRepository {
  final NoteService _noteService = NoteService();

  // Ask to service to get the unique note of the user
  Future<Note> fetchUserNote(String userId) async {
    return await _noteService.fetchUserNote(userId);
  }

  // Ask to service to save the unique note of user
  Future<void> saveNote(Note note) async {
    await _noteService.saveNote(note);
  }
}
