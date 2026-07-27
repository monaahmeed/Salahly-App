import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class UploadIdBox extends StatefulWidget {
  const UploadIdBox({super.key, required this.onTap, this.fileName});
  final VoidCallback onTap;
  final String? fileName;

  @override
  State<UploadIdBox> createState() => _UploadIdBoxState();
}

class _UploadIdBoxState extends State<UploadIdBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool hasFile = widget.fileName != null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            color: hasFile
                ? Colors.green.shade50
                : (_isHovered
                    ? AppTheme.accentAmber.withOpacity(0.05)
                    : Colors.amber.shade50.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasFile
                  ? Colors.green
                  : (_isHovered
                      ? AppTheme.accentAmber
                      : AppTheme.accentAmber.withOpacity(0.5)),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: hasFile
                      ? Colors.green.withOpacity(0.15)
                      : AppTheme.accentAmber.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  hasFile ? Icons.check_circle_outline_rounded : Icons.cloud_upload_outlined,
                  color: hasFile ? Colors.green : AppTheme.accentAmber,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.fileName ?? 'upload_id_title'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: hasFile ? Colors.green.shade900 : AppTheme.primaryNavy,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                hasFile ? 'اضغط للتغيير' : 'upload_id_subtitle'.tr(),
                style: TextStyle(
                  fontSize: 12,
                  color: hasFile ? Colors.green.shade700 : AppTheme.slate500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}