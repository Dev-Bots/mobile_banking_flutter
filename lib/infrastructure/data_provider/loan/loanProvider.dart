import 'dart:async';
import 'dart:convert';
import 'package:mobile_banking/domain/models/models.dart';
import 'package:mobile_banking/insfrastructure/data_provider/config.dart';
import 'package:mobile_banking/insfrastructure/data_provider/getToken.dart';
import 'package:http/http.dart' as http;

class MyException implements Exception {
  final String message;
  MyException({required this.message});

  @override
  String toString() {
    return message;
  }
}

class LoanDataProvider {
  final _baseUrl = baseURL;
  final http.Client httpClient;

  LoanDataProvider({required this.httpClient});

  Future getLoanInfo() async {
    final response = await httpClient.get(
      Uri.http('$_baseUrl', '/api/loan'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await getToken()
      },
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Loan loan = Loan.fromJson(data);
      print(loan);
      return loan;
    } else {
      print(data['message']);
      throw Exception('Loan information failure.');
    }
  }

  Future takeLoan(double amount) async {
    final response = await httpClient.post(Uri.http('$_baseUrl', '/api/loan'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await getToken()
        },
        body: jsonEncode({"amount": amount}));
    var data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      print(data['message']);
      return data['message'];
    } else {
      print(data['message']);
      throw MyException(message: data['message']);
    }
  }

  Future loanTopUp(double amount) async {
    final response = await httpClient.put(Uri.http('$_baseUrl', '/api/loan'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await getToken()
        },
        body: jsonEncode({"topup": amount}));
    var data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      print(data['message']);
      return data['message'];
    } else {
      print(data['message']);
      throw Exception('Loan topup failed.');
    }
  }

  Future loanPayInFull() async {
    final response = await httpClient.delete(
      Uri.http('$_baseUrl', '/api/loan'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await getToken()
      },
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 202) {
      print(data['message']);
      return data;
    } else {
      print(data['message']);
      throw Exception('Loan pay in full failed.');
    }
  }
}
