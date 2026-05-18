import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'solicitud.page.dart';

class SolicitudHomePage extends StatelessWidget {
  const SolicitudHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitudes')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: SolicitudesPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push('/solicitudes/form', extra: null);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Solicitud creada')));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
