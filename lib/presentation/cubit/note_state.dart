part of 'note_cubit.dart';

class NoteState extends Equatable {
  const NoteState({
    this.isLoading = false,
    this.isLoadingError = false,
    this.notes = const [],
  });

  final bool isLoading;
  final bool isLoadingError;
  final List<NoteEntity> notes;

  NoteState copyWith({
    bool? isLoading,
    bool? isLoadingError,
    List<NoteEntity>? notes,
  }) {
    return NoteState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingError: isLoadingError ?? this.isLoadingError,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [isLoading, isLoadingError, notes];
}
