import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/models/models.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository _noteRepository;

  NoteCubit(this._noteRepository, String userId) : super(NoteState.initial()) {
    fetchUserNote(userId);
  }

  void fetchUserNote(String userId) async {
    Note note = await _noteRepository.fetchUserNote(userId);
    emit(state.copyWith(title: note.title, notes: note.notes));
  }

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void notesChanged(String notes) {
    emit(state.copyWith(notes: notes));
  }

  void saveNotes(String userId) {
    Note note = Note(id: userId, title: state.title, notes: state.notes);
    _noteRepository.saveNote(note);
  }
}
