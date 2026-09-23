import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly/core/services/app_router.dart';
import 'package:salahly/core/theme/app_theme.dart';

class RatingBottomSheet extends StatefulWidget {
  final String technicianName;
  final String? technicianImageUrl;
  final Function(int rating, String comment)? onSubmit;

  const RatingBottomSheet({
    super.key,
    required this.technicianName,
    this.technicianImageUrl,
    this.onSubmit,
  });

  
  static Future<void> show(
    BuildContext context, {
    required String technicianName,
    String? technicianImageUrl,
    Function(int rating, String comment)? onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => RatingBottomSheet(
        technicianName: technicianName,
        technicianImageUrl: technicianImageUrl,
        onSubmit: (rating, comment) {
        
        Navigator.pop(modalContext);

        
        if (context.mounted) {
          context.go(AppRouter.kHomeView); 
        }
      },
      ),
    );
  }

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  int _selectedRating = 5;
  final TextEditingController _commentController = TextEditingController();

  bool get _isValidImageUrl {
    if (widget.technicianImageUrl == null) return false;
    final trimmed = widget.technicianImageUrl!.trim();
    return trimmed.isNotEmpty &&
        (trimmed.startsWith('http://') || trimmed.startsWith('https://'));
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + bottomPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            
            CircleAvatar(
              radius: 36,
              backgroundColor: const Color(0xFFE2E8F0),
              backgroundImage: _isValidImageUrl
                  ? NetworkImage(widget.technicianImageUrl!.trim())
                  : null,
              onBackgroundImageError: _isValidImageUrl ? (_, __) {} : null,
              child: !_isValidImageUrl
                  ? const Icon(Icons.person, size: 36, color: Color(0xFF64748B))
                  : null,
            ),
            const SizedBox(height: 12),
            Text(
              widget.technicianName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'rate_service_prompt'.tr(),
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.slate500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starValue = index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedRating = starValue);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      starValue <= _selectedRating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: starValue <= _selectedRating
                          ? const Color(0xFFFFB800)
                          : Colors.grey.shade300,
                      size: 40,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            
            TextField(
              controller: _commentController,
              maxLines: 3,
              maxLength: 250,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'write_feedback_hint'.tr(),
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppTheme.primaryNavy),
                ),
              ),
            ),
            const SizedBox(height: 16),

           
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.onSubmit != null) {
                    widget.onSubmit!(
                      _selectedRating,
                      _commentController.text.trim(),
                    );
                  }
                 // Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryNavy,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'submit_rating'.tr(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}