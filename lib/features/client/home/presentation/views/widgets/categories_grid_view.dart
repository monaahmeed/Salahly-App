import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly/core/services/app_router.dart';
import 'package:salahly/features/client/home/data/models/category_model.dart';
import 'package:salahly/features/client/home/presentation/views/widgets/costum_category_card.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key, required this.categories});
  final List<CategoryModel> categories;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.3,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return CustomCategoryCard(
          title: category.title,
          icon: category.icon,
          prosCount: category.prosCount,
          onTap: () {
            GoRouter.of(context).push(
              AppRouter.kBookingsView,
              extra: {'categoryName': category.title, 'technician': null},
            );
          },
        );
      },
    );
  }
}
