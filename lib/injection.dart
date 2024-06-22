import 'package:clean_arquitecture/data/datasource/note_local_datasource.dart';
import 'package:clean_arquitecture/data/repositories/note_repository_impl.dart';
import 'package:clean_arquitecture/domain/repositories/note_repository.dart';
import 'package:clean_arquitecture/domain/usecases/note_usecases.dart';
import 'package:clean_arquitecture/presentation/cubit/note_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory(() => NoteCubit(
        locator<AddNoteUseCase>(),
        locator<FetchNotesUseCase>(),
      ));

  locator.registerLazySingleton(() => FetchNotesUseCase(locator()));
  locator.registerLazySingleton(() => AddNoteUseCase(locator()));

  locator.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(noteLocalDataSource: locator()),
  );

  locator.registerLazySingleton<NoteLocalDataSource>(
    () => NoteLocalDataSourceImpl(),
  );
}
