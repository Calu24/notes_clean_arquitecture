import 'package:bloc/bloc.dart';
import 'package:clean_arquitecture/domain/entities/note_entity.dart';
import 'package:clean_arquitecture/domain/usecases/note_usecases.dart';
import 'package:equatable/equatable.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit(
    this.addNotesUsecase,
    this.fetchNotesUseCase,
    this.deleteNoteUseCase,
    this.updateNoteUseCase,
  ) : super(const NoteState());

  final AddNoteUseCase addNotesUsecase;
  final FetchNotesUseCase fetchNotesUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;

  void addNote(NoteEntity note) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await addNotesUsecase.execute(note);

      result.fold(
        (failure) => emit(state.copyWith(isLoading: false)),
        (note) =>
            emit(state.copyWith(isLoading: false, notes: state.notes + [note])),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isLoadingError: true,
      ));
    }
  }

  void fetchNotes() async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await fetchNotesUseCase.execute();

      result.fold(
        (failure) => emit(state.copyWith(isLoading: false)),
        (notes) => emit(state.copyWith(isLoading: false, notes: notes)),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isLoadingError: true,
      ));
    }
  }

  void deleteNoteById(int id) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await deleteNoteUseCase.execute(id);

      result.fold(
        (failure) => emit(state.copyWith(isLoading: false)),
        (_) => emit(state.copyWith(
            isLoading: false,
            notes: state.notes.where((note) => note.id != id).toList())),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isLoadingError: true,
      ));
    }
  }

  void updateNoteById(NoteEntity note) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await updateNoteUseCase.execute(note);

      result.fold(
        (failure) => emit(state.copyWith(isLoading: false)),
        (_) => emit(state.copyWith(
            isLoading: false,
            notes: state.notes
                .map((n) => n.id == note.id ? note : n)
                .toList())),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isLoadingError: true,
      ));
    }
  }
}
