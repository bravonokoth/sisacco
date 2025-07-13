class AppConstants {
  // App Information
  static const String appName = 'FinanceApp';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Your Financial Partner';
  
  // API Endpoints
  static const String baseUrl = 'https://api.yourbank.com';
  
  // Shared Preferences Keys
  static const String keyIsFirstTime = 'is_first_time';
  static const String keyBiometricEnabled = 'biometric_enabled';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyDarkModeEnabled = 'dark_mode_enabled';
  static const String keyLanguage = 'language';
  
  // Transaction Categories
  static const List<String> transactionCategories = [
    'Income',
    'Shopping',
    'Bills',
    'Food & Dining',
    'Transportation',
    'Entertainment',
    'Healthcare',
    'Education',
    'Travel',
    'Investment',
    'Transfer',
    'Other',
  ];
  
  // Account Types
  static const Map<String, String> accountTypeNames = {
    'savings': 'Savings Account',
    'checking': 'Checking Account',
    'fixed_deposit': 'Fixed Deposit',
    'loan': 'Loan Account',
    'shares': 'Shares Account',
  };
  
  // Loan Statuses
  static const Map<String, String> loanStatusNames = {
    'pending': 'Pending Review',
    'approved': 'Approved',
    'active': 'Active',
    'overdue': 'Overdue',
    'closed': 'Closed',
    'rejected': 'Rejected',
  };
  
  // KYC Statuses
  static const Map<String, String> kycStatusNames = {
    'pending': 'Pending Verification',
    'verified': 'Verified',
    'rejected': 'Rejected',
  };
  
  // Validation Rules
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const double minTransferAmount = 1.0;
  static const double maxTransferAmount = 100000.0;
  static const double minLoanAmount = 1000.0;
  static const double maxLoanAmount = 1000000.0;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // File Upload
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx'];
  
  // Currency
  static const String defaultCurrency = 'USD';
  static const String currencySymbol = '\$';
  
  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';
  
  // Error Messages
  static const String networkError = 'Network connection error. Please check your internet connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'An unknown error occurred. Please try again.';
  static const String sessionExpired = 'Your session has expired. Please login again.';
  
  // Success Messages
  static const String loginSuccess = 'Login successful!';
  static const String signupSuccess = 'Account created successfully!';
  static const String transferSuccess = 'Transfer completed successfully!';
  static const String loanApplicationSuccess = 'Loan application submitted successfully!';
  static const String profileUpdateSuccess = 'Profile updated successfully!';
}
