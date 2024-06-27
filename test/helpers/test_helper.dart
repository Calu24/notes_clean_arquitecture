import 'package:clean_arquitecture/domain/repositories/note_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [NoteRepository],
  customMocks: [
    MockSpec<http.Client>(
      as: #MockHttpClient,
    ),
  ],
)
void main() {}
