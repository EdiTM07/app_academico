import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/section.title.dart';
import '../../career/providers/career.provider.dart';
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

  late final TextEditingController _codeCtrl;
  late final TextEditingController _firstnameCtrl;
  late final TextEditingController _lastNameCtrl;

  // Variable local para controlar la relación institucional
  int? _selectedCareerId;

  bool get isEdit => widget.student != null;

  @override
  void initState() {
    super.initState();
    final s = widget.student;
    _codeCtrl = TextEditingController(text: s?.code ?? '');
    _firstnameCtrl = TextEditingController(text: s?.firstName ?? '');
    _lastNameCtrl = TextEditingController(text: s?.lastName ?? '');

    _selectedCareerId = s?.careerId;
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    _firstnameCtrl.dispose();
    _lastNameCtrl.dispose();
    super.dispose();
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
                  const SectionTitle(title: 'Información Académica'),

                  _buildTextField(
                    _codeCtrl,
                    'Código',
                    Icons.badge,
                    required: true,
                  ),

                  // DROPDOWN DE CARRERAS
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Consumer<CareerProvider>(
                      builder: (context, careerProvider, _) {
                        final careers = careerProvider.careers;

                        return DropdownButtonFormField<int>(
                          value: _selectedCareerId,
                          decoration: const InputDecoration(
                            labelText: 'Carrera',
                            prefixIcon: Icon(
                              Icons.school,
                              color: Colors.blueGrey,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          items: careers.map((career) {
                            return DropdownMenuItem<int>(
                              value: career.id,
                              child: Text(career.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCareerId = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Seleccione una carrera' : null,
                        );
                      },
                    ),
                  ),

                  const SectionTitle(title: 'Datos Personales'),
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
      id: widget.student?.id ?? DateTime.now().millisecondsSinceEpoch,
      code: _codeCtrl.text.trim(),
      firstName: _firstnameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      careerId: _selectedCareerId!,
      gender: widget.student?.gender ?? "M",
      birthDate: widget.student?.birthDate ?? DateTime(2005, 5, 10),
      email: widget.student?.email ?? "correo@ejemplo.com",
      phone: widget.student?.phone ?? "0999999999",
      photoUrl: widget.student?.photoUrl ?? "",
    );

    isEdit ? provider.updateStudent(student) : provider.addStudent(student);

    Navigator.pop(context, true);
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
