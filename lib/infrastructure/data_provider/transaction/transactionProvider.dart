import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mobile_banking/domain/models/models.dart';
import 'package:mobile_banking/insfrastructure/data_provider/config.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_banking/insfrastructure/data_provider/getToken.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionDataProvider {
  final _baseUrl = baseURL;
  final http.Client httpClient;

  TransactionDataProvider({required this.httpClient});
  // a method to save history into the cache
  Future<void> saveTransactionInCache(transactions) async {
    final prefs = await SharedPreferences.getInstance();
    var jsonList =
        transactions.map((transaction) => transaction.toJson()).toList();
    await prefs.setString('transactions', jsonEncode(jsonList));
  }

  // a method to retrieve history from cache
  Future getHistoryFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final transactions = prefs.getString('transactions');
    if (transactions == null) {
      throw Exception('No transaction found.');
    }
    var transObjs = jsonDecode(transactions)
        .map((transaction) => TransactionHistory.fromJson(transaction))
        .toList();
    return transObjs;
  }

  // ===========================getHistory========================================

  Future getTransactions() async {
    try {
      final response = await httpClient.get(
        Uri.http('$_baseUrl', '/api/account/transactions'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await getToken()
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var transactionList = data
            .map((transaction) => TransactionHistory.fromJson(transaction))
            .toList();
        print("setting transactions to cache");
        saveTransactionInCache(transactionList);
        return transactionList;
      } else {
        throw Exception("Can not find transaction.");
      }
    } on SocketException catch (_) {
      print("the device is offline, history from cache");
      var transactions = await getHistoryFromCache();
      print(transactions);
      return transactions;
    }
  }

  Future transfer(String recieverAccountNumber, double amount) async {
    final response = await httpClient.post(
        Uri.http('$_baseUrl', '/api/client/transfer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await getToken()
        },
        body: jsonEncode({
          "reciever_account_number": recieverAccountNumber,
          "amount": amount
        }));

    if (response.statusCode == 201) {
      print(jsonDecode(response.body)['message']);
      return jsonDecode(response.body)['message'];
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future withdraw(String recieverAccountNumber, double amount) async {
    final response = await httpClient.post(
        Uri.http('$_baseUrl', '/api/client/withdraw'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await getToken()
        },
        body: jsonEncode({
          "reciever_account_number": recieverAccountNumber,
          "amount": amount
        }));

    if (response.statusCode == 201) {
      print(jsonDecode(response.body)['message']);
      return jsonDecode(response.body)['message'];
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future depositToClient(String recieverAccountNumber, double amount) async {
    final response = await httpClient.post(
        Uri.http('$_baseUrl', '/api/agent/deposit'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await getToken()
        },
        body: jsonEncode({
          "reciever_account_number": recieverAccountNumber,
          "amount": amount
        }));

    if (response.statusCode == 201) {
      print(jsonDecode(response.body)['message']);
      return jsonDecode(response.body)['message'];
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future depositToAgent(String recieverAccountNumber, double amount) async {
    final response = await httpClient.post(
        Uri.http('$_baseUrl', '/api/admin/deposit/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await getToken()
        },
        body: jsonEncode({
          "reciever_account_number": recieverAccountNumber,
          "amount": amount
        }));

    if (response.statusCode == 201) {
      print(jsonDecode(response.body)['message']);
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future agentWithdraw(String recieverAccountNumber, double amount) async {
    final response = await httpClient.post(
        Uri.http('$_baseUrl', '/api/agent/get_cash'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': await getToken()
        },
        body: jsonEncode({
          "reciever_account_number": recieverAccountNumber,
          "amount": amount
        }));

    if (response.statusCode == 201) {
      print(jsonDecode(response.body)['message']);
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future agentPayment() async {
    final http.Response response = await httpClient.put(
      Uri.http('$_baseUrl', '/api/agent/request_payment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await getToken()
      },
    );

    if (response.statusCode == 201) {
      print(jsonDecode(response.body)['message']);
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future transactionDelete(int transactionId) async {
    final http.Response response = await httpClient.delete(
      Uri.http('$_baseUrl', '/api/account/transaction/$transactionId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await getToken()
      },
    );

    if (response.statusCode == 202) {
      print(jsonDecode(response.body)['message']);
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
