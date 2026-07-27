import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';

abstract class FilePickerHelper {
  
  static Future<File?> pickDocumentFile({
    List<String> allowedExtensions = const ['jpg', 'jpeg', 'png', 'pdf'],
    int maxMbSize = 5,
    required Function(String errorMessage) onError,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.single.path != null) {
        PlatformFile file = result.files.single;

        
        int maxBytes = maxMbSize * 1024 * 1024;
        if (file.size <= maxBytes) {
          return File(file.path!);
        } else {
          onError('file_size'.tr());
          return null;
        }
      }
    } catch (e) {
      onError('file_error'.tr());
    }
    return null;
  }
}