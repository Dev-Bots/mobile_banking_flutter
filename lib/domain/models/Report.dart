import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//Model Class to backup all attributes replicated in each class
// "total_money_in_bank": sum(amounts),
// "total_money_in_loan": sum(amount_in_loan),
// "num_of_admins": admins.count(),
// "num_of_agents": agents.count(),
// "num_of_clients": clients.count(),
// "all_accounts": [account.serialize_general_info() for account in accounts],
// "loans": [loan.serialize() for loan in loans],

@immutable
class Report extends Equatable {
  Report({
    required this.totalMoneyInBank,
    required this.totalMoneyInLoan,
    required this.numOfAdmins,
    required this.numOfAgents,
    required this.numOfClients,
    required this.allAccounts,
    required this.loans,
  });

  final double totalMoneyInBank;
  final double totalMoneyInLoan;
  final int numOfAdmins;
  final int numOfAgents;
  final int numOfClients;
  final allAccounts;
  final loans;

  @override
  List<Object?> get props => [
        totalMoneyInBank,
        totalMoneyInLoan,
        numOfAdmins,
        numOfAgents,
        numOfClients,
        allAccounts,
        loans,
      ];

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        totalMoneyInBank: json['total_money_in_bank'],
        totalMoneyInLoan: json['total_money_in_loan'],
        numOfAdmins: json['num_of_admins'],
        numOfAgents: json['num_of_agents'],
        numOfClients: json['num_of_clients'],
        allAccounts: json['all_accounts'],
        loans: json['loans']);
  }

  @override
  String toString() => 'Report object';
}
