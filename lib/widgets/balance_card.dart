import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/account.dart';

class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final List<Account> accounts;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.accounts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Total Balance',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.visibility_outlined,
                color: AppColors.white.withOpacity(0.8),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${totalBalance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildAccountSummary(
                  'Savings',
                  accounts
                      .where((a) => a.type == AccountType.savings)
                      .fold(0.0, (sum, a) => sum + a.balance),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildAccountSummary(
                  'Checking',
                  accounts
                      .where((a) => a.type == AccountType.checking)
                      .fold(0.0, (sum, a) => sum + a.balance),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSummary(String title, double amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
