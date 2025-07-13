enum TransactionType {
  credit,
  debit,
}

enum TransactionStatus {
  pending,
  completed,
  failed,
  cancelled,
}

class Transaction {
  final String id;
  final String? fromAccountId;
  final String? toAccountId;
  final String userId;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final TransactionStatus status;
  final String category;
  final String? reference;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;

  Transaction({
    required this.id,
    this.fromAccountId,
    this.toAccountId,
    required this.userId,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    this.status = TransactionStatus.completed,
    required this.category,
    this.reference,
    this.metadata,
    required this.createdAt,
  });

  bool get isCredit => type == TransactionType.credit;
  bool get isDebit => type == TransactionType.debit;

  String get formattedAmount {
    final prefix = isCredit ? '+' : '-';
    return '$prefix\$${amount.abs().toStringAsFixed(2)}';
  }

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      fromAccountId: json['from_account_id'],
      toAccountId: json['to_account_id'],
      userId: json['user_id'],
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['transaction_date']),
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionType.debit,
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TransactionStatus.completed,
      ),
      category: json['category'],
      reference: json['reference'],
      metadata: json['metadata'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from_account_id': fromAccountId,
      'to_account_id': toAccountId,
      'user_id': userId,
      'description': description,
      'amount': amount,
      'transaction_date': date.toIso8601String(),
      'type': type.name,
      'status': status.name,
      'category': category,
      'reference': reference,
      'metadata': metadata,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
