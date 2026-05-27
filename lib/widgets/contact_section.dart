import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _sending = false;
  bool _sent = false;

  Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;
  setState(() => _sending = true);
  try {
    final response = await http.post(
      Uri.parse('https://rj-portfolio-backend-3dpq.onrender.com/api/contact'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': _nameController.text,
        'email': _emailController.text,
        'message': _messageController.text,
      }),
    );
    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      setState(() { _sending = false; _sent = true; });
    } else {
      setState(() => _sending = false);
    }
  } catch (e) {
    setState(() => _sending = false);
  }
}

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF050A0F), Color(0xFF001A2E)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel("CONTACT"),
          const SizedBox(height: 12),
          Text(
            "Let's Work Together",
            style: GoogleFonts.orbitron(
              fontSize: isMobile ? 28 : 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Got a project? Let's talk.",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              color: Colors.white38,
            ),
          ),
          const SizedBox(height: 60),


          
                Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: _sent ? _SuccessMessage() : _ContactForm(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    messageController: _messageController,
                    sending: _sending,
                    onSubmit: _submit,
                  ).animate().fadeIn(delay: 200.ms),
                ),
                ),

          const SizedBox(height: 80),

          // Footer
          Divider(color: Colors.white.withOpacity(0.06)),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "RJ",
                      style: GoogleFonts.orbitron(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF00FFD1),
                      ),
                    ),
                    TextSpan(
                      text: ".dev",
                      style: GoogleFonts.orbitron(
                        fontSize: 12,
                        color: Colors.white24,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "© 2026 RJ Salundaga",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  color: Colors.white24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final bool sending;
  final VoidCallback onSubmit;

  const _ContactForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.sending,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InputField(
            label: "Your Name",
            controller: nameController,
            validator: (v) => v!.isEmpty ? "Name is required" : null,
          ),
          const SizedBox(height: 20),
          _InputField(
            label: "Your Email",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v!.isEmpty) return "Email is required";
              if (!v.contains('@')) return "Enter a valid email";
              return null;
            },
          ),
          const SizedBox(height: 20),
          _InputField(
            label: "Message",
            controller: messageController,
            maxLines: 5,
            validator: (v) => v!.isEmpty ? "Message is required" : null,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: _SendButton(sending: sending, onTap: onSubmit),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _InputField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 13,
            color: Colors.white54,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF0D1117),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF00FFD1), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}

class _SendButton extends StatefulWidget {
  final bool sending;
  final VoidCallback onTap;
  const _SendButton({required this.sending, required this.onTap});

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.sending ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _hovered && !widget.sending
                ? const Color(0xFF00FFD1)
                : const Color(0xFF00FFD1).withOpacity(0.1),
            border: Border.all(color: const Color(0xFF00FFD1)),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF00FFD1).withOpacity(0.25),
                      blurRadius: 20,
                    )
                  ]
                : [],
          ),
          child: Center(
            child: widget.sending
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Color(0xFF00FFD1),
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    "Send Message",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _hovered ? Colors.black : const Color(0xFF00FFD1),
                      letterSpacing: 1,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _SuccessMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF00FFD1).withOpacity(0.3)),
        color: const Color(0xFF00FFD1).withOpacity(0.05),
      ),
      child: Column(
        children: [
          const Text("✔️", style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            "Message Sent!",
            style: GoogleFonts.orbitron(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF00FFD1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Thanks for reaching out. I'll get back to you soon.",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              color: Colors.white54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9));
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
