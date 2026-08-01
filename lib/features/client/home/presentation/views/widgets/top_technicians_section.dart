import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/client/home/data/models/technician_model.dart';

import 'technicians_list_view.dart';

class TopTechniciansSection extends StatelessWidget {
  const TopTechniciansSection({super.key});

  @override
  Widget build(BuildContext context) {
   
    final List<TechnicianModel> allTechnicians = [
      TechnicianModel(
        name: 'Omar Haddad',
        specialty: 'Master Plumber',
        rating: 4.9,
        imageUrl: '',
      ),
      TechnicianModel(
        name: 'Layla Karim',
        specialty: 'Electrician',
        rating: 4.9,
        imageUrl: '',
      ),
      TechnicianModel(
        name: 'Yusuf Ali',
        specialty: 'AC Specialist',
        rating: 4.8,
        imageUrl: '',
      ),
      TechnicianModel(
        name: 'Ahmed Hassan',
        specialty: 'Painter',
        rating: 4.7,
        imageUrl: '',
      ),
    ];

    
    final displayedTechnicians = allTechnicians.take(3).toList();

    return Column(
      children: [
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'top_technicians'.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryNavy,
              ),
            ),
            GestureDetector(
              onTap: () {
                
              },
              child: Text(
                'see_all'.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.accentAmber,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        
        TechniciansListView(technicians: displayedTechnicians),
      ],
    );
  }
}