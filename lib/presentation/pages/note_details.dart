import 'package:clean_arquitecture/core/app_router/app_router.dart';
import 'package:clean_arquitecture/domain/entities/note_entity.dart';
import 'package:clean_arquitecture/presentation/cubit/note_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteEntity note;

  const NoteDetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<NoteCubit>().deleteNoteById(note.id);
              context.pop();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          context.push(RoutePath.add.path, extra: [note, true]);
        },
        child: const Icon(Icons.edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.date.toString(),
              style: AppStyles.date.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              note.title,
              style: AppStyles.noteTitle
                  .copyWith(color: Colors.white.withOpacity(0.7), fontSize: 32),
            ),
            const SizedBox(height: 24),
            Text(
              note.text,
              style: AppStyles.body.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
