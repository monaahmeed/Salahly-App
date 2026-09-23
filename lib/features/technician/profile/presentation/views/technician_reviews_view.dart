import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/technician/profile/data/models/technician_review_model.dart';
import 'widgets/review_item_card.dart';

class TechnicianReviewsView extends StatelessWidget {
  final double averageRating;
  final int totalReviews;

  const TechnicianReviewsView({
    super.key,
    this.averageRating = 4.9,
    this.totalReviews = 28,
  });

  static final List<TechnicianReviewModel> _dummyReviews = [
    TechnicianReviewModel(
      id: 'rev_1',
      clientName: 'Nour Ali',
      rating: 5.0,
      serviceTitle: 'Kitchen Drain Clearing',
      comment: 'ممتاز وسريع جداً في الحل، أنصح بالتعامل معه.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    TechnicianReviewModel(
      id: 'rev_2',
      clientName: 'Mohamed Tarek',
      rating: 4.8,
      serviceTitle: 'Bathroom Tap Leakage Repair',
      comment: 'شغل نظيف ووصل في الميعاد المحدد بالضبط.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    TechnicianReviewModel(
      id: 'rev_3',
      clientName: 'Sarah Smith',
      rating: 5.0,
      serviceTitle: 'Emergency Pipe Burst',
      comment: 'Professional, polite, and resolved the water leakage immediately.',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'customer_reviews'.tr(),
          style: const TextStyle(
            color: AppTheme.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.primaryNavy),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(Icons.star_rounded, color: AppTheme.accentAmber, size: 20),
                        Icon(Icons.star_rounded, color: AppTheme.accentAmber, size: 20),
                        Icon(Icons.star_rounded, color: AppTheme.accentAmber, size: 20),
                        Icon(Icons.star_rounded, color: AppTheme.accentAmber, size: 20),
                        Icon(Icons.star_half_rounded, color: AppTheme.accentAmber, size: 20),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'based_on_reviews'.tr(namedArgs: {'count': totalReviews.toString()}),
                      style: const TextStyle(fontSize: 11, color: AppTheme.slate500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          
          Text(
            'latest_reviews'.tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 12),

          ..._dummyReviews.map((review) => ReviewItemCard(review: review)),
        ],
      ),
    );
  }
}