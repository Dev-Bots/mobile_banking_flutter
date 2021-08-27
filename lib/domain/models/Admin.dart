import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Admin extends Equatable {
  Admin(
      // Since we need all the information to return and we don't send any
      // requests with this model I assume everything is required
      {
    this.adminID,
    required this.accountNumber,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.role,
    required this.dob,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.isBlocked, //who's gonna block admin tho?
    required this.bankBudget,
  });

  final int? adminID;
  final int accountNumber;
  final String firstName;
  final String lastName;
  final String fullName;
  final String role;
  final String dob;
  final String email;
  final String phoneNumber;
  final String address;
  final bool isBlocked;
  final double? bankBudget;

  @override
  List<Object?> get props => [
        adminID,
        firstName,
        lastName,
        fullName,
        role,
        dob,
        email,
        phoneNumber,
        address,
        isBlocked,
        bankBudget
      ];

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
        adminID: json['id'],
        accountNumber: json['account_number'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        fullName: json['fullname'], // Don't know what will be received so...
        role: json['role'],
        address: json['address'],
        dob: json['DOB'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        isBlocked: json['is_blocked'],
        bankBudget: json['bank_budget']);
  }
  Map<String, dynamic> toJson() => {
        'id': adminID,
        'account_number': accountNumber,
        'first_name': firstName,
        'last_name': lastName,
        'fullname': fullName,
        'address': address,
        'email': email,
        'role': role,
        'phone_number': phoneNumber,
        'DOB': dob,
        'is_blocked': isBlocked,
        'bank_budget': bankBudget,
      };

  @override
  String toString() =>
      'Admin { admin_id: $adminID, first_name: $firstName, last_name: $lastName, fullname: $fullName,role: $role, address: $address, DOB: $dob, is_blocked:$isBlocked, bank_budget: $bankBudget}';
}
