import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/core/utils/functions/show_language_bottom_sheet.dart';
import 'package:salahly/core/utils/widgets/logout_button.dart';
import 'package:salahly/core/utils/widgets/profile_header.dart';
import 'package:salahly/core/utils/widgets/profile_option_tile.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/pick_location_view.dart';
import 'package:salahly/features/technician/profile/presentation/views/widgets/category_picker_sheet.dart';
import 'package:salahly/features/technician/profile/presentation/views/widgets/work_radius_dialog.dart';
import 'package:salahly/features/technician/profile/presentation/views/widgets/working_hours_picker.dart';

import 'profile_section_container.dart';
import 'technician_availability_card.dart';
import 'technician_stats_card.dart';

class TechnicianProfileViewBody extends StatefulWidget {
  const TechnicianProfileViewBody({super.key});

  @override
  State<TechnicianProfileViewBody> createState() =>
      _TechnicianProfileViewBodyState();
}

class _TechnicianProfileViewBodyState extends State<TechnicianProfileViewBody> {
  String _userName = 'mona';
  final String _userEmail = 'mona.ahmed@example.com';
  File? _profileImage;
  bool _isAvailable = true;
  bool _isNotificationsEnabled = true;
  String _savedAddress = 'Cairo, Egypt';
  LatLng _savedLatLng = const LatLng(30.0444, 31.2357);
  String _selectedSpecialty = 'plumbing'.tr();
  double _workRadius = 15;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 20, minute: 0);

  Future<void> _pickLocation() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => PickLocationView(initialPosition: _savedLatLng),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _savedLatLng = result['latLng'] as LatLng;
        _savedAddress = result['address'] as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeader(
            userName: _userName,
            userEmail: _userEmail,
            profileImage: _profileImage,
            onImagePicked: (image) => setState(() => _profileImage = image),
            onNameEdited: (name) => setState(() => _userName = name),
          ),
          const SizedBox(height: 16),

          TechnicianAvailabilityCard(
            isAvailable: _isAvailable,
            onStatusChanged: (val) => setState(() => _isAvailable = val),
          ),
          const SizedBox(height: 16),

          const TechnicianStatsCard(
            completedJobs: 48,
            rating: 4.9,
            totalEarnings: 8250.0,
          ),
          const SizedBox(height: 20),

          ProfileSectionContainer(
            title: 'job_preferences_section'.tr(),
            children: [
              ProfileOptionTile(
                icon: Icons.plumbing_rounded,
                title: 'service_category'.tr(),
                subtitle: _selectedSpecialty,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) => CategoryPickerSheet(
                      selectedSpecialty: _selectedSpecialty,
                      onSelected: (val) =>
                          setState(() => _selectedSpecialty = val),
                    ),
                  );
                },
              ),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),

              ProfileOptionTile(
                icon: Icons.location_on_outlined,
                title: 'workshop_location'.tr(),
                subtitle: _savedAddress,
                onTap: _pickLocation,
              ),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),

              ProfileOptionTile(
                icon: Icons.radar_rounded,
                title: 'work_radius'.tr(),
                subtitle: '${_workRadius.toInt()} ${'km_unit'.tr()}',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => WorkRadiusDialog(
                      initialRadius: _workRadius,
                      onSaved: (newRadius) =>
                          setState(() => _workRadius = newRadius),
                    ),
                  );
                },
              ),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),

              ProfileOptionTile(
                icon: Icons.schedule_rounded,
                title: 'working_hours'.tr(),
                subtitle:
                    '${_startTime.format(context)} - ${_endTime.format(context)}',
                onTap: () {
                  showWorkingHoursRangePicker(
                    context: context,
                    initialStart: _startTime,
                    initialEnd: _endTime,
                    onTimePicked: (start, end) {
                      setState(() {
                        _startTime = start;
                        _endTime = end;
                      });
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          ProfileSectionContainer(
            title: 'app_settings_section'.tr(),
            children: [
              
              ProfileOptionTile(
                icon: Icons.notifications_none_rounded,
                title: 'notifications'.tr(),
                trailing: Switch(
                  activeThumbColor: AppTheme.accentAmber,
                  value: _isNotificationsEnabled,
                  onChanged: (value) {
                    setState(() => _isNotificationsEnabled = value);
                  },
                ),
              ),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),

              ProfileOptionTile(
                icon: Icons.language_rounded,
                title: 'language'.tr(),
                subtitle: isArabic ? 'العربية' : 'English',
                onTap: () => showLanguageBottomSheet(context),
              ),

              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              ProfileOptionTile(
                icon: Icons.help_outline_rounded,
                title: 'help_support'.tr(),
                onTap: () {},
              ),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              ProfileOptionTile(
                icon: Icons.privacy_tip_outlined,
                title: 'terms_conditions'.tr(),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          LogoutButton(onLogout: () {}),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
