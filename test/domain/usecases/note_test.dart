import 'package:clean_arquitecture/domain/entities/note_entity.dart';
import 'package:clean_arquitecture/domain/failures/failures.dart';
import 'package:clean_arquitecture/domain/usecases/note_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late FetchNotesUseCase fetchNotesUseCase;
  late MockNoteRepository mockNoteRepository;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    fetchNotesUseCase = FetchNotesUseCase(mockNoteRepository);
  });

  List<NoteEntity> tNote = [
    NoteEntity(
      id: 1,
      title: 'title',
      date: DateTime.fromMicrosecondsSinceEpoch(1620000000000),
      text: 'asa',
    ),
  ];

  test('should fetch notes from the repository', () async {
    // arrange
    when(mockNoteRepository.fetchNotes())
        .thenAnswer((_) async => Right<Failure, List<NoteEntity>>(tNote));
    // act
    final result = await fetchNotesUseCase.execute();
    // assert
    expect(result, Right<Failure, List<NoteEntity>>(tNote));
    // verify(mockNoteRepository.fetchNotes());
    // verifyNoMoreInteractions(mockNoteRepository);
  });
}
