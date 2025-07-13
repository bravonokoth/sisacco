import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../models/loan.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Loan> activeLoans = [
    Loan(
      id: '1',
      userId: 'test',
      productId: '1',
      productName: 'Personal Loan',
      principalAmount: 10000.00,
      outstandingBalance: 7500.00,
      monthlyPayment: 450.00,
      interestRate: 8.5,
      nextPaymentDate: DateTime.now().add(const Duration(days: 15)),
      status: LoanStatus.active,
      createdAt: DateTime.now(),
    ),
    Loan(
      id: '2',
      userId: 'test',
      productId: '3',
      productName: 'Car Loan',
      principalAmount: 25000.00,
      outstandingBalance: 18750.00,
      monthlyPayment: 650.00,
      interestRate: 6.5,
      nextPaymentDate: DateTime.now().add(const Duration(days: 20)),
      status: LoanStatus.active,
      createdAt: DateTime.now(),
    ),
  ];

  final List<LoanProduct> loanProducts = [
    LoanProduct(
      id: '1',
      name: 'Personal Loan',
      description: 'Flexible personal loan for various needs',
      minAmount: 5000.0,
      maxAmount: 50000.0,
      interestRate: 8.5,
      maxTerm: 60,
      requirements: ['Valid ID', 'Proof of Income', 'Good Credit Score'],
    ),
    LoanProduct(
      id: '2',
      name: 'Home Loan',
      description: 'Mortgage loan for home purchase',
      minAmount: 100000.0,
      maxAmount: 2000000.0,
      interestRate: 6.5,
      maxTerm: 360,
      requirements: ['Valid ID', 'Proof of Income', 'Property Documents'],
    ),
    LoanProduct(
      id: '3',
      name: 'Car Loan',
      description: 'Auto loan for vehicle purchase',
      minAmount: 10000.0,
      maxAmount: 500000.0,
      interestRate: 7.2,
      maxTerm: 84,
      requirements: ['Valid ID', 'Proof of Income', 'Vehicle Documents'],
    ),
    LoanProduct(
      id: '4',
      name: 'Business Loan',
      description: 'Loan for business expansion',
      minAmount: 50000.0,
      maxAmount: 1000000.0,
      interestRate: 9.0,
      maxTerm: 120,
      requirements: ['Business Registration', 'Financial Statements', 'Business Plan'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loans'),
        backgroundColor: AppColors.deepBlueViolet,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.white,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.white.withOpacity(0.7),
          tabs: const [
            Tab(text: 'My Loans'),
            Tab(text: 'Apply Loan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyLoansTab(),
          _buildApplyLoanTab(),
        ],
      ),
    );
  }

  Widget _buildMyLoansTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Loan Summary Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.cardGradient,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Outstanding',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${_calculateTotalOutstanding().toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryItem(
                        'Monthly Payment',
                        _calculateTotalMonthlyPayment(),
                      ),
                    ),
                    Expanded(
                      child: _buildSummaryItem(
                        'Active Loans',
                        activeLoans.length.toDouble(),
                        isCount: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Active Loans
          const Text(
            'Active Loans',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...activeLoans.map((loan) => _buildLoanCard(loan)),

          const SizedBox(height: 20),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Make Payment',
                  onPressed: () => _showPaymentDialog(),
                  icon: Icons.payment,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.history),
                  label: const Text('Payment History'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.purple,
                    side: const BorderSide(color: AppColors.purple),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApplyLoanTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eligibility Check Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.info.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.verified_user,
                    color: AppColors.info,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Check Your Eligibility',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.info,
                        ),
                      ),
                      Text(
                        'See what loans you qualify for',
                        style: TextStyle(
                          color: AppColors.info,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Check Now'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Loan Products
          const Text(
            'Available Loan Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...loanProducts.map((product) => _buildLoanProductCard(product)),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, double value, {bool isCount = false}) {
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
          isCount ? value.toInt().toString() : '\$${value.toStringAsFixed(2)}',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLoanCard(Loan loan) {
    final progress = 1 - (loan.outstandingBalance / loan.principalAmount);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  loan.productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(loan.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  loan.status.name.toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(loan.status),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Outstanding Balance',
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '\$${loan.outstandingBalance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Monthly Payment',
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '\$${loan.monthlyPayment.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Repayment Progress',
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: const TextStyle(
                      color: AppColors.success,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.lightGray,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: AppColors.warning,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Next payment: ${_formatDate(loan.nextPaymentDate ?? DateTime.now())}',
                style: const TextStyle(
                  color: AppColors.warning,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoanProductCard(LoanProduct product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  product.icon,
                  color: AppColors.purple,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(
                        color: AppColors.darkGray,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildProductDetail(
                  'Amount',
                  '\$${product.minAmount.toInt()}K - \$${(product.maxAmount / 1000).toInt()}K',
                ),
              ),
              Expanded(
                child: _buildProductDetail(
                  'Interest Rate',
                  '${product.interestRate}% p.a.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildProductDetail(
                  'Max Term',
                  '${product.maxTerm} months',
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => _showLoanApplicationDialog(product),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Apply Now'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.darkGray,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(LoanStatus status) {
    switch (status) {
      case LoanStatus.active:
        return AppColors.success;
      case LoanStatus.overdue:
        return AppColors.error;
      case LoanStatus.pending:
        return AppColors.warning;
      case LoanStatus.closed:
        return AppColors.darkGray;
      case LoanStatus.approved:
        return AppColors.success;
      case LoanStatus.rejected:
        return AppColors.error;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference > 0) {
      return 'in $difference days';
    } else {
      return '${difference.abs()} days overdue';
    }
  }

  double _calculateTotalOutstanding() {
    return activeLoans.fold(0, (sum, loan) => sum + loan.outstandingBalance);
  }

  double _calculateTotalMonthlyPayment() {
    return activeLoans.fold(0, (sum, loan) => sum + loan.monthlyPayment);
  }

  void _showPaymentDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Make Loan Payment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: activeLoans.length,
                itemBuilder: (context, index) {
                  final loan = activeLoans[index];
                  return ListTile(
                    title: Text(loan.productName),
                    subtitle: Text('Next payment: \$${loan.monthlyPayment.toStringAsFixed(2)}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _processPayment(loan);
                      },
                      child: const Text('Pay'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoanApplicationDialog(LoanProduct product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apply for ${product.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Interest Rate: ${product.interestRate}% p.a.'),
            Text('Amount Range: \$${product.minAmount.toInt()} - \$${product.maxAmount.toInt()}'),
            Text('Max Term: ${product.maxTerm} months'),
            const SizedBox(height: 16),
            const Text('This will redirect you to the loan application form.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to loan application form
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _processPayment(Loan loan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Successful'),
        content: Text('Payment of \$${loan.monthlyPayment.toStringAsFixed(2)} has been processed for your ${loan.productName}.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
