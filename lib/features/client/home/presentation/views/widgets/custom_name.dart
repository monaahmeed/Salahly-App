import 'package:flutter/widgets.dart';
import 'package:salahly/core/theme/app_theme.dart';

class CustomName extends StatelessWidget {
  const CustomName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hello, Mona',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'What needs fixing in your home today?',
          style: TextStyle(fontSize: 14, color: AppTheme.slate600),
        ),
      ],
    );
  }
}
