import 'package:flutter/material.dart';
import 'package:salahly/features/client/home/presentation/views/widgets/costum_home_app_bar.dart';
import 'package:salahly/features/client/home/presentation/views/widgets/custom_client_name.dart';
import 'package:salahly/features/client/home/presentation/views/widgets/technician_categores.dart';
import 'package:salahly/features/client/home/presentation/views/widgets/top_technicians_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomHomeAppBar(
                locationName: 'Jumeirah, Dubai',
                hasNotification: false,
                onNotificationTap: () {},
                onLocationTap: () {},
              ),
            ),
            const SizedBox(height: 6),
            Divider(color: Colors.grey.shade200, thickness: 1, height: 1),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomClientName(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TechnicianCategores(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TopTechniciansSection()
            ),
          ],
        ),
      ),
    );
  }
}
