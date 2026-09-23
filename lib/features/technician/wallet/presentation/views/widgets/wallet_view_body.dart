import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/technician/wallet/data/models/wallet_transaction_model.dart';
import 'package:salahly/features/technician/wallet/presentation/views/widgets/interactive_earnings_chart_card.dart.dart';
import 'wallet_balance_card.dart';
import 'wallet_transaction_item.dart';

class WalletViewBody extends StatelessWidget {
  const WalletViewBody({super.key});

  final List<WalletTransactionModel> _mockTransactions = const [
    WalletTransactionModel(
      id: '1',
      title: 'Pipe Leak Repair',
      referenceNumber: 'JOB-8472',
      dateText: 'Today, 14:30',
      amount: 720.00,
    ),
    WalletTransactionModel(
      id: '2',
      title: 'Water Heater Installation',
      referenceNumber: 'JOB-8469',
      dateText: 'Yesterday, 11:15',
      amount: 450.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          WalletBalanceCard(
            totalCashEarnings: 4250.00,
            completedJobsCount: 14,
            platformDues: 425.00,
            onPayDues: () {
             
            },
          ),
          const SizedBox(height: 16),

          
          const InteractiveEarningsChartCard(),
          const SizedBox(height: 20),

          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'recent_activity'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'view_all'.tr(),
                  style: const TextStyle(
                    color: Color(0xFFD97706),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          
          ..._mockTransactions.map((tx) => WalletTransactionItem(transaction: tx)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}