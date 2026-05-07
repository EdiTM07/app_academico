import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShellWidget extends StatelessWidget {
  final Widget child;

  const AppShellWidget({super.key, required this.child});

  int obtenerIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    switch (location) {
      case '/home':
        return 0;

      case '/students':
        return 1;

      case '/materias':
        return 2;

      case '/profile':
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Universidad')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: obtenerIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/students');
              break;
            case 2:
              context.go('/materias');
              break;
            case 3:
            context.go('/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.school),label: 'Estudiantes',),
          BottomNavigationBarItem(icon: Icon(Icons.book),label: 'Estudiantes',),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
