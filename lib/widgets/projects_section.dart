import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/portfolio_data.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      color: const Color(0xFF050A0F),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel("PROJECTS"),
          const SizedBox(height: 12),
          Text(
            "Things I've Built",
            style: GoogleFonts.orbitron(
              fontSize: isMobile ? 28 : 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Real apps, real problems, real solutions.",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              color: Colors.white38,
            ),
          ),
          const SizedBox(height: 60),

          // Featured project (AXIOMA)
          _FeaturedProjectCard(project: PortfolioData.projects[0])
              .animate()
              .fadeIn(delay: 200.ms)
              .slideY(begin: 0.2),

          const SizedBox(height: 32),

          // Grid of other projects
          // Grid of other projects
            LayoutBuilder(builder: (context, constraints) {
              final isWide = constraints.maxWidth > 800;
              if (isWide) {
                // Two column wrap for desktop
                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(
                    PortfolioData.projects.length - 1,
                    (index) => SizedBox(
                      width: (constraints.maxWidth - 20) / 2,
                      child: _ProjectCard(
                        project: PortfolioData.projects[index + 1],
                      ).animate().fadeIn(delay: (300 + index * 100).ms).slideY(begin: 0.2),
                    ),
                  ),
                );
              } else {
                // Single column for mobile — no fixed height, just stacks
                return Column(
                  children: List.generate(
                    PortfolioData.projects.length - 1,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _ProjectCard(
                        project: PortfolioData.projects[index + 1],
                      ).animate().fadeIn(delay: (300 + index * 100).ms).slideY(begin: 0.2),
                    ),
                  ),
                );
              }
            }),
        ],
      ),
    );
  }
}

class _FeaturedProjectCard extends StatefulWidget {
  final Project project;
  const _FeaturedProjectCard({required this.project});

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? const Color(0xFF00FFD1).withOpacity(0.5)
                : const Color(0xFF00FFD1).withOpacity(0.15),
            width: 1.5,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF001A2E).withOpacity(_hovered ? 0.9 : 0.6),
              const Color(0xFF0D1117),
            ],
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF00FFD1).withOpacity(0.1),
                    blurRadius: 30,
                    spreadRadius: 5,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(widget.project.emoji,
                    style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFD1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: const Color(0xFF00FFD1).withOpacity(0.3)),
                      ),
                      child: Text(
                        "FEATURED",
                        style: GoogleFonts.orbitron(
                          fontSize: 10,
                          color: const Color(0xFF00FFD1),
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.project.category,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              widget.project.title,
              style: GoogleFonts.orbitron(
                fontSize: isMobile ? 20 : 28,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.project.description,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15,
                color: Colors.white60,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project.technologies
                  .map((tech) => _TechChip(tech))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? Colors.white24
                : Colors.white.withOpacity(0.06),
          ),
          color: _hovered
              ? const Color(0xFF0D1117)
              : const Color(0xFF080E14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.project.emoji,
                    style: const TextStyle(fontSize: 24)),
                Flexible(
                  child: Text(
                    widget.project.category,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 11,
                      color: Colors.white38,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.project.title,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              widget.project.description,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                color: Colors.white38,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.project.technologies
                  .take(3)
                  .map((tech) => _TechChip(tech, small: true))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  final bool small;

  const _TechChip(this.label, {this.small = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: small ? 8 : 12, vertical: small ? 4 : 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xFF0066FF).withOpacity(0.1),
        border:
            Border.all(color: const Color(0xFF0066FF).withOpacity(0.25)),
      ),
      child: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontSize: small ? 11 : 12,
          color: const Color(0xFF4D94FF),
          fontWeight: FontWeight.w500,
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
        Container(
          width: 3,
          height: 16,
          color: const Color(0xFF00FFD1),
        ),
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
