import 'package:brain_saver_flutter/models/models.dart';
import 'package:brain_saver_flutter/services/services.dart';

class NoteRepository {
  final NoteService _noteService = NoteService();

  Future<Note> fetchUserNote(String userId) async {
    return await _noteService.fetchUserNote(userId);
  }

  Future<void> saveNote(Note note) async {
    await _noteService.saveNote(note);
  }
}
