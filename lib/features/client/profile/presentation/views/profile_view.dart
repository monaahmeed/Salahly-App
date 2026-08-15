import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('profile_title'.tr()),
        centerTitle: true,
      ),
      body: const ProfileViewBody(),
    );
  }
}