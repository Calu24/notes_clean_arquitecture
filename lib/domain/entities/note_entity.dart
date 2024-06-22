import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int id;
  final String title;
  final String text;
  final DateTime date;

  const NoteEntity({
    required this.id,
    required this.title,
    required this.text,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, text, date];
}
