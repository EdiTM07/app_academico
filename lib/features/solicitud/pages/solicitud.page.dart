import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/solicitud.model.dart';
import '../providers/solicitud.provider.dart';

class SolicitudesPage extends StatelessWidget {
  const SolicitudesPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// ESCUCHA EL PROVIDER DE DOCUMENTOS
    final documents = context.watch<DocumentProvider>().documents;

    if (documents.isEmpty) {
      return const Center(child: Text("No hay documentos registrados"));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: documents.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio:
            0.75, // Mantiene la proporción idéntica a tus estudiantes
      ),
      itemBuilder: (context, index) {
        final doc = documents[index];

        return _DocumentCard(document: doc);
      },
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final AppDocument document;

  const _DocumentCard({required this.document});

  @override
  Widget build(BuildContext context) {
    // Definimos un color dinámico según el estado del trámite institucional
    Color statusColor = Colors.grey;
    if (document.status == 'Aprobado') statusColor = Colors.green;
    if (document.status == 'En revisión') statusColor = Colors.orange;
    if (document.status == 'Rechazado') statusColor = Colors.red;

    return GestureDetector(
      onTap: () {
        context.push('/solicitudes/${document.id}');
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// ENCABEZADO DE LA TARJETA (Icono descriptivo + Número de documento)
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.indigo.shade50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.assignment_outlined,
                        size: 60,
                        color: Colors.indigo,
                      ),
                      // Pequeña etiqueta con el tipo de documento (Solicitud, Oficio, etc.)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            document.type,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// INFORMACIÓN DEL TRÁMITE
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Código institucional (Ej: SOL-2026-001)
                  Text(
                    document.documentNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Asunto o Título resumido
                  Text(
                    document.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Estado visual del documento
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      document.status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
