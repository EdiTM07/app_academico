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
      case '/solicitudes':
        return 4;
      case '/profile':
        return 4;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Universidad'), centerTitle: false),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: child,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: obtenerIndex(context),

        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.push('/students');
              break;
            case 2:
              context.push('/materias');
              break;
            case 3:
              context.push('/solicitudes');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),

          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Estudiantes',
          ),

          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Materias',
          ),
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            selectedIcon: Icon(Icons.description),
            label: 'Solicitudes',
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
