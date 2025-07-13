import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/transaction_item.dart';
import '../../models/account.dart';
import '../../models/transaction.dart';
import '../../providers/account_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../providers/auth_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Load data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDashboardData();
    });
  }

  void _loadDashboardData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final accountProvider = Provider.of<AccountProvider>(context, listen: false);
    final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
    
    if (authProvider.user != null) {
      accountProvider.loadUserAccounts(authProvider.user!.id);
      
      // Load transactions for the first account (if any)
      if (accountProvider.accounts.isNotEmpty) {
        transactionProvider.loadAccountTransactions(accountProvider.accounts.first.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AccountProvider, TransactionProvider>(
      builder: (context, accountProvider, transactionProvider, child) {
        final accounts = accountProvider.accounts;
        final recentTransactions = transactionProvider.recentTransactions;
        final totalBalance = accountProvider.totalBalance;

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
                            Consumer<AuthProvider>(
                              builder: (context, authProvider, child) {
                                final userName = authProvider.userProfile?.firstName ?? 'User';
                                return Text(
                                  userName,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
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
                    child: accountProvider.isLoading
                        ? const Center(child: CircularProgressIndicator(color: AppColors.white))
                        : BalanceCard(
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
                            transactionProvider.isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : recentTransactions.isEmpty
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            'No recent transactions',
                                            style: TextStyle(
                                              color: AppColors.darkGray,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: recentTransactions
                                            .take(5)
                                            .map((transaction) => TransactionItem(
                                                  transaction: transaction,
                                                ))
                                            .toList(),
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
      },
    );
  }
}
