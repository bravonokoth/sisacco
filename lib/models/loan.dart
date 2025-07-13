import 'package:flutter/material.dart';

enum LoanStatus {
  pending,
  approved,
  active,
  overdue,
  closed,
  rejected,
}

class Loan {
  final String id;
  final String userId;
  final String productId;
  final String productName;
  final double principalAmount;
  final double outstandingBalance;
  final double monthlyPayment;
  final double interestRate;
  final DateTime? nextPaymentDate;
  final LoanStatus status;
  final DateTime? disbursementDate;
  final int? termMonths;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  Loan({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.principalAmount,
    required this.outstandingBalance,
    required this.monthlyPayment,
    required this.interestRate,
    this.nextPaymentDate,
    required this.status,
    this.disbursementDate,
    this.termMonths,
    required this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  double get repaidAmount => principalAmount - outstandingBalance;
  double get repaymentProgress => repaidAmount / principalAmount;

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      principalAmount: (json['principal_amount'] as num).toDouble(),
      outstandingBalance: (json['outstanding_balance'] as num).toDouble(),
      monthlyPayment: (json['monthly_payment'] as num).toDouble(),
      interestRate: (json['interest_rate'] as num).toDouble(),
      nextPaymentDate: json['next_payment_date'] != null 
          ? DateTime.parse(json['next_payment_date']) 
          : null,
      status: LoanStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => LoanStatus.pending,
      ),
      disbursementDate: json['disbursement_date'] != null 
          ? DateTime.parse(json['disbursement_date']) 
          : null,
      termMonths: json['term_months'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'product_name': productName,
      'principal_amount': principalAmount,
      'outstanding_balance': outstandingBalance,
      'monthly_payment': monthlyPayment,
      'interest_rate': interestRate,
      'next_payment_date': nextPaymentDate?.toIso8601String(),
      'status': status.name,
      'disbursement_date': disbursementDate?.toIso8601String(),
      'term_months': termMonths,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }
}

class LoanProduct {
  final String id;
  final String name;
  final String description;
  final double minAmount;
  final double maxAmount;
  final double interestRate;
  final int maxTerm;
  final bool isActive;
  final List<String>? requirements;
  final String? eligibilityCriteria;
  final Map<String, dynamic>? metadata;

  LoanProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.minAmount,
    required this.maxAmount,
    required this.interestRate,
    required this.maxTerm,
    this.isActive = true,
    this.requirements,
    this.eligibilityCriteria,
    this.metadata,
  });

  IconData get icon {
    switch (name.toLowerCase()) {
      case 'personal loan':
        return Icons.person;
      case 'home loan':
        return Icons.home;
      case 'car loan':
        return Icons.directions_car;
      case 'business loan':
        return Icons.business;
      default:
        return Icons.credit_card;
    }
  }

  factory LoanProduct.fromJson(Map<String, dynamic> json) {
    return LoanProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      minAmount: (json['min_amount'] as num).toDouble(),
      maxAmount: (json['max_amount'] as num).toDouble(),
      interestRate: (json['interest_rate'] as num).toDouble(),
      maxTerm: json['max_term'],
      isActive: json['is_active'] ?? true,
      requirements: json['requirements']?.cast<String>(),
      eligibilityCriteria: json['eligibility_criteria'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'min_amount': minAmount,
      'max_amount': maxAmount,
      'interest_rate': interestRate,
      'max_term': maxTerm,
      'is_active': isActive,
      'requirements': requirements,
      'eligibility_criteria': eligibilityCriteria,
      'metadata': metadata,
    };
  }
}
