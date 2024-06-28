import 'package:clean_arquitecture/core/app_router/scaffold_with_nav_bar.dart';
import 'package:clean_arquitecture/domain/entities/note_entity.dart';
import 'package:clean_arquitecture/presentation/pages/add_note_page.dart';
import 'package:clean_arquitecture/presentation/pages/home_page.dart';
import 'package:clean_arquitecture/presentation/pages/note_details.dart';
import 'package:clean_arquitecture/presentation/pages/settings.dart';
import 'package:go_router/go_router.dart';

enum RoutePath {
  home(path: '/home'),
  add(path: '/home/add'),
  settings(path: '/settings'),
  details(path: '/home/details');

  const RoutePath({
    required this.path,
  });
  final String path;
}

final appRouter =
    GoRouter(initialLocation: RoutePath.home.path, routes: <RouteBase>[
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) => ScaffoldWithNavBar(
      navigationShell: navigationShell,
    ),
    branches: [
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
              path: RoutePath.home.path,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: RoutePath.add.name, // 'add'
                  builder: (context, state) {
                    final note = state.extra != null
                        ? (state.extra as List<dynamic>)[0] as NoteEntity
                        : null;
                    final isUpdate = state.extra != null
                        ? (state.extra as List<dynamic>)[1] as bool
                        : false;
                    return AddNotePage(
                      isUpdate: isUpdate,
                      note: note,
                    );
                  },
                ),
                GoRoute(
                  path: RoutePath.details.name, // 'details'
                  builder: (context, state) => NoteDetailPage(
                    note: state.extra as NoteEntity,
                  ),
                ),
              ]),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: RoutePath.settings.path,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  ),
]);
