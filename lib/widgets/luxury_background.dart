import 'dart:ui';
import 'package:flutter/material.dart';

class LuxuryBackground extends StatelessWidget {
  final Widget child;

  const LuxuryBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF030404),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF101313), Color(0xFF050606), Color(0xFF000000)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -220,
            left: -160,
            right: -160,
            child: Container(
              height: 480,
              decoration: BoxDecoration(
                color: const Color(0xFF233136).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(500),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3F5A60).withValues(alpha: 0.12),
                    blurRadius: 110,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 58,
            left: 42,
            right: 42,
            child: Center(
              child: Container(
                height: 1,
                color: Colors.white.withValues(alpha: 0.045),
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
              child: Container(color: Colors.transparent),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
