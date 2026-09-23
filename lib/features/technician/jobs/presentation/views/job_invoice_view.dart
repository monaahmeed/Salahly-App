import 'package:flutter/material.dart';
import 'package:salahly/core/models/service_request_model.dart';
import 'package:salahly/features/technician/jobs/presentation/views/Job_invoice_widgets/job_invoice_view_body.dart';
import 'package:salahly/features/technician/jobs/presentation/views/jobs_widgets/technician_custom_app_bar.dart';

class JobInvoiceView extends StatelessWidget {
  final ServiceRequestModel request;

  const JobInvoiceView({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const TechnicianCustomAppBar(
        technicianName: 'Omar Haddad',
        technicianSpecialty: 'Plumbing Specialist',
      ),
      body: JobInvoiceViewBody(request: request),
    );
  }
}