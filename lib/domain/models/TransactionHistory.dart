import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TransactionHistory extends Equatable {
  TransactionHistory({
    this.transactionId,
    this.accountNumber,
    required this.relatedAccount,
    required this.transactionType,
    this.remark, //It says text I assumed it was remark
    this.date,
  });

  final int? transactionId;
  final int? accountNumber;
  final int? relatedAccount;
  final String transactionType;
  final String? remark;

  final String? date;
  // Assuming there is no operation on frontend regarding date

  // final String? error;

  @override
  List<Object?> get props => [
        transactionId,
        accountNumber,
        relatedAccount,
        transactionType,
        remark,
        date,
      ];

  // Transactions.withError(String errorMessage) {
  //   error = errorMessage;
  // }

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        transactionId: json['id'],
        accountNumber: json['account_id'],
        relatedAccount: json['related_account'],
        transactionType: json['transaction_type'],
        remark: json['text'], //assuming that is what it means
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'account_id': accountNumber,
        'related_account': relatedAccount,
        'transaction_type': transactionType,
        'text': remark,
      };

  @override
  String toString() =>
      'History { id: $transactionId, account_id: $accountNumber, text: $remark, date: $date}';
}
