import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'materias.page.dart';

class MateriasHomePage extends StatelessWidget {
  const MateriasHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Materias')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: MateriasPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push('/materias/form', extra: null);
          if (result == true && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Materia creada correctamente')),
            );
          }
        },
        child: const Icon((Icons.add)),
      ),
    );
  }
}
