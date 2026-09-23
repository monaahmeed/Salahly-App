import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/models/service_request_model.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'send_offer_bottom_sheet.dart';

class AvailableJobActionButtons extends StatelessWidget {
  final ServiceRequestModel request;
  final VoidCallback onAccept;
  final Function(double price, String time, String note)? onSendOffer;

  const AvailableJobActionButtons({
    super.key,
    required this.request,
    required this.onAccept,
    this.onSendOffer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 42,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentAmber,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: onAccept,
              icon: const Icon(Icons.check_circle_outline, size: 18, color: Colors.white),
              label: Text(
                'accept_job'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 42,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                SendOfferBottomSheet.show(
                  context,
                  jobTitle: request.problemTitle,
                  originalBudget: request.offeredPrice,
                  onSubmitOffer: (price, time, note) {
                    if (onSendOffer != null) {
                      onSendOffer!(price, time, note);
                    }
                  },
                );
              },
              child: Text(
                'send_offer'.tr(),
                style: const TextStyle(
                  color: AppTheme.primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}