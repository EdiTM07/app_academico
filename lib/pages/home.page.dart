import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Accesos Rápidos'),
              _buildQuickActions(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Resumen Académico'),
              _buildSummarySection(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade800, Colors.deepPurple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade200,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.indigo),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '¡Bienvenido de vuelta!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sistema de Gestión Académica',
            style: TextStyle(
              fontSize: 16,
              color: Colors.indigo.shade100,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey.shade900,
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _ActionCard(
              title: 'Estudiantes',
              icon: Icons.people_alt_rounded,
              color: Colors.blue,
              onTap: () => context.push('/students'),
            ),
          ),
          Expanded(
            child: _ActionCard(
              title: 'Materias',
              icon: Icons.menu_book_rounded,
              color: Colors.orange,
              onTap: () => context.push('/materias'),
            ),
          ),
          Expanded(
            child: _ActionCard(
              title: 'Solicitudes',
              icon: Icons.file_copy_rounded,
              color: Colors.teal,
              onTap: () => context.push('/documents'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _SummaryTile(
            title: 'Ciclo Actual',
            subtitle: 'Semestre 2026-A',
            icon: Icons.calendar_month_rounded,
            color: Colors.purple,
          ),
          const SizedBox(height: 12),
          _SummaryTile(
            title: 'Notificaciones',
            subtitle: 'No tienes alertas pendientes',
            icon: Icons.notifications_active_rounded,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final MaterialColor color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: color.shade100,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.white, color.shade50.withOpacity(0.5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color.shade700, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final MaterialColor color;

  const _SummaryTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color.shade600),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
