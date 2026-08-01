import 'package:flutter/material.dart';
import 'package:salahly/features/client/home/data/models/technician_model.dart';
import 'custom_technician_card.dart';


class TechniciansListView extends StatelessWidget {
  final List<TechnicianModel> technicians;

  const TechniciansListView({
    super.key,
    required this.technicians,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: technicians.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return CustomTechnicianCard(
          technician: technicians[index],
          onBookTap: () {
            // Navigate to Book / Details view
          },
        );
      },
    );
  }
}