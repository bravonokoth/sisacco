import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/transaction_item.dart';
import '../../models/account.dart';
import '../../models/transaction.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Account> accounts = [
    Account(
      id: '1',
      userId: 'test',
      name: 'Savings Account',
      accountNumber: '****1234',
      balance: 15750.50,
      type: AccountType.savings,
      createdAt: DateTime.now(),
    ),
    Account(
      id: '2',
      userId: 'test',
      name: 'Checking Account',
      accountNumber: '****5678',
      balance: 3250.75,
      type: AccountType.checking,
      createdAt: DateTime.now(),
    ),
  ];

  final List<Transaction> recentTransactions = [
    Transaction(
      id: '1',
      userId: 'test',
      description: 'Salary Deposit',
      amount: 5000.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: TransactionType.credit,
      category: 'Income',
      createdAt: DateTime.now(),
    ),
    Transaction(
      id: '2',
      userId: 'test',
      description: 'Grocery Store',
      amount: -125.50,
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: TransactionType.debit,
      category: 'Shopping',
      createdAt: DateTime.now(),
    ),
    Transaction(
      id: '3',
      userId: 'test',
      description: 'Utility Bill',
      amount: -85.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: TransactionType.debit,
      category: 'Bills',
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalBalance = accounts.fold<double>(
      0,
      (sum, account) => sum + account.balance,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.deepBlueViolet, AppColors.purple],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,',
                          style: TextStyle(
                            color: AppColors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'John Doe',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: AppColors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),

              // Balance Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BalanceCard(
                  totalBalance: totalBalance,
                  accounts: accounts,
                ),
              ),

              const SizedBox(height: 20),

              // Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Quick Actions
                        const Text(
                          'Quick Actions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: QuickActionCard(
                                icon: Icons.swap_horiz,
                                title: 'Transfer',
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: QuickActionCard(
                                icon: Icons.payment,
                                title: 'Pay Bills',
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: QuickActionCard(
                                icon: Icons.credit_card,
                                title: 'Apply Loan',
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: QuickActionCard(
                                icon: Icons.qr_code_scanner,
                                title: 'QR Pay',
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Recent Transactions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recent Transactions',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'View All',
                                style: TextStyle(color: AppColors.purple),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...recentTransactions.map(
                          (transaction) => TransactionItem(
                            transaction: transaction,
                          ),
                        ),
                      ],
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
}
