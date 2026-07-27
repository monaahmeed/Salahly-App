import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salahly/core/theme/app_theme.dart';


class SocialAuthButton extends StatefulWidget {
  final String text;
  final FaIconData icon;
  final Color? iconColor;
  final VoidCallback onPressed;

  const SocialAuthButton({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor,
    required this.onPressed,
  });

  @override
  State<SocialAuthButton> createState() => _SocialAuthButtonState();
}

class _SocialAuthButtonState extends State<SocialAuthButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Material(
        color: Colors.transparent, 
        child: Ink(
          decoration: BoxDecoration(
            
            color: _isHovered ? Colors.grey.shade200 : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(16),
            splashColor: AppTheme.primaryNavy.withOpacity(0.1), 
            highlightColor: Colors.grey.shade200, 
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    widget.icon,
                    size: 20,
                    color: widget.iconColor ?? AppTheme.primaryNavy,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: AppTheme.primaryNavy,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}