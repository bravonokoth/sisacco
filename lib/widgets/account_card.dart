import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/account.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  final VoidCallback onTap;

  const AccountCard({
    super.key,
    required this.account,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: _getGradientForAccountType(account.type),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getIconForAccountType(account.type),
                  color: AppColors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    account.name,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white.withOpacity(0.7),
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              account.maskedAccountNumber,
              style: TextStyle(
                color: AppColors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.balance < 0 ? 'Outstanding' : 'Balance',
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${account.balance.abs().toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (account.interestRate != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Interest Rate',
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${account.interestRate}%',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _getGradientForAccountType(AccountType type) {
    switch (type) {
      case AccountType.savings:
        return const LinearGradient(
          colors: [Color(0xFF2D1B69), Color(0xFF7B2CBF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case AccountType.checking:
        return const LinearGradient(
          colors: [Color(0xFF3D2C8D), Color(0xFF8E44AD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case AccountType.fixedDeposit:
        return const LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case AccountType.loan:
        return const LinearGradient(
          colors: [Color(0xFFD32F2F), Color(0xFFFF5722)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case AccountType.shares:
        return const LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF2196F3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  IconData _getIconForAccountType(AccountType type) {
    switch (type) {
      case AccountType.savings:
        return Icons.savings;
      case AccountType.checking:
        return Icons.account_balance_wallet;
      case AccountType.fixedDeposit:
        return Icons.lock;
      case AccountType.loan:
        return Icons.credit_card;
      case AccountType.shares:
        return Icons.trending_up;
    }
  }
}
