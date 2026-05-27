import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/portfolio_data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      color: const Color(0xFF0D1117),
      child: isMobile
          ? _MobileLayout()
          : _DesktopLayout(),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _AboutText()),
        const SizedBox(width: 80),
        Expanded(flex: 4, child: _AboutVisual()),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AboutText(),
        const SizedBox(height: 48),
        _AboutVisual(),
      ],
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 3, height: 16, color: const Color(0xFF00FFD1)),
            const SizedBox(width: 10),
            Text(
              "ABOUT",
              style: GoogleFonts.orbitron(
                fontSize: 12,
                color: const Color(0xFF00FFD1),
                letterSpacing: 3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Who I Am",
          style: GoogleFonts.orbitron(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 24),
        Text(
          PortfolioData.bio,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            color: Colors.white60,
            height: 1.8,
          ),
        ).animate().fadeIn(delay: 300.ms),
        const SizedBox(height: 32),
        Text(
          "Currently studying Information Technology and building projects that actually matter. "
          "I love the challenge of turning complex problems into clean, working code.",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            color: Colors.white38,
            height: 1.8,
          ),
        ).animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 40),
        _InfoRow("📍", "Philippines"),
        const SizedBox(height: 12),
        _InfoRow("🎓", "IT Student"),
        const SizedBox(height: 12),
        _InfoRow("💻", "Web · Mobile · Desktop · AI"),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String emoji;
  final String text;
  const _InfoRow(this.emoji, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}

class _AboutVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D1A26), Color(0xFF050A0F)],
        ),
        border: Border.all(color: const Color(0xFF00FFD1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar placeholder
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF00FFD1), Color(0xFF0066FF)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00FFD1).withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
                          child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.8, 0.8)),
          const SizedBox(height: 24),
          Center(
            child: Text(
              "RJ Salundaga",
              style: GoogleFonts.orbitron(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              "IT Student · Web Developer",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 13,
                color: Colors.white38,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Divider(color: Colors.white),
          const SizedBox(height: 24),
          // Code snippet style card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFF050A0F),
              border: Border.all(color: Colors.white.withOpacity(0.04)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CodeLine("const", "rj", "= {"),
                _CodeLine("  role:", null, '" Web Developer"'),
                _CodeLine("  year:", null, '"IT Student"'),
                _CodeLine("  passion:", null, '"Building things"'),
                _CodeLine("  status:", null, '"Open to work"'),
                _CodeLine("}", null, null),
              ],
            ),
          ).animate().fadeIn(delay: 600.ms),
        ],
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  final String keyword;
  final String? varName;
  final String? value;

  const _CodeLine(this.keyword, this.varName, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.sourceCodePro(fontSize: 13),
          children: [
            TextSpan(
                text: keyword,
                style: const TextStyle(color: Color(0xFF0066FF))),
            if (varName != null)
              TextSpan(
                  text: " $varName",
                  style: const TextStyle(color: Color(0xFF00FFD1))),
            if (value != null)
              TextSpan(
                  text: " $value",
                  style: const TextStyle(color: Colors.white38)),
          ],
        ),
      ),
    );
  }
}
