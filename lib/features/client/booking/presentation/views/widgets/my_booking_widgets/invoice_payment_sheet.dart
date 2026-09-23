import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/client/booking/data/models/invoice_model.dart';

class InvoicePaymentSheet extends StatelessWidget {
  final InvoiceModel invoice;
  final ValueChanged<PaymentMethod>? onConfirmPayment;

  const InvoicePaymentSheet({
    super.key,
    required this.invoice,
    this.onConfirmPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'invoice_summary'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                  Text(
                    '#${invoice.bookingId}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.slate500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: Column(
                  children: [
                    _buildCostRow(
                      'labor_fee'.tr(),
                      '${invoice.laborCost.toStringAsFixed(0)} ${'egp'.tr()}',
                    ),
                    if (invoice.spareParts.isNotEmpty) ...[
                      const Divider(height: 16, color: Color(0xFFE2E8F0)),
                      ...invoice.spareParts.map(
                        (part) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: _buildCostRow(
                            part.name,
                            '${part.price.toStringAsFixed(0)} ${'egp'.tr()}',
                            isSubItem: true,
                          ),
                        ),
                      ),
                    ],
                    if (invoice.tax > 0) ...[
                      const SizedBox(height: 6),
                      _buildCostRow(
                        'vat'.tr(),
                        '+${invoice.tax.toStringAsFixed(0)} ${'egp'.tr()}',
                      ),
                    ],
                    if (invoice.discount > 0) ...[
                      const SizedBox(height: 6),
                      _buildCostRow(
                        'discount'.tr(),
                        '-${invoice.discount.toStringAsFixed(0)} ${'egp'.tr()}',
                        isDiscount: true,
                      ),
                    ],
                    const Divider(height: 20, color: Color(0xFFE2E8F0)),
                    _buildCostRow(
                      'total_amount'.tr(),
                      '${invoice.totalAmount.toStringAsFixed(0)} ${'egp'.tr()}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'payment_method'.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.payments_outlined,
                        size: 20,
                        color: Color(0xFF16A34A),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'cash_on_delivery'.tr(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryNavy,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'pay_directly_to_technician'.tr(),
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.slate500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF16A34A),
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    onConfirmPayment?.call(PaymentMethod.cash);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryNavy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'confirm_cash_payment'.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCostRow(
    String title,
    String value, {
    bool isTotal = false,
    bool isSubItem = false,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 14 : (isSubItem ? 12 : 13),
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isSubItem ? AppTheme.slate500 : AppTheme.primaryNavy,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isDiscount
                ? const Color(0xFF16A34A)
                : (isTotal ? AppTheme.primaryNavy : const Color(0xFF334155)),
          ),
        ),
      ],
    );
  }
}