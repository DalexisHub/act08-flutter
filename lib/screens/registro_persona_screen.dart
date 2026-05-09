import 'package:flutter/material.dart';
import '../models/persona.dart';
import '../widgets/app_styles.dart';

class RegistroPersonaScreen extends StatefulWidget {
  final Function(Persona) onGuardar;

  const RegistroPersonaScreen({super.key, required this.onGuardar});

  @override
  State<RegistroPersonaScreen> createState() => _RegistroPersonaScreenState();
}

class _RegistroPersonaScreenState extends State<RegistroPersonaScreen> {
  final formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final apellidosController = TextEditingController();
  final fechaController = TextEditingController();
  final correoController = TextEditingController();
  final telefonoController = TextEditingController();

  Future<void> seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: DateTime(2000),
    );

    if (fecha != null) {
      final year = fecha.year.toString();
      final month = fecha.month.toString().padLeft(2, '0');
      final day = fecha.day.toString().padLeft(2, '0');

      setState(() {
        fechaController.text = '$day/$month/$year';
      });
    }
  }

  void guardar() {
    if (formKey.currentState!.validate()) {
      final persona = Persona(
        nombre: nombreController.text.trim(),
        apellidos: apellidosController.text.trim(),
        fechaNacimiento: fechaController.text.trim(),
        correo: correoController.text.trim(),
        telefono: telefonoController.text.trim(),
      );

      widget.onGuardar(persona);

      nombreController.clear();
      apellidosController.clear();
      fechaController.clear();
      correoController.clear();
      telefonoController.clear();
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    apellidosController.dispose();
    fechaController.dispose();
    correoController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registro de personas',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Completa los 5 campos solicitados y guarda la información.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.48)),
                ),
                const SizedBox(height: 28),
                TextFormField(
                  controller: nombreController,
                  decoration: inputDecoration(
                    label: 'Nombre',
                    icon: Icons.person_outline,
                  ),
                  validator: validarCampo,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: apellidosController,
                  decoration: inputDecoration(
                    label: 'Apellidos',
                    icon: Icons.badge_outlined,
                  ),
                  validator: validarCampo,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: fechaController,
                  readOnly: true,
                  onTap: seleccionarFecha,
                  decoration: inputDecoration(
                    label: 'Fecha de nacimiento',
                    icon: Icons.calendar_month_outlined,
                  ),
                  validator: validarCampo,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: correoController,
                  decoration: inputDecoration(
                    label: 'Correo',
                    icon: Icons.email_outlined,
                  ),
                  validator: validarCampo,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: telefonoController,
                  decoration: inputDecoration(
                    label: 'Teléfono',
                    icon: Icons.phone_outlined,
                  ),
                  validator: validarCampo,
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: guardar,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text(
                      'Guardar persona',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validarCampo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }
}
