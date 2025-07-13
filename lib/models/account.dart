enum AccountType {
  savings,
  checking,
  fixedDeposit,
  loan,
  shares,
}

class Account {
  final String id;
  final String userId;
  final String name;
  final String accountNumber;
  final double balance;
  final AccountType type;
  final double? interestRate;
  final DateTime? openDate;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Account({
    required this.id,
    required this.userId,
    required this.name,
    required this.accountNumber,
    required this.balance,
    required this.type,
    this.interestRate,
    this.openDate,
    this.description,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  String get typeDisplayName {
    switch (type) {
      case AccountType.savings:
        return 'Savings Account';
      case AccountType.checking:
        return 'Checking Account';
      case AccountType.fixedDeposit:
        return 'Fixed Deposit';
      case AccountType.loan:
        return 'Loan Account';
      case AccountType.shares:
        return 'Shares Account';
    }
  }

  String get maskedAccountNumber {
    if (accountNumber.length <= 4) return accountNumber;
    return '****${accountNumber.substring(accountNumber.length - 4)}';
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      accountNumber: json['account_number'],
      balance: (json['balance'] as num).toDouble(),
      type: AccountType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AccountType.savings,
      ),
      interestRate: json['interest_rate']?.toDouble(),
      openDate: json['open_date'] != null ? DateTime.parse(json['open_date']) : null,
      description: json['description'],
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'account_number': accountNumber,
      'balance': balance,
      'type': type.name,
      'interest_rate': interestRate,
      'open_date': openDate?.toIso8601String(),
      'description': description,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
