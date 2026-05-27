import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

          return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: isMobile ? 24 : 80,
          right: isMobile ? 24 : 80,
          top: 120,
          bottom: isMobile ? 60 : 120,
        ),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.6, -0.4),
          radius: 1.2,
          colors: [
            Color(0xFF001A2E),
            Color(0xFF050A0F),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background grid
          Positioned.fill(child: _GridBackground()),
          // Glow orb
          Positioned(
            top: -100,
            right: isMobile ? -100 : 0,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00FFD1).withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              // Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xFF00FFD1).withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF00FFD1).withOpacity(0.05),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF00FFD1),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Available for projects",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        color: const Color(0xFF00FFD1),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),

              const SizedBox(height: 28),

              // Name
              Text(
                "RJ Salundaga",
                style: GoogleFonts.orbitron(
                  fontSize: isMobile ? 38 : 72,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.1,
                  letterSpacing: isMobile ? 1 : 2,
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),

              const SizedBox(height: 16),

              // Animated tagline
              Row(
                children: [
                  Text(
                    "I ",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isMobile ? 20 : 28,
                      color: Colors.white54,
                    ),
                  ),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "build real-world apps.",
                        textStyle: GoogleFonts.spaceGrotesk(
                          fontSize: isMobile ? 20 : 28,
                          color: const Color(0xFF00FFD1),
                          fontWeight: FontWeight.w700,
                        ),
                        speed: const Duration(milliseconds: 80),
                      ),
                      TypewriterAnimatedText(
                        "solve problems with code.",
                        textStyle: GoogleFonts.spaceGrotesk(
                          fontSize: isMobile ? 20 : 28,
                          color: const Color(0xFF0066FF),
                          fontWeight: FontWeight.w700,
                        ),
                        speed: const Duration(milliseconds: 80),
                      ),
                      TypewriterAnimatedText(
                        "ship things that matter.",
                        textStyle: GoogleFonts.spaceGrotesk(
                          fontSize: isMobile ? 20 : 28,
                          color: const Color(0xFF00FFD1),
                          fontWeight: FontWeight.w700,
                        ),
                        speed: const Duration(milliseconds: 80),
                      ),
                    ],
                  ),
                ],
              ).animate().fadeIn(delay: 600.ms),

              const SizedBox(height: 32),

              // Bio
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  "3rd year IT student. I've built different systems, such as, hospital management systems, wellness apps, AI-powered research tools, and joined different contests such as CodeFests and Hackathons. I just love turning ideas into working software.",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: isMobile ? 15 : 18,
                    color: Colors.white54,
                    height: 1.7,
                  ),
                ),
              ).animate().fadeIn(delay: 800.ms),

              const SizedBox(height: 48),

              // CTAs
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _GlowButton(
                    label: "View Projects",
                    isPrimary: true,
                    onTap: onViewProjects,
                  ),
                  _GlowButton(
                    label: "Contact Me",
                    isPrimary: true,
                    onTap: onContact,
                  ),
                ],
              ).animate().fadeIn(delay: 1000.ms),

              const SizedBox(height: 80),

              // Stats row
              // Stats row
          // Stats row
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Wrap(
                    spacing: 32,
                    runSpacing: 20,
                    children: [
                      _StatItem("5+", "Projects Shipped"),
                      _StatItem("7+", "Joined Competitions"),
                      _StatItem("3rd", "Year IT Student"),
                    ],
                  ),
                ).animate().fadeIn(delay: 1200.ms),
            ],
          ),
        ],
      ),
    );
  }
}

class _GridBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GridPainter(),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00FFD1).withOpacity(0.03)
      ..strokeWidth = 1;

    const spacing = 60.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GlowButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _GlowButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<_GlowButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_hovered
                    ? const Color(0xFF00FFD1)
                    : const Color(0xFF00FFD1).withOpacity(0.1))
                : Colors.transparent,
            border: Border.all(
              color: widget.isPrimary
                  ? const Color(0xFF00FFD1)
                  : Colors.white24,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered && widget.isPrimary
                ? [
                    BoxShadow(
                      color: const Color(0xFF00FFD1).withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: widget.isPrimary
                  ? (_hovered ? Colors.black : const Color(0xFF00FFD1))
                  : Colors.white70,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.orbitron(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF00FFD1),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            color: Colors.white38,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
