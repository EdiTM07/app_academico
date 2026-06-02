import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/section.title.dart';
import '../../academic_programs/providers/academic.program.provider.dart';
import '../models/student.model.dart';
import '../providers/student.provider.dart';

class StudentsFormPage extends StatefulWidget {
  final Student? student;
  const StudentsFormPage({super.key, this.student});

  @override
  _StudentsFormPageState createState() => _StudentsFormPageState();
}

class _StudentsFormPageState extends State<StudentsFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeCtrl;
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _photoCtrl;
  late String _gender;
  late DateTime _birthDate;
  bool get isEdit => widget.student != null;
  int? selectedAcademicProgramId;

  @override
  void initState() {
    super.initState();
    final s = widget.student;
    _codeCtrl = TextEditingController(text: s?.code ?? '');
    _firstNameCtrl = TextEditingController(text: s?.firstName ?? '');
    _lastNameCtrl = TextEditingController(text: s?.lastName ?? '');
    _emailCtrl = TextEditingController(text: s?.email ?? '');
    _phoneCtrl = TextEditingController(text: s?.phone ?? '');
    _photoCtrl = TextEditingController(text: s?.photoUrl ?? '');
    _gender = s?.gender ?? 'M';
    _birthDate = s?.birthDate ?? DateTime.now();
    selectedAcademicProgramId = s?.academicProgramId;
  }

  @override
  void dispose() {
    for (var controller in [
      _codeCtrl,
      _firstNameCtrl,
      _lastNameCtrl,
      _emailCtrl,
      _phoneCtrl,
      _photoCtrl,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  /// ============================
  /// SAVE
  /// ============================
  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final provider = context.read<StudentProvider>();
    final student = Student(
      id: widget.student?.id,
      code: _codeCtrl.text.trim(),
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      gender: _gender,
      birthDate: _birthDate,
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      photoUrl: _photoCtrl.text.trim(),
      academicProgramId: selectedAcademicProgramId!,
    );
    if (isEdit) {
      await provider.updateStudent(student);
    } else {
      await provider.addStudent(student);
    }
    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final academicProgramProvider = context.watch<AcademicProgramProvider>();
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
                  /// ============================
                  /// ACADÉMICO
                  /// ============================
                  SectionTitle(title: 'Información Académica'),
                  _buildTextField(
                    _codeCtrl,
                    'Código',
                    Icons.badge,
                    required: true,
                  ),
                  DropdownButtonFormField<int>(
                    value: selectedAcademicProgramId,
                    decoration: const InputDecoration(
                      labelText: 'Carreras',
                      prefixIcon: Icon(Icons.school),
                      border: OutlineInputBorder(),
                    ),
                    items: academicProgramProvider.academicPrograms.map((
                      career,
                    ) {
                      return DropdownMenuItem(
                        value: career.id,
                        child: Text(career.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAcademicProgramId = value;
                      });
                    },
                    validator: (value) {
                      return value == null ? 'Seleccione una carrera' : null;
                    },
                  ),
                  const SizedBox(height: 20),

                  /// ============================
                  /// PERSONALES
                  /// ============================
                  SectionTitle(title: 'Datos Personales'),
                  _buildTextField(
                    _firstNameCtrl,
                    'Nombres',
                    Icons.person,
                    required: true,
                  ),
                  _buildTextField(
                    _lastNameCtrl,
                    'Apellidos',
                    Icons.person_2,
                    required: true,
                  ),
                  _buildGenderDropdown(),
                  _buildDatePicker(),
                  const SizedBox(height: 20),

                  /// ============================
                  /// CONTACTO
                  /// ============================
                  SectionTitle(title: 'Contacto'),
                  _buildTextField(
                    _emailCtrl,
                    'Email',
                    Icons.email,
                    type: TextInputType.emailAddress,
                  ),
                  _buildTextField(
                    _phoneCtrl,
                    'Teléfono',
                    Icons.phone,
                    type: TextInputType.phone,
                  ),
                  _buildTextField(_photoCtrl, 'URL Foto', Icons.image),
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

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _gender,
      decoration: const InputDecoration(
        labelText: 'Género',
        prefixIcon: Icon(Icons.wc),
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 'M', child: Text('Masculino')),
        DropdownMenuItem(value: 'F', child: Text('Femenino')),
      ],
      onChanged: (v) {
        setState(() {
          _gender = v!;
        });
      },
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
            ? (v) {
                return (v == null || v.isEmpty) ? 'Campo requerido' : null;
              }
            : null,
      ),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          alignment: Alignment.centerLeft,
        ),
        icon: const Icon(Icons.calendar_today),
        label: Text(
          "Fecha de Nacimiento: "
          "${DateFormat('dd/MM/yyyy').format(_birthDate)}",
        ),
        onPressed: _pickDate,
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
