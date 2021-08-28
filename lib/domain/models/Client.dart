import 'package:equatable/equatable.dart';
import 'package:mobile_banking/domain/models/Agent.dart';
import 'package:flutter/material.dart';

@immutable
class Client extends Equatable {
  const Client({
    this.clientID,
    this.accountNumber,
    required this.firstName,
    required this.lastName,
    this.fullName,
    this.role, // inferred from sender
    required this.dob,
    required this.email,
    required this.phoneNumber,
    required this.address,
    this.isBlocked, // Can't decide if this is nullable because we don't have it when we send
    required this.balance,
    this.accountType, //inferred from initial deposit
    this.beneficiaries, //acquired later
    this.registeredBy,
  });

  final int? clientID;
  final int? accountNumber;
  final String firstName;
  final String lastName;
  final String? fullName;
  final role;
  final String dob;
  final email;
  final phoneNumber;
  final String address;
  final bool? isBlocked;
  final double? balance;
  final String? accountType;
  final List? beneficiaries; // I doubt this just made it to hold space
  final String? registeredBy;

  @override
  List<Object?> get props => [
        clientID,
        accountNumber,
        firstName,
        lastName,
        fullName,
        role,
        dob,
        email,
        phoneNumber,
        address,
        isBlocked,
        balance,
        accountType,
        beneficiaries,
        registeredBy,
      ];

  factory Client.fromJson(Map<String, dynamic> json) => Client(
      clientID: json['id'],
      accountNumber: json['account_number'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      fullName: json['fullname'],
      role: json['role'],
      address: json['address'],
      dob: json['DOB'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      isBlocked: json['is_blocked'],
      balance: json['balance'],
      accountType: json['account_type'],
      beneficiaries: json['saved'] != Null
          ? json['saved'].map((account) => Client.fromJson(account)).toList()
          : [],
      registeredBy: json['registered_by']);

  Map<String, dynamic> toJson() => {
        'id': clientID,
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
        'balance': balance,
        'account_type': accountType,
        'registered_by': registeredBy,
        'saved': beneficiaries,
      };
  @override
  String toString() =>
      'Client { account_number: $accountNumber, first_name: $firstName, last_name: $lastName, fullname: $fullName,role: $role, address: $address, DOB: $dob, is_blocked:$isBlocked, balance:$balance, account_type: $accountType}';
}
