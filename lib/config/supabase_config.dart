import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  // Load environment variables
  static Future<void> loadEnv() async {
    await dotenv.load(fileName: ".env");
  }

  // Supabase credentials
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  // Database table names
  static String get userProfilesTable => dotenv.env['TABLE_USER_PROFILES'] ?? '';
  static String get accountsTable => dotenv.env['TABLE_ACCOUNTS'] ?? '';
  static String get transactionsTable => dotenv.env['TABLE_TRANSACTIONS'] ?? '';
  static String get loansTable => dotenv.env['TABLE_LOANS'] ?? '';
  static String get loanProductsTable => dotenv.env['TABLE_LOAN_PRODUCTS'] ?? '';
  static String get notificationsTable => dotenv.env['TABLE_NOTIFICATIONS'] ?? '';

  // Storage buckets
  static String get profileImagesBucket => dotenv.env['BUCKET_PROFILE_IMAGES'] ?? '';
  static String get documentsBucket => dotenv.env['BUCKET_DOCUMENTS'] ?? '';
}