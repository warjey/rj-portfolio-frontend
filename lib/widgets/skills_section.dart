import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/portfolio_data.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      color: const Color(0xFF080E14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel("SKILLS"),
          const SizedBox(height: 12),
          Text(
            "My Toolkit",
            style: GoogleFonts.orbitron(
              fontSize: isMobile ? 28 : 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Technologies and tools I work with.",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              color: Colors.white38,
            ),
          ),
          const SizedBox(height: 60),

          // Achievements
          Text(
            "Highlights",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              color: Colors.white38,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
                      LayoutBuilder(builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              if (isWide) {
                return IntrinsicHeight(
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: PortfolioData.achievements.asMap().entries.map((e) {
                                  final a = e.value;
                                  return Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: e.key < PortfolioData.achievements.length - 1 ? 16 : 0,
                                      ),
                                      child: _AchievementCard(
                                        icon: a['icon']!,
                                        title: a['title']!,
                                        desc: a['desc']!,
                                      ).animate().fadeIn(delay: (100 * e.key).ms),
                                    ),
                                  );
                                }).toList(),
                              ),
                              );
              } else {
                return Column(
                  children: PortfolioData.achievements.asMap().entries.map((e) {
                    final a = e.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _AchievementCard(
                        icon: a['icon']!,
                        title: a['title']!,
                        desc: a['desc']!,
                      ).animate().fadeIn(delay: (100 * e.key).ms),
                    );
                  }).toList(),
                );
              }
            }),

          const SizedBox(height: 60),

          // Skills grid
          Text(
            "Technologies",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              color: Colors.white38,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: PortfolioData.skills.asMap().entries.map((e) {
              return _SkillBadge(e.value)
                  .animate()
                  .fadeIn(delay: (50 * e.key).ms)
                  .scale(begin: const Offset(0.8, 0.8));
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;

  const _AchievementCard({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF00FFD1).withOpacity(0.15)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF00FFD1).withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                color: Colors.white54,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
    );
  }
}

class _SkillBadge extends StatefulWidget {
  final String skill;
  const _SkillBadge(this.skill);

  @override
  State<_SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<_SkillBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered
                ? const Color(0xFF00FFD1).withOpacity(0.6)
                : Colors.white.withOpacity(0.08),
          ),
          color: _hovered
              ? const Color(0xFF00FFD1).withOpacity(0.08)
              : const Color(0xFF0D1117),
        ),
        child: Text(
          widget.skill,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _hovered ? const Color(0xFF00FFD1) : Colors.white60,
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 3, height: 16, color: const Color(0xFF00FFD1)),
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.orbitron(
            fontSize: 12,
            color: const Color(0xFF00FFD1),
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}
