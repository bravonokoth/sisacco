import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/account_card.dart';
import '../../models/account.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  final List<Account> accounts = [
    Account(
      id: '1',
      userId: 'test',
      name: 'Primary Savings',
      accountNumber: '1234567890',
      balance: 15750.50,
      type: AccountType.savings,
      interestRate: 2.5,
      createdAt: DateTime.now(),
    ),
    Account(
      id: '2',
      userId: 'test',
      name: 'Checking Account',
      accountNumber: '0987654321',
      balance: 3250.75,
      type: AccountType.checking,
      interestRate: 0.5,
      createdAt: DateTime.now(),
    ),
    Account(
      id: '3',
      userId: 'test',
      name: 'Fixed Deposit',
      accountNumber: '1122334455',
      balance: 50000.00,
      type: AccountType.fixedDeposit,
      interestRate: 5.0,
      createdAt: DateTime.now(),
    ),
    Account(
      id: '4',
      userId: 'test',
      name: 'Personal Loan',
      accountNumber: '5544332211',
      balance: -12500.00,
      type: AccountType.loan,
      interestRate: 8.5,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Accounts'),
        backgroundColor: AppColors.deepBlueViolet,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.deepBlueViolet, AppColors.lightGray],
            begin: Alignment.topCenter,
            end: Alignment.center,
            stops: [0.0, 0.3],
          ),
        ),
        child: Column(
          children: [
            // Summary Card
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Total Balance',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.darkGray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${_calculateTotalBalance().toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepBlueViolet,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryItem(
                          'Assets',
                          _calculateAssets(),
                          AppColors.success,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.lightGray,
                      ),
                      Expanded(
                        child: _buildSummaryItem(
                          'Liabilities',
                          _calculateLiabilities(),
                          AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Accounts List
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AccountCard(
                        account: accounts[index],
                        onTap: () => _showAccountDetails(accounts[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open new account
        },
        backgroundColor: AppColors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryItem(String title, double amount, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.darkGray,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  double _calculateTotalBalance() {
    return accounts.fold(0, (sum, account) => sum + account.balance);
  }

  double _calculateAssets() {
    return accounts
        .where((account) => account.balance > 0)
        .fold(0, (sum, account) => sum + account.balance);
  }

  double _calculateLiabilities() {
    return accounts
        .where((account) => account.balance < 0)
        .fold(0, (sum, account) => sum + account.balance.abs());
  }

  void _showAccountDetails(Account account) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.darkGray.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Account: ${account.accountNumber}',
                    style: const TextStyle(
                      color: AppColors.darkGray,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppColors.cardGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Current Balance',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '\$${account.balance.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (account.interestRate != null)
                          Column(
                            children: [
                              const Text(
                                'Interest Rate',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${account.interestRate}%',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.history),
                          label: const Text('Statements'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.swap_horiz),
                          label: const Text('Transfer'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
