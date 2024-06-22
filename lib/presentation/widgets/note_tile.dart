import 'package:clean_arquitecture/core/theme/app_colors.dart';
import 'package:clean_arquitecture/core/theme/app_styles.dart';
import 'package:clean_arquitecture/domain/entities/note_entity.dart';
import 'package:clean_arquitecture/presentation/cubit/note_cubit.dart';
import 'package:clean_arquitecture/presentation/pages/note_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

enum TileType { square, verRect, horRect }

class NoteTile extends StatelessWidget {
  final NoteEntity note;
  final TileType tileType;
  final int index;

  const NoteTile({
    super.key,
    required this.note,
    required this.tileType,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: BlocProvider.of<NoteCubit>(context),
              child: NoteDetailPage(note: note),
            ),
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.tiles[index % 7],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: tileType == TileType.horRect
                    ? const EdgeInsets.only(right: 100)
                    : null,
                child: Text(
                  note.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: getMaxLines(tileType),
                  style: AppStyles.noteTitle.copyWith(
                    fontSize: getTextSize(tileType),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('MM/dd HH:mm').format(note.date),
                    overflow: TextOverflow.fade,
                    maxLines: getMaxLines(tileType),
                    style: AppStyles.date.copyWith(
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getTextSize(TileType tileType) {
    switch (tileType) {
      case TileType.square:
        return 21.0;
      case TileType.verRect:
        return 24.0;
      case TileType.horRect:
        return 29.0;
      default:
        return 21.0;
    }
  }

  int getMaxLines(TileType tileType) {
    switch (tileType) {
      case TileType.square:
        return 4;
      case TileType.verRect:
        return 8;
      case TileType.horRect:
        return 3;
      default:
        return 4;
    }
  }
}