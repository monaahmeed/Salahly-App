import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salahly/core/theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String userEmail;
  final File? profileImage;
  final Function(File pickedImage) onImagePicked;
  final Function(String newName) onNameEdited;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userEmail,
    this.profileImage,
    required this.onImagePicked,
    required this.onNameEdited,
  });

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onImagePicked(File(image.path));
    }
  }

  void _showEditNameDialog(BuildContext context) {
    final controller = TextEditingController(text: userName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('edit_name_title'.tr()),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'name_hint'.tr()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onNameEdited(controller.text.trim());
              }
              Navigator.pop(context);
            },
            child: Text('save'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 🖼️ الصورة الدائرية مع أزرار التعديل
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFFE2E8F0),
              backgroundImage: profileImage != null
                  ? FileImage(profileImage!) as ImageProvider
                  : null,
              child: profileImage == null
                  ? const Icon(Icons.person, size: 40, color: AppTheme.slate500)
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppTheme.accentAmber,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),

        // 📝 الاسم والايميل
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryNavy,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18, color: AppTheme.slate500),
                    onPressed: () => _showEditNameDialog(context),
                  ),
                ],
              ),
              Text(
                userEmail,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.slate500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}