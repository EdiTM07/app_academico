import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'document.page.dart';

class DocumentHomePage extends StatelessWidget {
  const DocumentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitudes')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: DocumentPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push('/documents/form', extra: null);
          if (result == true && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Solicitud creada correctamente')),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
