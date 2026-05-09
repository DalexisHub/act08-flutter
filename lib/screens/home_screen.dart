import 'package:flutter/material.dart';

import '../models/persona.dart';
import '../widgets/app_styles.dart';
import '../widgets/luxury_background.dart';

import 'listado_personas_screen.dart';
import 'menu_principal_screen.dart';
import 'profile_screen.dart';
import 'registro_persona_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class MenuOption {
  final String title;
  final IconData icon;

  MenuOption(this.title, this.icon);
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Persona> personas = [];

  final List<MenuOption> menuOptions = [
    MenuOption('Panel principal', Icons.grid_view_rounded),
    MenuOption('Registro', Icons.person_add_alt_rounded),
    MenuOption('Directorio', Icons.view_list_rounded),
    MenuOption('Perfil reciente', Icons.account_circle_rounded),
  ];

  void guardarPersona(Persona persona) {
    setState(() {
      personas.add(persona);
      selectedIndex = 2;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Persona registrada correctamente'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void cerrarSesion() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Widget obtenerPantalla() {
    switch (selectedIndex) {
      case 1:
        return RegistroPersonaScreen(onGuardar: guardarPersona);
      case 2:
        return ListadoPersonasScreen(personas: personas);
      case 3:
        return ProfileScreen(
          persona: personas.isNotEmpty ? personas.last : null,
        );
      default:
        return MenuPrincipalScreen(
          totalPersonas: personas.length,
          onSelect: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      drawer: isWide
          ? null
          : Drawer(
              backgroundColor: const Color(0xFF151512),
              child: SafeArea(
                child: _WorkspaceSidebar(
                  selectedIndex: selectedIndex,
                  totalPersonas: personas.length,
                  menuOptions: menuOptions,
                  onSelect: (index) {
                    setState(() => selectedIndex = index);
                    Navigator.pop(context);
                  },
                  onLogout: cerrarSesion,
                ),
              ),
            ),
      body: LuxuryBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1160),
                decoration: BoxDecoration(
                  color: const Color(0xFF121210),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.58),
                      blurRadius: 48,
                      offset: const Offset(0, 28),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Row(
                    children: [
                      if (isWide)
                        _WorkspaceSidebar(
                          selectedIndex: selectedIndex,
                          totalPersonas: personas.length,
                          menuOptions: menuOptions,
                          onSelect: (index) {
                            setState(() => selectedIndex = index);
                          },
                          onLogout: cerrarSesion,
                        ),
                      Expanded(
                        child: _WorkspaceContent(
                          isWide: isWide,
                          selectedTitle: menuOptions[selectedIndex].title,
                          child: obtenerPantalla(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkspaceSidebar extends StatelessWidget {
  final int selectedIndex;
  final int totalPersonas;
  final List<MenuOption> menuOptions;
  final ValueChanged<int> onSelect;
  final VoidCallback onLogout;

  const _WorkspaceSidebar({
    required this.selectedIndex,
    required this.totalPersonas,
    required this.menuOptions,
    required this.onSelect,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: const EdgeInsets.fromLTRB(26, 24, 24, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF151512).withValues(alpha: 0.98),
        border: Border(
          right: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.people_alt_rounded,
                  color: Color(0xFF151512),
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'Nexo Personas',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ),
              Icon(
                Icons.unfold_more_rounded,
                color: Colors.white.withValues(alpha: 0.46),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Divider(color: Colors.white.withValues(alpha: 0.06)),
          const SizedBox(height: 22),
          const _SectionLabel('GESTIÓN'),
          const SizedBox(height: 12),
          ...List.generate(menuOptions.length, (index) {
            final option = menuOptions[index];
            return _SidebarItem(
              title: option.title,
              icon: option.icon,
              selected: selectedIndex == index,
              onTap: () => onSelect(index),
            );
          }),
          const SizedBox(height: 18),
          Divider(color: Colors.white.withValues(alpha: 0.06)),
          const SizedBox(height: 22),
          const _SectionLabel('RESUMEN'),
          const SizedBox(height: 12),
          _SidebarMetric(
            icon: Icons.how_to_reg_rounded,
            label: 'Personas guardadas',
            value: '$totalPersonas',
          ),
          const Spacer(),
          HoverGlowSurface(
            onTap: onLogout,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            borderRadius: BorderRadius.circular(18),
            color: Colors.white.withValues(alpha: 0.035),
            hoverColor: Colors.white.withValues(alpha: 0.075),
            borderColor: Colors.white.withValues(alpha: 0.06),
            hoverBorderColor: Colors.white.withValues(alpha: 0.2),
            glowColor: Colors.white.withValues(alpha: 0.16),
            child: Row(
              children: [
                Icon(
                  Icons.logout_rounded,
                  color: Colors.white.withValues(alpha: 0.74),
                ),
                const SizedBox(width: 12),
                Text(
                  'Cerrar sesión',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.72)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkspaceContent extends StatelessWidget {
  final bool isWide;
  final String selectedTitle;
  final Widget child;

  const _WorkspaceContent({
    required this.isWide,
    required this.selectedTitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 0, 0, 0), Color(0xFF090909)],
          stops: [0, 0.42, 1],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -140,
            right: -100,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(260),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              isWide ? 44 : 22,
              28,
              isWide ? 44 : 22,
              28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (!isWide)
                      Builder(
                        builder: (context) {
                          return IconButton(
                            onPressed: () => Scaffold.of(context).openDrawer(),
                            icon: const Icon(Icons.menu_rounded),
                          );
                        },
                      ),
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white.withValues(alpha: 0.88),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      selectedTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 740),
                      child: Container(
                        padding: const EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.28),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.28),
                              blurRadius: 34,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.22),
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: HoverGlowSurface(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        borderRadius: BorderRadius.circular(18),
        color: selected
            ? Colors.white.withValues(alpha: 0.065)
            : Colors.transparent,
        hoverColor: Colors.white.withValues(alpha: 0.08),
        borderColor: selected
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.transparent,
        hoverBorderColor: Colors.white.withValues(alpha: 0.1),
        glowColor: Colors.transparent,
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: Colors.white.withValues(alpha: selected ? 0.94 : 0.48),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                color: Colors.white.withValues(alpha: selected ? 0.96 : 0.46),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SidebarMetric({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.035),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.5)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.46)),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
