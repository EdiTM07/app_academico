import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/materias.model.dart';
import '../providers/materias.provider.dart';   

class MateriasDetailPage extends StatelessWidget {
  final String id;

  const MateriasDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // 1. Escuchar el Provider
    final provider = context.watch<SubjectProvider>();
    
    // 2. Convertir el ID de String a int
    final subjectId = int.tryParse(id);

    // 3. Buscar la materia en el repositorio
    final Subject? subject = subjectId != null 
        ? provider.getById(subjectId) 
        : null;

    // Estado: Materia no encontrada
    if (subject == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle de la Materia'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.menu_book_outlined, size: 80, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'Materia no encontrada',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    // Estado: Materia encontrada
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la Materia'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple.shade50,
        foregroundColor: Colors.deepPurple.shade900,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabecera visual con los datos principales
            _buildHeader(context, subject),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Esta pantalla NO pertenece al ShellRoute.',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tarjeta con los detalles académicos
                  _buildInfoCard(context, subject),
                  
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
                      icon: const Icon(Icons.forum_outlined, color: Colors.white),
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
  }

  // Widget para la cabecera
  Widget _buildHeader(BuildContext context, Subject subject) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              size: 60,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              subject.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple.shade200),
            ),
            child: Text(
              'Código: ${subject.code}',
              style: const TextStyle(
                fontSize: 14, 
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para la información académica
  Widget _buildInfoCard(BuildContext context, Subject subject) {
    return Card(
      elevation: 2,
      shadowColor: Colors.deepPurple.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            _InfoTile(
              icon: Icons.account_tree_outlined, 
              label: "Área de Conocimiento", 
              value: subject.knowledgeArea,
            ),
            const Divider(height: 1, indent: 50, endIndent: 16),
            _InfoTile(
              icon: Icons.stars_outlined, 
              label: "Créditos", 
              value: '${subject.credits} Créditos',
            ),
            const Divider(height: 1, indent: 50, endIndent: 16),
            _InfoTile(
              icon: Icons.schedule_outlined, 
              label: "Carga Horaria", 
              value: '${subject.hours} Horas en total',
            ),
          ],
        ),
      ),
    );
  }
}

/// Componente visual reutilizable para los listados de información
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
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.deepPurple, size: 22),
      ),
      title: Text(
        label,
        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 16, 
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      dense: true,
    );
  }
}