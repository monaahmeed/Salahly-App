import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/booking_submit_button.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/problem_description_input.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/schedule_picker.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/service_location_card.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/technician_header_card.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/upload_photos_section.dart';
import 'package:salahly/features/client/home/data/models/technician_model.dart';

class BookingViewBody extends StatelessWidget {
  final String? categoryName;
  final TechnicianModel? technician;
  final TextEditingController? controller;
  final LatLng selectedLatLng;
  final String addressTitle;
  final String addressDetails;
  final VoidCallback onPickLocationTap;
  final VoidCallback? onSubmit;
  final Function(DateTime selectedDate)? onDateSelected;
  const BookingViewBody({
    super.key,
    this.categoryName,
    this.technician,
    this.controller,
    required this.selectedLatLng,
    required this.addressTitle,
    required this.addressDetails,
    required this.onPickLocationTap,
    this.onDateSelected,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDirectBook = technician != null;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDirectBook)...[
            TechnicianHeaderCard(technician: technician!),
            const SizedBox(height: 20),
          ],

          
          ProblemDescriptionInput(
            controller: controller ?? TextEditingController(),
          ),
          const SizedBox(height: 20),
          UploadPhotosSection(onImagesChanged: (images) {}),
          const SizedBox(height: 20),
          ServiceLocationCard(
            currentLatLng: selectedLatLng,
            addressTitle: addressTitle,
            addressDetails: addressDetails,
            onTap: onPickLocationTap,
          ),
          const SizedBox(height: 20),
          SchedulePicker(
            onDateSelected: (selectedDate) {
              if (onDateSelected != null) {
                onDateSelected!(selectedDate);
              }
            },
          ),
          const SizedBox(height: 40),
          BookingSubmitButton(
            isDirectBook: isDirectBook,
            onPressed: () {
              if (onSubmit != null) {
                onSubmit!();
              }
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
