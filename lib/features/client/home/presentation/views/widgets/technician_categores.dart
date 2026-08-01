import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/client/home/data/models/category_model.dart';
import 'package:salahly/features/client/home/presentation/views/widgets/categories_grid_view.dart';

class TechnicianCategores extends StatelessWidget {
  TechnicianCategores({super.key});
  final List<CategoryModel> categories = [
    CategoryModel(
      title: 'plumbing'.tr(),
      icon: Icons.build_rounded,
      prosCount: '120+ pros',
    ),
    CategoryModel(
      title: 'electricity'.tr(),
      icon: Icons.bolt_rounded,
      prosCount: '98+ pros',
    ),
    CategoryModel(
      title: 'air_conditioning'.tr(),
      icon: Icons.ac_unit_rounded,
      prosCount: '76+ pros',
    ),
    CategoryModel(
      title: 'carpentry'.tr(),
      icon: Icons.handyman_rounded,
      prosCount: '64+ pros',
    ),
    CategoryModel(
    title: 'painting'.tr(), 
    icon: Icons.format_paint_rounded, 
    prosCount: '85+ pros',
  ),
  
  CategoryModel(
    title: 'cleaning'.tr(), 
    icon: Icons.cleaning_services_rounded, 
    prosCount: '110+ pros',
  ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'categories'.tr(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryNavy,
          ),
        ),
        
        const SizedBox(height: 16),

        
        CategoriesGridView(categories: categories),
      ],
    );
  }
}
