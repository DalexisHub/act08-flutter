import 'package:flutter/material.dart';
import '../widgets/luxury_background.dart';
import '../widgets/app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();

  void iniciarSesion() {
    final usuario = usuarioController.text.trim();
    final password = passwordController.text.trim();

    if (usuario == 'admin' && password == '123456') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario o contraseña incorrectos'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    usuarioController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 680;

    return Scaffold(
      body: LuxuryBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1100, minHeight: 560),
              padding: const EdgeInsets.fromLTRB(34, 30, 34, 34),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF9FBFA),
                    Color(0xFFDCE8E8),
                    Color(0xFF0A4952),
                    Color(0xFF06242B),
                  ],
                  stops: [0, 0.43, 0.78, 1],
                ),
                border: Border.all(color: Colors.white.withValues(alpha: 0.34)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.34),
                    blurRadius: 48,
                    offset: const Offset(0, 28),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: const Color(0xFF071E23).withValues(alpha: 0.9),
                        size: 22,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.person_outline,
                        color: const Color(0xFF071E23).withValues(alpha: 0.78),
                        size: 18,
                      ),
                    ],
                  ),
                  SizedBox(height: isWide ? 168 : 82),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.16),
                      ),
                    ),
                    child: const Text(
                      'Gestión web de personas',
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Nexo Personas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 54,
                      height: 1,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'claridad en cada registro',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      height: 1.15,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Registra, consulta y perfila personas desde una interfaz enfocada.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.72),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 420),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF06272D).withValues(alpha: 0.58),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.14),
                      ),
                    ),
                    child: Column(
                      children: [
                        LiquidGlassField(
                          controller: usuarioController,
                          label: 'Usuario',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),
                        LiquidGlassField(
                          controller: passwordController,
                          obscureText: true,
                          label: 'Contraseña',
                          icon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: HoverGlowSurface(
                            onTap: iniciarSesion,
                            padding: EdgeInsets.zero,
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.white,
                            hoverColor: const Color(0xFFF8FCFF),
                            borderColor: Colors.white,
                            hoverBorderColor: Colors.white,
                            glowColor: Colors.white.withValues(alpha: 0.72),
                            child: const Center(
                              child: Text(
                                'Ingresar',
                                style: TextStyle(
                                  color: Color(0xFF06242B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Usuario: admin  |  Contraseña: 123456',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.46),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
