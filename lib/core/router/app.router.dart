import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/auth/pages/login.page.dart';
import '../../features/auth/providers/auth.provider.dart';
import '../../features/solicitud/pages/solicitud.form.page.dart';
import '../../features/solicitud/pages/solicitud.home.page.dart';
import '../../features/solicitud/pages/solicitud.detail.page.dart';
import '../../features/student/models/student.model.dart';
import '../../features/student/pages/students.form.page.dart';
import '../../features/student/pages/students.home.page.dart';
import '../../features/subject/pages/materias.home.page.dart';
import '../../features/welcome/welcome.page.dart';
import '../../pages/chat.signature.page.dart';
import '../../features/subject/pages/materias.detail.page.dart';
import '../../pages/chat.page.dart';
import '../../pages/home.page.dart';
import '../../pages/profile.page.dart';
import '../../features/student/pages/students.detail.page.dart';
import '../../app/app.shell.widget.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  /// ==========================================
  /// GUARD DE AUTENTICACIÓN
  /// ==========================================
  redirect: (BuildContext context, GoRouterState state) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final isAuth = auth.isAuthenticated;
    final location = state.matchedLocation;

    // Rutas públicas que no requieren login
    final publicRoutes = ['/', '/login'];
    final isPublic = publicRoutes.contains(location);

    // Si no está autenticado y quiere entrar a una ruta protegida → login
    if (!isAuth && !isPublic) return '/login';

    // Si ya está autenticado y va al login → home
    if (isAuth && location == '/login') return '/home';

    return null; // Sin redirección
  },

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
          path: '/profile',
          builder: (context, state) {
            return const ProfilePage();
          },
        ),
      ],
    ),

    /// ==========================================
    /// RUTA Welcome (Splash)
    /// ==========================================
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const WelcomePage();
      },
    ),

    /// ==========================================
    /// RUTA LOGIN
    /// ==========================================
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),

    /// ==========================================
    /// RUTAS DE ESTUDIANTES
    /// ==========================================
    GoRoute(
      path: '/students',
      builder: (context, state) => const StudentsHomePage(),
    ),
    GoRoute(
      path: '/students/form',
      builder: (context, state) {
        final student = state.extra as Student?;
        return StudentsFormPage(student: student);
      },
    ),
    GoRoute(
      path: '/student/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return StudentDetailPage(id: id);
      },
    ),

    /// ==========================================
    /// RUTAS DE MATERIAS
    /// ==========================================
    GoRoute(
      path: '/materias',
      builder: (context, state) => const MateriasHomePage(),
    ),
    GoRoute(
      path: '/materias/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return MateriasDetailPage(id: id);
      },
    ),

    /// ==========================================
    /// RUTAS DE SOLICITUDES / DOCUMENTOS
    /// ==========================================
    GoRoute(
      path: '/solicitudes',
      builder: (context, state) => const SolicitudHomePage(),
    ),
    GoRoute(
      path: '/solicitudes/form',
      builder: (context, state) => const SolicitudFormPage(),
    ),
    GoRoute(
      path: '/solicitudes/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return SolicitudDetailPage(id: id);
      },
    ),

    /// ==========================================
    /// RUTAS DE CHAT Y EXTRAS
    /// ==========================================
    GoRoute(path: '/chat', builder: (context, state) => const ChatPage()),
    GoRoute(
      path: '/chat-signature',
      builder: (context, state) => const ChatSignaturePage(),
    ),
  ],
);
