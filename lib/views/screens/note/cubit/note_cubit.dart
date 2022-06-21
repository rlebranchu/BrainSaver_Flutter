import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/models/models.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository _noteRepository;

  NoteCubit(this._noteRepository, String userId) : super(NoteState.initial()) {
    // At the openning of screen, we fetch notes and its title of user logged
    fetchUserNote(userId);
  }

  // Fetch the notes and its title of unique notes of user
  void fetchUserNote(String userId) async {
    Note note = await _noteRepository.fetchUserNote(userId);
    emit(state.copyWith(title: note.title, notes: note.notes));
  }

  // New State : with new value of title
  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  // New State : with new value of notes
  void notesChanged(String notes) {
    emit(state.copyWith(notes: notes));
  }

  // Ask to service to save new statue to unique note of user logged
  void saveNotes(String userId) {
    Note note = Note(id: userId, title: state.title, notes: state.notes);
    _noteRepository.saveNote(note);
  }
}
