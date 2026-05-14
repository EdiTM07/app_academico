import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/student.model.dart';
import '../providers/student.provider.dart';

class StudentsFormPages extends StatefulWidget {
  final Student? student;

  const StudentsFormPages({super.key, this.student});

  @override
  _StudentsFormPageState createState() => _StudentsFormPageState();
}

class _StudentsFormPageState extends State<StudentsFormPages> {
  final _formKey = GlobalKey<FormState>();
  // Controlar objeto de los formularios
  late final TextEditingController _codeCtrl;
  late final TextEditingController _firstnameCtrl;
  late final TextEditingController _lastNameCtrl;
  // Si es diferente de null estamos editando
  bool get isEdit => widget.student != null;

  @override
  void initState() {
    super.initState();
    final s = widget.student;
    _codeCtrl = TextEditingController(text: s?.code ?? '');
    _firstnameCtrl = TextEditingController(text: s?.firstName ?? '');
    _lastNameCtrl = TextEditingController(text: s?.lastName ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar estudiante' : 'Nuevo estudiante'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SectionTitle(title: 'Información Academica'),
                  _buildTextField(
                    _codeCtrl,
                    'Código',
                    Icons.badge,
                    required: true,
                  ),
                  _SectionTitle(title: 'Datos Personales'),
                  _buildTextField(
                    _firstnameCtrl,
                    'Nombre',
                    Icons.person,
                    required: true,
                  ),

                  _buildTextField(
                    _lastNameCtrl,
                    'Apellido',
                    Icons.person_outline,
                    required: true,
                  ),
                  const SizedBox(height: 20),
                  _SaveButton(onPressed: _handleSave),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    bool required = false,
    TextInputType? type,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (v) => (v == null || v.isEmpty) ? 'Campo requerido' : null
            : null,
      ),
    );
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<StudentProvider>();

    final student = Student(
      id: widget.student?.id ?? 0,
      code: _codeCtrl.text.trim(),
      firstName: _firstnameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      gender: "F",
      birthDate: DateTime(200, 6, 10),
      email: "correo@ejemplo.com",
      phone: '100',
      photoUrl: '',
    );

    isEdit ? provider.updateStudent(student) : provider.addStudent(student);

    Navigator.pop(context, true);
  }
}

// Widgets auxiliares para limpieza visual
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.save),
        label: const Text(
          'GUARDAR ESTUDIANTE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
