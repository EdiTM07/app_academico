import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/document.model.dart';
import '../providers/document.provider.dart';

class DocumentDetailPage extends StatelessWidget {
  final String id;

  const DocumentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DocumentProvider>();
    final documentId = int.tryParse(id);

    if (documentId == null) {
      return const Scaffold(body: Center(child: Text('ID Invalido')));
    }
    return FutureBuilder<AppDocument?>(
      future: provider.getById(documentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final document = snapshot.data;

        if (document == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Detalle de la solicitud'),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book_outlined, size: 80, color: Colors.blue),
                  const SizedBox(height: 16),
                  Text(
                    'Solicitud no encontrada',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Detalle de la solicitud'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.deepPurple.shade900,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Cabecera visual con los datos principales
                _buildHeader(context, document),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'Esta pantalla NO pertenece al ShellRoute.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Tarjeta con los detalles académicos
                      _buildInfoCard(context, document),

                      const SizedBox(height: 30),

                      // Botón de Acción Principal (Chat)
                      SizedBox(
                        height: 55,
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            // Navegación original que solicitaste
                            context.push('/chat-signature');
                          },
                          icon: const Icon(
                            Icons.forum_outlined,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Abrir Chat de materia',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
      },
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

  Widget _buildInfoCard(BuildContext context, AppDocument doc) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
