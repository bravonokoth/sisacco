import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: transaction.isCredit
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              transaction.isCredit
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
              color: transaction.isCredit ? AppColors.success : AppColors.error,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.formattedAmount,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: transaction.isCredit ? AppColors.success : AppColors.error,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction.formattedDate,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.darkGray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
