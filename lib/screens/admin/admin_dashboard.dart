import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/admin_stat_card.dart';
import '../../widgets/admin_chart_card.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AdminDashboardContent(),
    const AdminUsersScreen(),
    const AdminLoansScreen(),
    const AdminReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: AppColors.deepBlueViolet,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      drawer: _buildAdminDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.purple,
        unselectedItemColor: AppColors.darkGray,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            activeIcon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_outlined),
            activeIcon: Icon(Icons.credit_card),
            label: 'Loans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Reports',
          ),
        ],
      ),
    );
  }

  Widget _buildAdminDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: const DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.admin_panel_settings,
                      size: 40,
                      color: AppColors.deepBlueViolet,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Admin Panel',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(Icons.dashboard, 'Dashboard', 0),
                _buildDrawerItem(Icons.people, 'User Management', 1),
                _buildDrawerItem(Icons.credit_card, 'Loan Management', 2),
                _buildDrawerItem(Icons.analytics, 'Reports & Analytics', 3),
                const Divider(),
                _buildDrawerItem(Icons.settings, 'System Settings', -1),
                _buildDrawerItem(Icons.security, 'Security & Audit', -1),
                _buildDrawerItem(Icons.backup, 'Backup & Restore', -1),
                const Divider(),
                _buildDrawerItem(Icons.logout, 'Logout', -1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    final isSelected = _selectedIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.purple : AppColors.darkGray,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.purple : AppColors.black,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.purple.withOpacity(0.1),
      onTap: () {
        if (index >= 0) {
          setState(() {
            _selectedIndex = index;
          });
        }
        Navigator.pop(context);
      },
    );
  }
}

class AdminDashboardContent extends StatelessWidget {
  const AdminDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.cardGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome back, Admin!',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Here\'s what\'s happening today',
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings,
                    color: AppColors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Key Metrics
          const Text(
            'Key Metrics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AdminStatCard(
                  title: 'Total Users',
                  value: '12,543',
                  change: '+5.2%',
                  isPositive: true,
                  icon: Icons.people,
                  color: AppColors.info,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AdminStatCard(
                  title: 'Active Loans',
                  value: '1,234',
                  change: '+2.1%',
                  isPositive: true,
                  icon: Icons.credit_card,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AdminStatCard(
                  title: 'Total Deposits',
                  value: '\$2.5M',
                  change: '+8.7%',
                  isPositive: true,
                  icon: Icons.account_balance,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AdminStatCard(
                  title: 'Overdue Loans',
                  value: '45',
                  change: '-12.3%',
                  isPositive: true,
                  icon: Icons.warning,
                  color: AppColors.error,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Charts Section
          const Text(
            'Analytics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          AdminChartCard(
            title: 'Monthly Transactions',
            subtitle: 'Transaction volume over time',
            chartData: _generateChartData(),
          ),

          const SizedBox(height: 16),

          // Recent Activities
          Container(
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
                const Text(
                  'Recent Activities',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildActivityItem(
                  'New user registration',
                  'John Smith joined the platform',
                  '2 minutes ago',
                  Icons.person_add,
                  AppColors.success,
                ),
                _buildActivityItem(
                  'Loan application',
                  'Sarah Johnson applied for personal loan',
                  '15 minutes ago',
                  Icons.credit_card,
                  AppColors.warning,
                ),
                _buildActivityItem(
                  'Payment received',
                  'Michael Brown made loan payment',
                  '1 hour ago',
                  Icons.payment,
                  AppColors.info,
                ),
                _buildActivityItem(
                  'System alert',
                  'High transaction volume detected',
                  '2 hours ago',
                  Icons.warning,
                  AppColors.error,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Quick Actions
          const Text(
            'Quick Actions',
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
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildQuickActionCard(
                'Add New User',
                Icons.person_add,
                AppColors.success,
                () {},
              ),
              _buildQuickActionCard(
                'Process Loans',
                Icons.approval,
                AppColors.warning,
                () {},
              ),
              _buildQuickActionCard(
                'Generate Report',
                Icons.analytics,
                AppColors.info,
                () {},
              ),
              _buildQuickActionCard(
                'System Settings',
                Icons.settings,
                AppColors.purple,
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String description,
    String time,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateChartData() {
    return [
      const FlSpot(0, 3),
      const FlSpot(1, 1),
      const FlSpot(2, 4),
      const FlSpot(3, 3),
      const FlSpot(4, 5),
      const FlSpot(5, 3),
      const FlSpot(6, 4),
    ];
  }

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
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
}

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filter Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search users...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: AppColors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // User Statistics
            Row(
              children: [
                Expanded(
                  child: _buildUserStatCard('Total Users', '12,543', Icons.people, AppColors.info),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildUserStatCard('Active Today', '1,234', Icons.online_prediction, AppColors.success),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildUserStatCard('New This Month', '456', Icons.person_add, AppColors.warning),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildUserStatCard('Pending KYC', '89', Icons.pending, AppColors.error),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Users List
            const Text(
              'Recent Users',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            ...List.generate(10, (index) => _buildUserCard(
              'User ${index + 1}',
              'user${index + 1}@email.com',
              'Active',
              DateTime.now().subtract(Duration(days: index)),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildUserStatCard(String title, String value, IconData icon, Color color) {
    return Container(
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
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.darkGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(String name, String email, String status, DateTime joinDate) {
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
          CircleAvatar(
            backgroundColor: AppColors.purple.withOpacity(0.1),
            child: Text(
              name[0],
              style: const TextStyle(
                color: AppColors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  email,
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${joinDate.day}/${joinDate.month}/${joinDate.year}',
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

class AdminLoansScreen extends StatelessWidget {
  const AdminLoansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Loan Management'),
          backgroundColor: AppColors.deepBlueViolet,
          bottom: const TabBar(
            indicatorColor: AppColors.white,
            labelColor: AppColors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Applications'),
              Tab(text: 'Active Loans'),
              Tab(text: 'Overdue'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LoanApplicationsTab(),
            ActiveLoansTab(),
            OverdueLoansTab(),
          ],
        ),
      ),
    );
  }
}

class LoanApplicationsTab extends StatelessWidget {
  const LoanApplicationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard('Pending', '23', AppColors.warning),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard('Approved', '156', AppColors.success),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard('Rejected', '12', AppColors.error),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Applications List
          ...List.generate(5, (index) => _buildApplicationCard(
            'Personal Loan Application',
            'John Doe',
            '\$15,000',
            'Pending Review',
            DateTime.now().subtract(Duration(days: index)),
          )),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String count, Color color) {
    return Container(
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
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationCard(
    String loanType,
    String applicant,
    String amount,
    String status,
    DateTime date,
  ) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  loanType,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.warning,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Applicant: $applicant',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.darkGray,
                ),
              ),
              const Spacer(),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Applied: ${date.day}/${date.month}/${date.year}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.darkGray,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Review'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      minimumSize: const Size(80, 32),
                    ),
                    child: const Text('Approve'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActiveLoansTab extends StatelessWidget {
  const ActiveLoansTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Active Loans Content'),
    );
  }
}

class OverdueLoansTab extends StatelessWidget {
  const OverdueLoansTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Overdue Loans Content'),
    );
  }
}

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reports & Analytics',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Report Categories
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildReportCard(
                'Financial Reports',
                'Balance sheet, P&L, Cash flow',
                Icons.account_balance,
                AppColors.success,
              ),
              _buildReportCard(
                'Loan Portfolio',
                'PAR, NPL, Disbursements',
                Icons.credit_card,
                AppColors.warning,
              ),
              _buildReportCard(
                'User Analytics',
                'Growth, Demographics',
                Icons.people,
                AppColors.info,
              ),
              _buildReportCard(
                'Compliance',
                'Regulatory reports',
                Icons.gavel,
                AppColors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(String title, String description, IconData icon, Color color) {
    return Container(
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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }
}
