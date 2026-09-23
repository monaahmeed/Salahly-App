import 'package:flutter/material.dart';
import 'jobs_widgets/technician_custom_app_bar.dart';
import 'jobs_widgets/jobs_view_body.dart';

class JobsView extends StatelessWidget {
  const JobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      appBar: TechnicianCustomAppBar(
        technicianName: 'Omar Haddad',
        technicianSpecialty: 'Plumbing Specialist',
      ),
      body: JobsViewBody(),
    );
  }
}