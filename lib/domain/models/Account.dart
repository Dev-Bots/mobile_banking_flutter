import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//Model Class to backup all attributes replicated in each class

@immutable
class Account extends Equatable {
  Account(
      {required this.accountNumber,
      required this.firstName,
      required this.lastName,
      required this.fullName,
      required this.role,
      required this.dob,
      required this.address,
      required this.isBlocked});

  final int accountNumber;
  final String firstName;
  final String lastName;
  final String fullName;
  final String role;
  final String dob;
  final String address;
  final bool isBlocked;

  @override
  List<Object?> get props => [
        accountNumber,
        firstName,
        lastName,
        fullName,
        role,
        dob,
        address,
        isBlocked
      ];

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        accountNumber: json['account_number'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        fullName: json['fullname'], // Don't know what will be received so...
        role: json['role'],
        address: json['address'],
        dob: json['DOB'],
        isBlocked: json['is_blocked']);
  }

  @override
  String toString() =>
      'Account { account_number: $accountNumber, first_name: $firstName, last_name: $lastName, fullname: $fullName,role: $role, address: $address, DOB: $dob, is_blocked:$isBlocked}';
}
