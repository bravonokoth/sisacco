import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class TransfersScreen extends StatefulWidget {
  const TransfersScreen({super.key});

  @override
  State<TransfersScreen> createState() => _TransfersScreenState();
}

class _TransfersScreenState extends State<TransfersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  final _noteController = TextEditingController();

  String _selectedFromAccount = 'Savings Account - ****1234';
  String _selectedTransferType = 'Internal Transfer';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _recipientController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Money'),
        backgroundColor: AppColors.deepBlueViolet,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.white,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.white.withOpacity(0.7),
          tabs: const [
            Tab(text: 'Transfer'),
            Tab(text: 'Pay Bills'),
            Tab(text: 'QR Pay'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTransferTab(),
          _buildBillPayTab(),
          _buildQRPayTab(),
        ],
      ),
    );
  }

  Widget _buildTransferTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transfer Type Selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
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
                  const Text(
                    'Transfer Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTransferTypeOption(
                          'Internal Transfer',
                          Icons.swap_horiz,
                          'Between your accounts',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTransferTypeOption(
                          'External Transfer',
                          Icons.send,
                          'To other banks',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTransferTypeOption(
                          'P2P Transfer',
                          Icons.person_add,
                          'To friends & family',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTransferTypeOption(
                          'Mobile Money',
                          Icons.phone_android,
                          'M-Pesa, Airtel Money',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // From Account
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
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
                  const Text(
                    'From Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedFromAccount,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: [
                      'Savings Account - ****1234',
                      'Checking Account - ****5678',
                      'Fixed Deposit - ****9012',
                    ].map((account) {
                      return DropdownMenuItem(
                        value: account,
                        child: Text(account),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFromAccount = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Available Balance: \$15,750.50',
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Recipient Details
            CustomTextField(
              controller: _recipientController,
              label: 'Recipient',
              hint: 'Account number or email',
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter recipient details';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Amount
            CustomTextField(
              controller: _amountController,
              label: 'Amount',
              hint: '0.00',
              prefixIcon: Icons.attach_money,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                if (amount > 15750.50) {
                  return 'Insufficient balance';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Note
            CustomTextField(
              controller: _noteController,
              label: 'Note (Optional)',
              hint: 'Add a note for this transfer',
              prefixIcon: Icons.note_outlined,
              maxLines: 3,
            ),

            const SizedBox(height: 30),

            // Transfer Button
            CustomButton(
              text: 'Transfer Money',
              onPressed: _processTransfer,
              width: double.infinity,
              icon: Icons.send,
            ),

            const SizedBox(height: 20),

            // Recent Recipients
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
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
                  const Text(
                    'Recent Recipients',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildRecentRecipient('John Smith', '****1234', Icons.person),
                  _buildRecentRecipient('Jane Doe', '****5678', Icons.person),
                  _buildRecentRecipient('Mike Johnson', '****9012', Icons.person),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferTypeOption(String type, IconData icon, String subtitle) {
    final isSelected = _selectedTransferType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTransferType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.purple.withOpacity(0.1) : AppColors.lightGray,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.purple : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.purple : AppColors.darkGray,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              type,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.purple : AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.purple : AppColors.darkGray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentRecipient(String name, String account, IconData icon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.purple.withOpacity(0.1),
        child: Icon(icon, color: AppColors.purple),
      ),
      title: Text(name),
      subtitle: Text(account),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        _recipientController.text = account;
      },
    );
  }

  Widget _buildBillPayTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Bill Categories
          const Text(
            'Bill Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildBillCategory('Utilities', Icons.flash_on, AppColors.warning),
              _buildBillCategory('Internet', Icons.wifi, AppColors.info),
              _buildBillCategory('Pay TV', Icons.tv, AppColors.purple),
              _buildBillCategory('School Fees', Icons.school, AppColors.success),
              _buildBillCategory('Insurance', Icons.security, AppColors.deepBlueViolet),
              _buildBillCategory('Other', Icons.more_horiz, AppColors.darkGray),
            ],
          ),
          const SizedBox(height: 30),

          // Recent Bills
          const Text(
            'Recent Bills',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildRecentBill('Kenya Power', 'Electricity', '\$45.00', 'Due in 3 days'),
          _buildRecentBill('Safaricom', 'Internet', '\$25.00', 'Due in 5 days'),
          _buildRecentBill('DSTV', 'Pay TV', '\$30.00', 'Due in 7 days'),
        ],
      ),
    );
  }

  Widget _buildBillCategory(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Navigate to bill payment for this category
      },
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentBill(String biller, String category, String amount, String dueDate) {
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
              color: AppColors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.receipt,
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
                  biller,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  category,
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
                amount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.purple,
                ),
              ),
              Text(
                dueDate,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQRPayTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.qr_code_scanner,
              size: 100,
              color: AppColors.purple,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Scan QR Code',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Point your camera at a QR code to make a payment',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.darkGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          CustomButton(
            text: 'Open Camera',
            onPressed: () {
              // Open QR scanner
            },
            width: double.infinity,
            icon: Icons.camera_alt,
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {
              // Upload QR from gallery
            },
            icon: const Icon(Icons.photo_library),
            label: const Text('Upload from Gallery'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.purple,
              side: const BorderSide(color: AppColors.purple),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
          ),
        ],
      ),
    );
  }

  void _processTransfer() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Transfer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('From: $_selectedFromAccount'),
              Text('To: ${_recipientController.text}'),
              Text('Amount: \$${_amountController.text}'),
              if (_noteController.text.isNotEmpty)
                Text('Note: ${_noteController.text}'),
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
                _showSuccessDialog();
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.success,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Transfer Successful!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your transfer of \$${_amountController.text} has been processed successfully.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.darkGray),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _clearForm();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    _amountController.clear();
    _recipientController.clear();
    _noteController.clear();
  }
}
