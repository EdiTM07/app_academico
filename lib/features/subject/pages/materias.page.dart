import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/materias.provider.dart';
import '../models/materias.model.dart';

class MateriasPage extends StatelessWidget {
  const MateriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final materias = context.watch<SubjectProvider>().subjects;

    // Estado: Lista vacía
    if (materias.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.library_books_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              "No hay materias registradas",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // Estado: Con datos (Cambiamos ListView por GridView)
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: materias.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final materia = materias[index];
        return _MateriaCard(materia: materia);
      },
    );
  }
}

class _MateriaCard extends StatelessWidget {
  final Subject materia;

  const _MateriaCard({required this.materia});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.deepPurple.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Usamos el ID real de la materia en tu base de datos
          context.push('/materias/${materia.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// CABECERA VISUAL (Mita superior de la tarjeta)
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.menu_book_rounded,
                      size: 45,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 8),
                    // Etiqueta del código de la materia
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        materia.code,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// INFORMACIÓN (Mitad inferior de la tarjeta)
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nombre de la materia
                    Text(
                      materia.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Detalles de créditos y horas
                    Text(
                      '${materia.credits} Créditos | ${materia.hours}h',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
