import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/materias.model.dart';
import '../providers/materias.provider.dart';

class MateriasFormPage extends StatefulWidget {
  final Subject? subject;

  const MateriasFormPage({super.key, this.subject});

  @override
  _MateriasFormPageState createState() => _MateriasFormPageState();
}

class _MateriasFormPageState extends State<MateriasFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para los campos del modelo Subject
  late final TextEditingController _codeCtrl;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _creditsCtrl;
  late final TextEditingController _hoursCtrl;
  late final TextEditingController _areaCtrl;
  late final TextEditingController _careerCtrl;
  late final TextEditingController _levelCtrl;

  // Si es diferente de null estamos editando
  bool get isEdit => widget.subject != null;

  @override
  void initState() {
    super.initState();
    final s = widget.subject;
    _codeCtrl = TextEditingController(text: s?.code ?? '');
    _nameCtrl = TextEditingController(text: s?.name ?? '');
    _creditsCtrl = TextEditingController(text: s?.credits.toString() ?? '');
    _hoursCtrl = TextEditingController(text: s?.hours.toString() ?? '');
    _areaCtrl = TextEditingController(text: s?.knowledgeArea ?? '');
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    _nameCtrl.dispose();
    _creditsCtrl.dispose();
    _hoursCtrl.dispose();
    _areaCtrl.dispose();
    _careerCtrl.dispose();
    _levelCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar materia' : 'Nueva materia')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _SectionTitle(title: 'Información de la Asignatura'),
                  _buildTextField(
                    _nameCtrl,
                    'Nombre de la Materia',
                    Icons.book,
                    required: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          _codeCtrl,
                          'Código',
                          Icons.qr_code,
                          required: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          _creditsCtrl,
                          'Créditos',
                          Icons.star,
                          required: true,
                          type: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  _buildTextField(
                    _hoursCtrl,
                    'Horas Totales',
                    Icons.more_time,
                    required: true,
                    type: TextInputType.number,
                  ),

                  const _SectionTitle(title: 'Clasificación Académica'),
                  _buildTextField(
                    _areaCtrl,
                    'Área (Ej: Software, Ciencias Básicas)',
                    Icons.category,
                    required: true,
                  ),
                  _buildTextField(
                    _careerCtrl,
                    'Carrera',
                    Icons.school,
                    required: true,
                  ),
                  _buildTextField(
                    _levelCtrl,
                    'Nivel / Semestre (Ej: Segundo Nivel)',
                    Icons.layers,
                    required: true,
                  ),

                  const SizedBox(height: 20),
                  _SaveButton(onPressed: _handleSave),
                  const SizedBox(height: 25),
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

    final provider = context.read<SubjectProvider>();

    if (isEdit) {
      // Al editar conservamos el ID original
      final subject = Subject(
        id: widget.subject!.id,
        code: _codeCtrl.text.trim(),
        name: _nameCtrl.text.trim(),
        credits: int.tryParse(_creditsCtrl.text.trim()) ?? 0,
        hours: int.tryParse(_hoursCtrl.text.trim()) ?? 0,
        knowledgeArea: _areaCtrl.text.trim(),
      );
      provider.updateSubject(subject);
    } else {
      // Al crear uno nuevo, pasamos id: 0 (el provider se encargará de asignarle uno nuevo)
      final subject = Subject(
        id: 0,
        code: _codeCtrl.text.trim(),
        name: _nameCtrl.text.trim(),
        credits: int.tryParse(_creditsCtrl.text.trim()) ?? 0,
        hours: int.tryParse(_hoursCtrl.text.trim()) ?? 0,
        knowledgeArea: _areaCtrl.text.trim(),
      );
      provider.addSubject(subject);
    }

    // Retorna true para indicarle a la pantalla anterior que hubo un cambio exitoso
    Navigator.pop(context, true);
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
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
          'GUARDAR MATERIA',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
