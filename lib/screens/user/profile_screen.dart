import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _biometricEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.deepBlueViolet,
        actions: [
          IconButton(
            onPressed: () {
              // Edit profile
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.white,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: AppColors.purple.withOpacity(0.1),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.purple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'john.doe@email.com',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildProfileStat('Member Since', '2020'),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.white.withOpacity(0.3),
                        ),
                        Expanded(
                          child: _buildProfileStat('Credit Score', '750'),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.white.withOpacity(0.3),
                        ),
                        Expanded(
                          child: _buildProfileStat('Status', 'Premium'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            // Menu Items
            Container(
              decoration: const BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Account Section
                    _buildSectionHeader('Account'),
                    _buildMenuItem(
                      Icons.person_outline,
                      'Personal Information',
                      'Update your personal details',
                      () {},
                    ),
                    _buildMenuItem(
                      Icons.security,
                      'Security Settings',
                      'Manage passwords and security',
                      () {},
                    ),
                    _buildMenuItem(
                      Icons.credit_card,
                      'Cards & Accounts',
                      'Manage your cards and accounts',
                      () {},
                    ),

                    const SizedBox(height: 20),

                    // Preferences Section
                    _buildSectionHeader('Preferences'),
                    _buildSwitchMenuItem(
                      Icons.notifications_outlined,
                      'Notifications',
                      'Receive push notifications',
                      _notificationsEnabled,
                      (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                    ),
                    _buildSwitchMenuItem(
                      Icons.fingerprint,
                      'Biometric Login',
                      'Use fingerprint or face ID',
                      _biometricEnabled,
                      (value) {
                        setState(() {
                          _biometricEnabled = value;
                        });
                      },
                    ),
                    _buildSwitchMenuItem(
                      Icons.dark_mode_outlined,
                      'Dark Mode',
                      'Switch to dark theme',
                      _darkModeEnabled,
                      (value) {
                        setState(() {
                          _darkModeEnabled = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // Support Section
                    _buildSectionHeader('Support'),
                    _buildMenuItem(
                      Icons.help_outline,
                      'Help & FAQ',
                      'Get help and find answers',
                      () {},
                    ),
                    _buildMenuItem(
                      Icons.chat_outlined,
                      'Contact Support',
                      'Chat with our support team',
                      () {},
                    ),
                    _buildMenuItem(
                      Icons.location_on_outlined,
                      'Branch Locator',
                      'Find nearby branches and ATMs',
                      () {},
                    ),
                    _buildMenuItem(
                      Icons.feedback_outlined,
                      'Feedback',
                      'Share your feedback with us',
                      () {},
                    ),

                    const SizedBox(height: 20),

                    // Legal Section
                    _buildSectionHeader('Legal'),
                    _buildMenuItem(
                      Icons.description_outlined,
                      'Terms & Conditions',
                      'Read our terms and conditions',
                      () {},
                    ),
                    _buildMenuItem(
                      Icons.privacy_tip_outlined,
                      'Privacy Policy',
                      'Learn about our privacy practices',
                      () {},
                    ),

                    const SizedBox(height: 30),

                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _logout,
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // App Version
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        color: AppColors.darkGray.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.purple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.purple,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.darkGray,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.darkGray,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: AppColors.white,
      ),
    );
  }

  Widget _buildSwitchMenuItem(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.purple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.purple,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.darkGray,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.purple,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: AppColors.white,
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
