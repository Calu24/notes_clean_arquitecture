import 'package:clean_arquitecture/domain/entities/note_entity.dart';
import 'package:clean_arquitecture/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class NoteRepository {
  Future<Either<Failure, NoteEntity>> addNote(NoteEntity? note);
  Future<Either<Failure, List<NoteEntity>>> fetchNotes();
  Future<Either<Failure, void>> deleteNote(int id);
  Future<Either<Failure, void>> updateNote(NoteEntity? note);
}
