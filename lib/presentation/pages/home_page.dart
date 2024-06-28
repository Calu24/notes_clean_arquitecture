import 'package:clean_arquitecture/core/app_router/app_router.dart';
import 'package:clean_arquitecture/core/theme/app_colors.dart';
import 'package:clean_arquitecture/core/theme/app_styles.dart';
import 'package:clean_arquitecture/presentation/cubit/note_cubit.dart';
import 'package:clean_arquitecture/presentation/widgets/display_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NoteCubit>().fetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          context.push(RoutePath.add.path);
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBar(),
            const SizedBox(height: 16),
            buildBody(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: AppStyles.title.copyWith(fontSize: 32),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            } else if (state.isLoadingError) {
              return const Center(
                child: Text('Error loading notes!'),
              );
            } else {
              return SingleChildScrollView(
                child: DisplayNotes(notes: state.notes),
              );
            }
          },
        ),
      ),
    );
  }
}
