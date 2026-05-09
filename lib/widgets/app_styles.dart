import 'dart:ui';

import 'package:flutter/material.dart';

BoxDecoration panelDecoration() {
  return BoxDecoration(
    color: const Color(0xFF111412).withValues(alpha: 0.94),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.52),
        blurRadius: 42,
        offset: const Offset(0, 24),
      ),
    ],
  );
}

InputDecoration inputDecoration({
  required String label,
  required IconData icon,
}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon),
    filled: true,
    fillColor: const Color(0xFF0F1210).withValues(alpha: 0.94),
    labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.62)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.55)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
  );
}

class LiquidGlassField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;

  const LiquidGlassField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.34)),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.16),
                blurRadius: 22,
                spreadRadius: -12,
                offset: const Offset(0, -2),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.22),
                blurRadius: 24,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(
                icon,
                color: Colors.white.withValues(alpha: 0.8),
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.04),
              labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
              floatingLabelStyle: const TextStyle(color: Colors.white),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class HoverGlowSurface extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final Color color;
  final Color hoverColor;
  final Color borderColor;
  final Color hoverBorderColor;
  final Color glowColor;

  const HoverGlowSurface({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(18)),
    this.color = Colors.transparent,
    this.hoverColor = const Color(0xFF1A1E1B),
    this.borderColor = Colors.transparent,
    this.hoverBorderColor = const Color(0x55FFFFFF),
    this.glowColor = const Color(0x66FFFFFF),
  });

  @override
  State<HoverGlowSurface> createState() => _HoverGlowSurfaceState();
}

class _HoverGlowSurfaceState extends State<HoverGlowSurface> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: isHovered ? widget.hoverColor : widget.color,
            borderRadius: widget.borderRadius,
            border: Border.all(
              color: isHovered ? widget.hoverBorderColor : widget.borderColor,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: widget.glowColor,
                      blurRadius: 20,
                      spreadRadius: -8,
                    ),
                  ]
                : const [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
