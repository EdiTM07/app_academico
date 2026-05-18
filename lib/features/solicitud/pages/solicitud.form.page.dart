import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/solicitud.model.dart';
import '../providers/solicitud.provider.dart';

class SolicitudFormPage extends StatefulWidget {
  final AppDocument? document;

  const SolicitudFormPage({super.key, this.document});

  @override
  _SolicitudFormPageState createState() => _SolicitudFormPageState();
}

class _SolicitudFormPageState extends State<SolicitudFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores tardíos (late final) tal como tu ejemplo de estudiantes
  late final TextEditingController _titleCtrl;
  late final TextEditingController _contentCtrl;

  // Selectores de estado del formulario
  late String _selectedType;
  late String _selectedPriority;
  late String _selectedDepartment;

  // Si pasamos un documento por el constructor, estamos editando
  bool get isEdit => widget.document != null;

  @override
  void initState() {
    super.initState();
    final d = widget.document;

    // Inicialización dinámica: si edita toma el valor, si es nuevo inicia vacío/por defecto
    _titleCtrl = TextEditingController(text: d?.title ?? '');
    _contentCtrl = TextEditingController(text: d?.content ?? '');

    _selectedType = d?.type ?? 'Solicitud';
    _selectedPriority = d?.priority ?? 'Normal';
    _selectedDepartment = d?.department ?? 'Coordinación Académica';
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar documento' : 'Nuevo documento'),
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
                  const _SectionTitle(title: 'Clasificación Institucional'),

                  // DROPDOWN: TIPO
                  _buildDropdownField(
                    label: 'Tipo de Documento',
                    icon: Icons.assignment_outlined,
                    value: _selectedType,
                    items: const ['Solicitud', 'Oficio', 'Memorando'],
                    onChanged: (val) => setState(() => _selectedType = val!),
                  ),

                  // DROPDOWN: DEPARTAMENTO DESTINO
                  _buildDropdownField(
                    label: 'Área o Destinatario',
                    icon: Icons.business_outlined,
                    value: _selectedDepartment,
                    items: const [
                      'Coordinación Académica',
                      'Secretaría',
                      'Bienestar Estudiantil',
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedDepartment = val!),
                  ),

                  // DROPDOWN: PRIORIDAD
                  _buildDropdownField(
                    label: 'Nivel de Urgencia',
                    icon: Icons.outlined_flag,
                    value: _selectedPriority,
                    items: const ['Normal', 'Alta', 'Urgente'],
                    onChanged: (val) =>
                        setState(() => _selectedPriority = val!),
                  ),

                  const _SectionTitle(title: 'Cuerpo del Trámite'),

                  // CAMPO: ASUNTO
                  _buildTextField(
                    _titleCtrl,
                    'Asunto o Título',
                    Icons.title,
                    required: true,
                  ),

                  // CAMPO: CONTENIDO LARGO
                  _buildTextField(
                    _contentCtrl,
                    'Descripción o Contenido extendido',
                    Icons.article_outlined,
                    required: true,
                    maxLines: 5,
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
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: maxLines > 1
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Icon(icon),
                )
              : Icon(icon),
          border: const OutlineInputBorder(),
          alignLabelWithHint: maxLines > 1,
        ),
        validator: required
            ? (v) => (v == null || v.trim().isEmpty) ? 'Campo requerido' : null
            : null,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<DocumentProvider>();

    String generatedNumber = widget.document?.documentNumber ?? '';
    if (!isEdit) {
      final nextSequence = provider.documents.length + 1;
      final currentYear = DateTime.now().year;
      generatedNumber =
          "${_selectedType.substring(0, 3).toUpperCase()}-$currentYear-${nextSequence.toString().padLeft(3, '0')}";
    }

    final document = AppDocument(
      id: widget.document?.id ?? DateTime.now().millisecondsSinceEpoch,
      documentNumber: generatedNumber,
      type: _selectedType,
      title: _titleCtrl.text.trim(),
      content: _contentCtrl.text.trim(),
      studentId: widget.document?.studentId ?? 3,
      sender: widget.document?.sender ?? "Edison Tituaña",
      receiver: _selectedDepartment == 'Secretaría'
          ? 'Secretaría Académica'
          : 'Coordinación de Carrera',
      department: _selectedDepartment,
      status: widget.document?.status ?? "En revisión",
      priority: _selectedPriority,
      createdAt: widget.document?.createdAt ?? DateTime.now(),
      approvalDate: widget.document?.approvalDate,
      attachmentUrl: widget.document?.attachmentUrl ?? '',
    );

    isEdit ? provider.updateDocument(document) : provider.addDocument(document);

    Navigator.pop(context, true);
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
        icon: const Icon(Icons.send),
        label: const Text(
          'ENVIAR TRÁMITE DOCUMENTAL',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
