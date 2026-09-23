import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/booking_submit_button.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/offered_price_input.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/problem_description_input.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/problem_title_input.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/schedule_picker.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/service_location_card.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/technician_header_card.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/upload_photos_section.dart';
import 'package:salahly/features/client/home/data/models/technician_model.dart';

class BookingViewBody extends StatefulWidget {
  final String? categoryName;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TechnicianModel? technician;
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
    required this.selectedLatLng,
    required this.addressTitle,
    required this.addressDetails,
    required this.onPickLocationTap,
    this.onDateSelected,
    this.onSubmit,
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
  });

  @override
  State<BookingViewBody> createState() => _BookingViewBodyState();
}

class _BookingViewBodyState extends State<BookingViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      if (widget.onSubmit != null) {
        widget.onSubmit!();
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDirectBook = widget.technician != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isDirectBook) ...[
              TechnicianHeaderCard(technician: widget.technician!),
              const SizedBox(height: 20),
            ],

            
            ProblemTitleInput(
              controller: widget.titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'please_enter_problem_title'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            
            ProblemDescriptionInput(
              controller: widget.descriptionController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'please_enter_problem_desc'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            
            OfferedPriceInput(
              controller: widget.priceController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'please_enter_price'.tr();
                }
                final price = double.tryParse(value);
                if (price == null || price <= 0) {
                  return 'please_enter_valid_price'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            
            UploadPhotosSection(onImagesChanged: (images) {}),
            const SizedBox(height: 20),

            
            ServiceLocationCard(
              currentLatLng: widget.selectedLatLng,
              addressTitle: widget.addressTitle,
              addressDetails: widget.addressDetails,
              onTap: widget.onPickLocationTap,
            ),
            const SizedBox(height: 20),

            
            SchedulePicker(
              onDateSelected: (selectedDate) {
                if (widget.onDateSelected != null) {
                  widget.onDateSelected!(selectedDate);
                }
              },
            ),
            const SizedBox(height: 40),

            
            BookingSubmitButton(
              isDirectBook: isDirectBook,
              onPressed: _validateAndSubmit,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}