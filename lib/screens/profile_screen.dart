import 'package:flutter/material.dart';
import '../models/persona.dart';

class ProfileScreen extends StatelessWidget {
  final Persona? persona;

  const ProfileScreen({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    final nombre = persona?.nombre ?? 'Sin registrar';
    final apellidos = persona?.apellidos ?? 'Sin registrar';
    final fechaNacimiento = persona?.fechaNacimiento ?? 'Sin registrar';

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.045),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 46,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Icon(Icons.person, size: 48),
              ),
              const SizedBox(height: 22),
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Datos principales de la última persona registrada.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.45)),
              ),
              const SizedBox(height: 28),
              profileLabel('Nombre', nombre),
              profileLabel('Apellidos', apellidos),
              profileLabel('Fecha de nacimiento', fechaNacimiento),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileLabel(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.45)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
