import 'package:clean_arquitecture/domain/entities/note_entity.dart';
import 'package:clean_arquitecture/domain/failures/failures.dart';
import 'package:clean_arquitecture/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

class FetchNotesUseCase {
  final NoteRepository repository;
  FetchNotesUseCase(this.repository);  
  Future<Either<Failure, List<NoteEntity>>> execute() async {
    return repository.fetchNotes();
  }
}

class AddNoteUseCase {
  final NoteRepository repository;
  AddNoteUseCase(this.repository);
  Future<Either<Failure, NoteEntity>> execute(NoteEntity? note) =>
      repository.addNote(note);
}

class DeleteNoteUseCase {
  final NoteRepository repository;
  DeleteNoteUseCase(this.repository);
  Future<Either<Failure, void>> execute(int id) =>
      repository.deleteNote(id);
}

class UpdateNoteUseCase {
  final NoteRepository repository;
  UpdateNoteUseCase(this.repository);
  Future<Either<Failure, void>> execute(NoteEntity? note) =>
      repository.updateNote(note);
}