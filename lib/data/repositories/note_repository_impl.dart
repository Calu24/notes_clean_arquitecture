import 'package:clean_arquitecture/data/datasource/note_local_datasource.dart';
import 'package:clean_arquitecture/data/models/note.dart';
import 'package:clean_arquitecture/domain/entities/note_entity.dart';
import 'package:clean_arquitecture/domain/exceptions/exceptions.dart';
import 'package:clean_arquitecture/domain/failures/failures.dart';
import 'package:clean_arquitecture/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource noteLocalDataSource;

  NoteRepositoryImpl({required this.noteLocalDataSource});

  @override
  Future<Either<Failure, NoteEntity>> addNote(note) async {
    try {
      final noteToInsert = Note.fromEntity(note!); //if this breaks, it's because note is null
      await noteLocalDataSource.add(noteToInsert);
      return Right(note);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> fetchNotes() async {
    try {
      final notes = await noteLocalDataSource.fetch();
      return Right(notes.map((note) => note.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(int id) async {
    try {
      await noteLocalDataSource.delete(id);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(NoteEntity? note) async {
    try {
      final noteToUpdate = Note.fromEntity(note!); //if this breaks, it's because note is null
      await noteLocalDataSource.update(noteToUpdate);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
