import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/models/service_request_model.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/technician/jobs/data/models/spare_part_item.dart';
import 'package:salahly/features/technician/jobs/presentation/views/Job_invoice_widgets/submit_invoice_buttomn.dart';

import 'invoice_header_card.dart';
import 'invoice_total_bar.dart';
import 'labor_fee_card.dart';
import 'spare_parts_section.dart';
import 'store_receipt_card.dart';

class JobInvoiceViewBody extends StatefulWidget {
  final ServiceRequestModel request;

  const JobInvoiceViewBody({super.key, required this.request});

  @override
  State<JobInvoiceViewBody> createState() => _JobInvoiceViewBodyState();
}

class _JobInvoiceViewBodyState extends State<JobInvoiceViewBody> {
  final List<SparePartItem> _spareParts = [];
  File? _receiptImage;

  double get _laborFee => widget.request.offeredPrice;
  double get _totalSparePartsFee =>
      _spareParts.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get _totalAmount => _laborFee + _totalSparePartsFee;

  void _showAddItemDialog() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final qtyController = TextEditingController(text: '1');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'add_item'.tr(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryNavy,
          ),
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'item_name'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please_enter_item_name'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: '${'price'.tr()} (${'egp'.tr()})',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please_enter_valid_price'.tr();
                    }
                    final parsed = double.tryParse(value.trim());
                    if (parsed == null || parsed <= 0) {
                      return 'please_enter_valid_price'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'quantity'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please_enter_valid_qty'.tr();
                    }
                    final parsed = int.tryParse(value.trim());
                    if (parsed == null || parsed <= 0) {
                      return 'please_enter_valid_qty'.tr();
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'cancel'.tr(),
              style: const TextStyle(color: AppTheme.slate500),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryNavy,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  _spareParts.add(
                    SparePartItem(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameController.text.trim(),
                      price: double.parse(priceController.text.trim()),
                      quantity: int.parse(qtyController.text.trim()),
                    ),
                  );
                });
                Navigator.pop(ctx);
              }
            },
            child: Text(
              'add'.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - 32.0,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InvoiceHeaderCard(
                    jobReference: widget.request.id,
                    problemTitle: widget.request.problemTitle,
                  ),
                  const SizedBox(height: 14),

                  LaborFeeCard(fee: _laborFee),
                  const SizedBox(height: 14),

                  SparePartsSection(
                    items: _spareParts,
                    onAddItem: _showAddItemDialog,
                    onRemoveItem: (index) =>
                        setState(() => _spareParts.removeAt(index)),
                  ),
                  const SizedBox(height: 14),

                  if (_spareParts.isNotEmpty) ...[
                    StoreReceiptCard(
                      receiptImage: _receiptImage,
                      onImageSelected: (image) {
                        setState(() {
                          _receiptImage = image;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                  ],

                  const SizedBox(height: 16),

                  InvoiceTotalBar(totalAmount: _totalAmount),
                  const Spacer(),
                  const SizedBox(height: 14),

                  SubmitInvoiceButtomn(),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
