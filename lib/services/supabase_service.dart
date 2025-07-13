import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../models/loan.dart';
import '../config/supabase_config.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  late final SupabaseClient _client;
  SupabaseClient get client => _client;

  static Future<void> initialize() async {
    // Load .env file
    await SupabaseConfig.loadEnv();

    // Validate credentials
    if (SupabaseConfig.supabaseUrl.isEmpty || SupabaseConfig.supabaseAnonKey.isEmpty) {
      throw Exception('Supabase URL or Anon Key is missing in .env file');
    }

    // Debug: Print credentials
    print('Supabase URL: ${SupabaseConfig.supabaseUrl}');
    print('Supabase Anon Key: ${SupabaseConfig.supabaseAnonKey}');

    // Initialize Supabase
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
    );
    _instance._client = Supabase.instance.client;
  }

  // Authentication Methods
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    try {
      return await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signUp(
    String email,
    String password, {
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'phone_number': phoneNumber,
        },
      );

      if (response.user != null) {
        await createUserProfile(UserProfile(
          id: response.user!.id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          createdAt: DateTime.now(),
          isActive: true,
          kycStatus: 'pending',
        ));
      }

      return response;
    } catch (e) {
      print('Error signing up: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } catch (e) {
      print('Error resetting password: $e');
      rethrow;
    }
  }

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  // User Profile Methods
  Future<void> createUserProfile(UserProfile profile) async {
    try {
      await _client.from(SupabaseConfig.userProfilesTable).insert(profile.toJson());
    } catch (e) {
      print('Error creating user profile: $e');
      rethrow;
    }
  }

  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.userProfilesTable)
          .select()
          .eq('id', userId)
          .maybeSingle();
      return response != null ? UserProfile.fromJson(response) : null;
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    try {
      await _client
          .from(SupabaseConfig.userProfilesTable)
          .update(profile.toJson())
          .eq('id', profile.id);
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }

  // Account Methods
  Future<List<Account>> getUserAccounts(String userId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.accountsTable)
          .select()
          .eq('user_id', userId)
          .eq('is_active', true);
      return (response as List<dynamic>).map((json) => Account.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching accounts: $e');
      return [];
    }
  }

  Future<Account> createAccount(Account account) async {
    try {
      final response = await _client
          .from(SupabaseConfig.accountsTable)
          .insert(account.toJson())
          .select()
          .single();
      return Account.fromJson(response);
    } catch (e) {
      print('Error creating account: $e');
      rethrow;
    }
  }

  Future<void> updateAccountBalance(String accountId, double newBalance) async {
    try {
      await _client
          .from(SupabaseConfig.accountsTable)
          .update({
            'balance': newBalance,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', accountId);
    } catch (e) {
      print('Error updating account balance: $e');
      rethrow;
    }
  }

  // Transaction Methods
  Future<List<Transaction>> getAccountTransactions(
    String accountId, {
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final response = await _client
          .from(SupabaseConfig.transactionsTable)
          .select()
          .or('from_account_id.eq.$accountId,to_account_id.eq.$accountId')
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);
      return (response as List<dynamic>).map((json) => Transaction.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }

  Future<Transaction> createTransaction(Transaction transaction) async {
    try {
      final response = await _client
          .from(SupabaseConfig.transactionsTable)
          .insert(transaction.toJson())
          .select()
          .single();
      return Transaction.fromJson(response);
    } catch (e) {
      print('Error creating transaction: $e');
      rethrow;
    }
  }

  Future<void> processTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String description,
    String? reference,
  }) async {
    try {
      await _client.rpc('process_transfer', params: {
        'from_account': fromAccountId,
        'to_account': toAccountId,
        'transfer_amount': amount,
        'transfer_description': description,
        'transfer_reference': reference,
      });
    } catch (e) {
      print('Error processing transfer: $e');
      rethrow;
    }
  }

  // Loan Methods
  Future<List<Loan>> getUserLoans(String userId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.loansTable)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      return (response as List<dynamic>).map((json) => Loan.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching loans: $e');
      return [];
    }
  }

  Future<Loan> createLoanApplication(Loan loan) async {
    try {
      final response = await _client
          .from(SupabaseConfig.loansTable)
          .insert(loan.toJson())
          .select()
          .single();
      return Loan.fromJson(response);
    } catch (e) {
      print('Error creating loan application: $e');
      rethrow;
    }
  }

  Future<void> updateLoanStatus(String loanId, LoanStatus status) async {
    try {
      await _client
          .from(SupabaseConfig.loansTable)
          .update({
            'status': status.name,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', loanId);
    } catch (e) {
      print('Error updating loan status: $e');
      rethrow;
    }
  }

  Future<List<LoanProduct>> getLoanProducts() async {
    try {
      final response = await _client
          .from(SupabaseConfig.loanProductsTable)
          .select()
          .eq('is_active', true);
      return (response as List<dynamic>).map((json) => LoanProduct.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching loan products: $e');
      return [];
    }
  }

  // Admin Methods
  Future<Map<String, dynamic>> getAdminDashboardStats() async {
    try {
      final response = await _client.rpc('get_admin_dashboard_stats');
      return response as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching admin stats: $e');
      return {};
    }
  }

  Future<List<UserProfile>> getAllUsers({
    int limit = 50,
    int offset = 0,
    String? searchQuery,
  }) async {
    try {
      final response = await _client
          .from(SupabaseConfig.userProfilesTable)
          .select()
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);
      
      List<dynamic> results = response;
      
      // Apply search filter in memory if needed
      if (searchQuery != null && searchQuery.isNotEmpty) {
        results = results.where((user) {
          final firstName = user['first_name']?.toString().toLowerCase() ?? '';
          final lastName = user['last_name']?.toString().toLowerCase() ?? '';
          final email = user['email']?.toString().toLowerCase() ?? '';
          final query = searchQuery.toLowerCase();
          
          return firstName.contains(query) || 
                 lastName.contains(query) || 
                 email.contains(query);
        }).toList();
      }
      
      return results.map((json) => UserProfile.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<List<Loan>> getAllLoans({
    int limit = 50,
    int offset = 0,
    LoanStatus? status,
  }) async {
    try {
      final response = await _client
          .from(SupabaseConfig.loansTable)
          .select('''
            *,
            user_profiles!inner(first_name, last_name, email)
          ''')
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);
      
      List<dynamic> results = response;
      
      // Apply status filter in memory if needed
      if (status != null) {
        results = results.where((loan) => loan['status'] == status.name).toList();
      }
      
      return results.map((json) => Loan.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching loans: $e');
      return [];
    }
  }

  // Real-time subscriptions
  RealtimeChannel subscribeToUserTransactions(String userId, Function(List<Transaction>) onData) {
    return _client
        .channel('user_transactions_$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: SupabaseConfig.transactionsTable,
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) async {
            final transactions = await getAccountTransactions(userId);
            onData(transactions);
          },
        )
        .subscribe();
  }

  RealtimeChannel subscribeToAccountBalance(String accountId, Function(double) onBalanceChange) {
    return _client
        .channel('account_balance_$accountId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: SupabaseConfig.accountsTable,
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: accountId,
          ),
          callback: (payload) {
            final newBalance = payload.newRecord['balance'] as double;
            onBalanceChange(newBalance);
          },
        )
        .subscribe();
  }

  // Notification Methods
  Future<void> sendNotification({
    required String userId,
    required String title,
    required String message,
    String? type,
    Map<String, dynamic>? data,
  }) async {
    try {
      await _client.from(SupabaseConfig.notificationsTable).insert({
        'user_id': userId,
        'title': title,
        'message': message,
        'type': type ?? 'general',
        'data': data,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error sending notification: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getUserNotifications(String userId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.notificationsTable)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(50);
      return response;
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _client
          .from(SupabaseConfig.notificationsTable)
          .update({'is_read': true})
          .eq('id', notificationId);
    } catch (e) {
      print('Error marking notification as read: $e');
      rethrow;
    }
  }
}