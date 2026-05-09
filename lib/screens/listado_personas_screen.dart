import 'package:flutter/material.dart';
import '../models/persona.dart';

class ListadoPersonasScreen extends StatelessWidget {
  final List<Persona> personas;

  const ListadoPersonasScreen({super.key, required this.personas});

  @override
  Widget build(BuildContext context) {
    if (personas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 80,
              color: Colors.white.withValues(alpha: 0.25),
            ),
            const SizedBox(height: 18),
            const Text(
              'No hay personas registradas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Registra una persona para verla en el ListView.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.45)),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Listado de personas',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Personas registradas en memoria durante la sesión.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.48)),
        ),
        const SizedBox(height: 22),
        Expanded(
          child: ListView.builder(
            itemCount: personas.length,
            itemBuilder: (context, index) {
              final persona = personas[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.045),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      child: Text(
                        persona.nombre.isNotEmpty
                            ? persona.nombre[0].toUpperCase()
                            : '?',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${persona.nombre} ${persona.apellidos}',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            persona.correo,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.45),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      persona.telefono,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
