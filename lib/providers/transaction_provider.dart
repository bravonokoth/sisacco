import 'package:flutter/foundation.dart';
import '../services/supabase_service.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<Transaction> get recentTransactions {
    final sortedTransactions = List<Transaction>.from(_transactions);
    sortedTransactions.sort((a, b) => b.date.compareTo(a.date));
    return sortedTransactions.take(10).toList();
  }

  Future<void> loadAccountTransactions(String accountId) async {
    _setLoading(true);
    _clearError();

    try {
      _transactions = await _supabaseService.getAccountTransactions(accountId);
      _setLoading(false);
    } catch (e) {
      _setError('Failed to load transactions: $e');
      _setLoading(false);
    }
  }

  Future<bool> processTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String description,
    String? reference,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _supabaseService.processTransfer(
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        description: description,
        reference: reference,
      );

      // Reload transactions to get the latest data
      await loadAccountTransactions(fromAccountId);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Transfer failed: $e');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> createTransaction({
    required String userId,
    required String accountId,
    required double amount,
    required TransactionType type,
    required String description,
    required String category,
    String? reference,
    Map<String, dynamic>? metadata,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final transaction = Transaction(
        id: '', // Will be generated by Supabase
        fromAccountId: type == TransactionType.debit ? accountId : null,
        toAccountId: type == TransactionType.credit ? accountId : null,
        userId: userId,
        description: description,
        amount: amount,
        date: DateTime.now(),
        type: type,
        category: category,
        reference: reference,
        metadata: metadata,
        createdAt: DateTime.now(),
      );

      await _supabaseService.createTransaction(transaction);
      await loadAccountTransactions(accountId);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Failed to create transaction: $e');
      _setLoading(false);
      return false;
    }
  }

  List<Transaction> getTransactionsByCategory(String category) {
    return _transactions.where((transaction) => transaction.category == category).toList();
  }

  List<Transaction> getTransactionsByDateRange(DateTime startDate, DateTime endDate) {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(startDate) && transaction.date.isBefore(endDate);
    }).toList();
  }

  double getTotalAmountByType(TransactionType type) {
    return _transactions
        .where((transaction) => transaction.type == type)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
