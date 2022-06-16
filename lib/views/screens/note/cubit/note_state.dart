part of 'note_cubit.dart';

class NoteState extends Equatable {
  final String title;
  final String notes;

  const NoteState({required this.title, required this.notes});

  @override
  List<Object> get props => [title, notes];

  factory NoteState.initial() {
    return NoteState(title: '', notes: '');
  }

  NoteState copyWith({
    String? title,
    String? notes,
  }) {
    return NoteState(title: title ?? this.title, notes: notes ?? this.notes);
  }
}
