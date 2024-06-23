import 'package:clean_arquitecture/core/theme/app_styles.dart';
import 'package:clean_arquitecture/domain/entities/note_entity.dart';
import 'package:clean_arquitecture/presentation/cubit/note_cubit.dart';
import 'package:clean_arquitecture/presentation/pages/home_page.dart';
import 'package:clean_arquitecture/presentation/widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';

class AddNotePage extends StatefulWidget {
  final bool isUpdate;
  final NoteEntity? note;

  const AddNotePage({super.key, this.isUpdate = false, this.note});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleTextController = TextEditingController();
  final noteTextController = TextEditingController();
  final currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isUpdate) {
      titleTextController.text = widget.note!.title;
      noteTextController.text = widget.note!.text;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBar(),
            buildBody(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      leading: MyIconButton(
        onTap: () => Navigator.of(context).pop(),
        icon: Icons.keyboard_arrow_left,
      ),
      actions: [
        MyIconButton(
          onTap: () => validateInput(),
          text: widget.isUpdate ? 'Update' : 'Save',
        ),
      ],
      automaticallyImplyLeading: false, // To hide the back button
    );
  }

  Widget buildBody() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: titleTextController,
            style: AppStyles.title,
            cursorColor: Colors.white,
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle: AppStyles.title.copyWith(color: Colors.grey),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.background),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.background),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: noteTextController,
            style: AppStyles.body,
            cursorColor: Colors.white,
            minLines: 3,
            maxLines: 12,
            decoration: InputDecoration(
              hintText: 'Type something...',
              hintStyle: AppStyles.body,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.background),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.background),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateInput() {
    final isNotEmpty = titleTextController.text.isNotEmpty &&
        noteTextController.text.isNotEmpty;

    if (isNotEmpty) {
      if (widget.isUpdate) {
        updateNoteInDB();
      } else {
        addNoteToDB();
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  int generateUniqueId() {
    final now = DateTime.now();
    final minute = now.minute;
    final second = now.second;

    final id = int.parse(
        '${minute.toString().padLeft(2, '0')}${second.toString().padLeft(2, '0')}');

    return id;
  }

  void addNoteToDB() {
    BlocProvider.of<NoteCubit>(context).addNote(
      NoteEntity(
        id: generateUniqueId(),
        text: noteTextController.text,
        title: titleTextController.text,
        date: currentDate,
      ),
    );
  }

  void updateNoteInDB() {
    BlocProvider.of<NoteCubit>(context).updateNoteById(
      NoteEntity(
        id: widget.note!.id,
        text: noteTextController.text,
        title: titleTextController.text,
        date: currentDate,
      ),
    );
  }
}
