import '../../pages/chat.signature.page.dart';
import '../../pages/materias.detail.page.dart';
import 'package:go_router/go_router.dart';
import '../../pages/chat.page.dart';
import '../../pages/home.page.dart';
import '../../pages/profile.page.dart';
import '../../features/student/pages/students.detail.page.dart';
import '../../features/student/pages/students.page.dart';
import '../../pages/materias.page.dart';
import '../../widgets/app.shell.widget.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppShellWidget(child: child);
      },

      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return const HomePage();
          },
        ),

        GoRoute(
          path: '/students',
          builder: (context, state) {
            return const StudentsPage();
          },
        ),

        GoRoute(
          path: '/materias',
          builder: (context, state) {
            return const MateriasPage();
          },
        ),

        GoRoute(
          path: '/profile',
          builder: (context, state) {
            return const ProfilePage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/student/:id',

      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return StudentDetailPage(id: id);
      },
    ),
    GoRoute(
      path: '/materias/:id',

      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return MateriasDetailPage(id: id);
      },
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) {
        return const ChatPage();
      },
    ),
    GoRoute(
      path: '/chat-signature',
      builder: (context, state) {
        return const ChatSignaturePage();
      },
    ),
  ],
);
