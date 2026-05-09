import 'package:flutter/material.dart';

import '../widgets/app_styles.dart';

class MenuPrincipalScreen extends StatelessWidget {
  final int totalPersonas;
  final Function(int) onSelect;

  const MenuPrincipalScreen({
    super.key,
    required this.totalPersonas,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gestiona personas con claridad',
            style: TextStyle(
              fontSize: 42,
              height: 1,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Administra personas desde una experiencia oscura, precisa y minimalista.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.62),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: [
              dashboardCard(
                icon: Icons.person_add_alt_1_outlined,
                title: 'Registrar persona',
                subtitle: 'Formulario con 5 campos y botón guardar.',
                onTap: () => onSelect(1),
              ),
              dashboardCard(
                icon: Icons.list_alt_outlined,
                title: 'Listado',
                subtitle: '$totalPersonas personas registradas.',
                onTap: () => onSelect(2),
              ),
              dashboardCard(
                icon: Icons.account_circle_outlined,
                title: 'Profile',
                subtitle: 'Nombre, apellidos y fecha de nacimiento.',
                onTap: () => onSelect(3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dashboardCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return HoverGlowSurface(
      onTap: onTap,
      padding: const EdgeInsets.all(22),
      borderRadius: BorderRadius.circular(22),
      color: Colors.white.withValues(alpha: 0.035),
      hoverColor: Colors.white.withValues(alpha: 0.075),
      borderColor: Colors.white.withValues(alpha: 0.08),
      hoverBorderColor: Colors.white.withValues(alpha: 0.24),
      glowColor: Colors.white.withValues(alpha: 0.18),
      child: SizedBox(
        width: 236,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              child: Icon(icon, size: 20),
            ),
            const SizedBox(height: 28),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.46),
                fontSize: 12,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'ACCIÓN',
              style: TextStyle(
                color: Color(0xFFE07769),
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
