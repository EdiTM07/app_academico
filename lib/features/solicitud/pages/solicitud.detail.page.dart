import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/solicitud.model.dart';
import '../providers/solicitud.provider.dart';

class SolicitudDetailPage extends StatelessWidget {
  final String id;

  const SolicitudDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DocumentProvider>();
    final documentId = int.tryParse(id);

    final AppDocument? doc = documentId != null
        ? provider.getById(documentId)
        : null;

    // Estado: Documento no encontrado
    if (doc == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle del Documento'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment_late_outlined,
                size: 80,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'Documento no encontrado',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    // Estado: Documento encontrado
    return Scaffold(
      appBar: AppBar(
        title: Text(
          doc.documentNumber,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, doc),

            // Contenido principal
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Tarjeta con metadatos y enrutamiento administrativo
                  _buildMetadataCard(context, doc),
                  const SizedBox(height: 20),

                  // Bloque de lectura del contenido del documento
                  _buildContentCard(doc),
                  const SizedBox(height: 30),

                  // Botón para ver archivos adjuntos (si existen)
                  if (doc.attachmentUrl != null &&
                      doc.attachmentUrl!.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.indigo.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // Acción para abrir el archivo o visualizar adjunto
                        },
                        icon: const Icon(Icons.picture_as_pdf_outlined),
                        label: Text(
                          'Ver Adjunto: ${doc.attachmentUrl}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
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

  Widget _buildHeader(BuildContext context, AppDocument doc) {
    // Color dinámico según el estado
    Color statusColor = Colors.grey;
    if (doc.status == 'Aprobado') statusColor = Colors.green;
    if (doc.status == 'En revisión') statusColor = Colors.orange;
    if (doc.status == 'Rechazado') statusColor = Colors.red;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 24, top: 16, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Hero(
            tag: 'document-badge-${doc.id}',
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.assignment,
                size: 50,
                color: Colors.indigo,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            doc.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          // Fila con etiquetas de Tipo y Estado
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  doc.type,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  doc.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataCard(BuildContext context, AppDocument doc) {
    final createDateStr =
        "${doc.createdAt.day.toString().padLeft(2, '0')}/${doc.createdAt.month.toString().padLeft(2, '0')}/${doc.createdAt.year}";

    String approvalDateStr = "Pendiente de firma";
    if (doc.approvalDate != null) {
      approvalDateStr =
          "${doc.approvalDate!.day.toString().padLeft(2, '0')}/${doc.approvalDate!.month.toString().padLeft(2, '0')}/${doc.approvalDate!.year}";
    }

    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            _InfoTile(
              icon: Icons.person_outline,
              label: "Remitente",
              value: doc.sender,
            ),
            const Divider(height: 1, indent: 50, endIndent: 16),
            _InfoTile(
              icon: Icons.assignment_ind_outlined,
              label: "Destinatario",
              value: doc.receiver,
            ),
            const Divider(height: 1, indent: 50, endIndent: 16),
            _InfoTile(
              icon: Icons.business_outlined,
              label: "Área o Departamento",
              value: doc.department,
            ),
            const Divider(height: 1, indent: 50, endIndent: 16),
            _InfoTile(
              icon: Icons.outlined_flag,
              label: "Prioridad",
              value: doc.priority,
            ),
            const Divider(height: 1, indent: 50, endIndent: 16),
            _InfoTile(
              icon: Icons.calendar_today_outlined,
              label: "Fecha de Creación",
              value: createDateStr,
            ),
            const Divider(height: 1, indent: 50, endIndent: 16),
            _InfoTile(
              icon: Icons.draw_outlined,
              label: "Fecha de Firma / Aprobación",
              value: approvalDateStr,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard(AppDocument doc) {
    return Card(
      elevation: 1,
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.article_outlined, size: 20, color: Colors.black54),
                SizedBox(width: 8),
                Text(
                  "Contenido del Documento",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              doc.content,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(
        label,
        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      dense: true,
    );
  }
}
