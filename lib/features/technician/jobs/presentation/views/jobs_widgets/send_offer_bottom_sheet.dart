import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salahly/core/theme/app_theme.dart';

class SendOfferBottomSheet extends StatefulWidget {
  final String jobTitle;
  final double originalBudget;
  final Function(double price, String arrivalTime, String note) onSubmitOffer;

  const SendOfferBottomSheet({
    super.key,
    required this.jobTitle,
    required this.originalBudget,
    required this.onSubmitOffer,
  });

  static void show(
    BuildContext context, {
    required String jobTitle,
    required double originalBudget,
    required Function(double price, String arrivalTime, String note) onSubmitOffer,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SendOfferBottomSheet(
          jobTitle: jobTitle,
          originalBudget: originalBudget,
          onSubmitOffer: onSubmitOffer,
        ),
      ),
    );
  }

  @override
  State<SendOfferBottomSheet> createState() => _SendOfferBottomSheetState();
}

class _SendOfferBottomSheetState extends State<SendOfferBottomSheet> {
  late final TextEditingController _priceController;
  late final TextEditingController _timeController;
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(
      text: widget.originalBudget > 0 ? widget.originalBudget.toStringAsFixed(0) : '',
    );
    _timeController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _timeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'offer_dialog_title'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Text(
            widget.jobTitle,
            style: const TextStyle(fontSize: 13, color: AppTheme.slate500),
          ),
          const SizedBox(height: 16),

          
          TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: 'counter_price_hint'.tr(),
              prefixIcon: const Icon(Icons.payments_outlined, color: AppTheme.slate500),
              suffixText: 'egp'.tr(),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.accentAmber, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 12),

          
          TextField(
            controller: _timeController,
            decoration: InputDecoration(
              hintText: 'estimated_time_hint'.tr(),
              prefixIcon: const Icon(Icons.access_time_rounded, color: AppTheme.slate500),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.accentAmber, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 12),

          
          TextField(
            controller: _noteController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'notes_hint'.tr(),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.accentAmber, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 20),

          
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentAmber,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                final price = double.tryParse(_priceController.text) ?? widget.originalBudget;
                widget.onSubmitOffer(
                  price,
                  _timeController.text.trim(),
                  _noteController.text.trim(),
                );
                Navigator.pop(context);
              },
              child: Text(
                'send'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}