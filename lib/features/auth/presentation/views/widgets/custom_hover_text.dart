import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class CustomHoverText extends StatefulWidget {
  final String mainText;
  final String actionText;
  final VoidCallback onTap;
  final Color activeColor;

  const CustomHoverText({
    super.key,
    required this.mainText,
    required this.actionText,
    required this.onTap,
    this.activeColor = const Color(0xFFF59E0B), 
  });

  @override
  State<CustomHoverText> createState() => _CustomHoverTextState();
}

class _CustomHoverTextState extends State<CustomHoverText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 14, fontFamily: 'PlusJakartaSans'),
            children: [
              TextSpan(
                text: widget.mainText,
                style: TextStyle(color: AppTheme.slate600),
              ),
              TextSpan(
                text: widget.actionText,
                style: TextStyle(
                  color: widget.activeColor,
                  fontWeight: FontWeight.bold,
                  decoration: _isHovered ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}