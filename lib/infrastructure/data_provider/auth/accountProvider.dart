import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'package:mobile_banking/domain/models/models.dart';
import 'package:mobile_banking/infrastructure/data_provider/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_banking/infrastructure/data_provider/getToken.dart';

class AccountDataProvider {
  final _baseUrl = baseURL;
  final http.Client httpClient;

  AccountDataProvider({required this.httpClient});

  // shared preference methods \\
// ###################################################### \\
  Future<void> setToken(token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');

    if (user == null) {
      return null;
    }
    try {
      var userFromServer =
          await getAccount(jsonDecode(user)['account_number'].toString());
      return userFromServer;
    } on SocketException catch (_) {
      if (jsonDecode(user)['role'] == 'client') {
        print(Client.fromJson(jsonDecode(user)));
        return Client.fromJson(jsonDecode(user));
      } else if (jsonDecode(user)['role'] == 'agent') {
        print(Agent.fromJson(jsonDecode(user)));
        return Agent.fromJson(jsonDecode(user));
      } else if (jsonDecode(user)['role'] == 'admin') {
        print(Admin.fromJson(jsonDecode(user)));
        return Admin.fromJson(jsonDecode(user));
      }
    }
  }

  Future<void> saveLoggedInUser(user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

// ###################################################### \\
  // shared preference methods end \\
  Future login(String username, String password) async {
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await httpClient.get(
      Uri.http('$_baseUrl', '/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': basicAuth
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      await setToken(data['token']);
      if (data['role'] == 'client') {
        print(Client.fromJson(data));
        saveLoggedInUser(Client.fromJson(data));
        return Client.fromJson(data);
      } else if (data['role'] == 'agent') {
        print(Agent.fromJson(data));
        saveLoggedInUser(Agent.fromJson(data));
        return Agent.fromJson(data);
      } else if (data['role'] == 'admin') {
        print(Admin.fromJson(data));
        saveLoggedInUser(Admin.fromJson(data));
        return Admin.fromJson(data);
      } else {
        return "No user found";
      }
      // Text('$TransctionHistory.fromJson(jsonDecode(response.body))');
      // return TransactionHistory.fromJson(jsonDecode(response.body));
    } else {
      // Text("data");
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future registerAgent(Agent agent) async {
    final response = await httpClient.post(
        Uri.http('$_baseUrl', '/api/admin/register_agent'),
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': await getToken()
        },
        body: json.encode(agent.toJson()));

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['message'];
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future registerClient(Client client) async {
    print(client.toJson());
    final response = await httpClient.post(
        Uri.http('$_baseUrl', '/api/agent/register_client'),
        headers: <String, String>{
          "Content-Type": "application/json",
          'token': await getToken()
        },
        body: json.encode(client.toJson()));

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['message'];
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future getAccount(String accountNumber) async {
    final token = await getToken();
    final response = await httpClient.get(
      Uri.http('$_baseUrl', '/api/account/$accountNumber'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['role'] == 'client') {
        print(Client.fromJson(data));
        return Client.fromJson(data);
      } else if (data['role'] == 'agent') {
        print(Agent.fromJson(data));
        return Agent.fromJson(data);
      } else if (data['role'] == 'admin') {
        print(Admin.fromJson(data));
        return Admin.fromJson(data);
      } else {
        return "No user found";
      }
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future changePassword(String newPassword) async {
    final http.Response response = await httpClient.put(
      Uri.http('$_baseUrl', '/api/account/password_reset'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await getToken()
      },
      body: jsonEncode(<String, String>{"password": newPassword}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['message'];
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future saveAccount(String accountNumber) async {
    final http.Response response = await httpClient.put(
      Uri.http('$_baseUrl', '/api/client/save_account/$accountNumber'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await getToken()
      },
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['message'];
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future removeSaveAccount(String accountNumber) async {
    final http.Response response = await httpClient.delete(
      Uri.http('$_baseUrl', '/api/client/save_account/$accountNumber'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await getToken()
      },
    );

    if (response.statusCode == 202) {
      return jsonDecode(response.body)['message'];
    } else {
      print(jsonDecode(response.body)['message']);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future blockUnblocAccount(String accountNumber) async {
    final http.Response response = await httpClient.put(
      Uri.http('$_baseUrl', '/api/admin/block/$accountNumber'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await getToken()
      },
    );

    if (response.statusCode == 202) {
      return jsonDecode(response.body)['message'];
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future changeAccountType(String accountNumber, int type) async {
    final http.Response response = await httpClient.put(
      Uri.http('$_baseUrl', '/api/admin/change_type/$accountNumber'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await getToken()
      },
      body: jsonEncode(<String, int>{"account_type": type}),
    );

    if (response.statusCode == 202) {
      return jsonDecode(response.body)['message'];
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future getReport() async {
    final http.Response response = await httpClient.get(
      Uri.http('$_baseUrl', '/api/admin/reports'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': await getToken()
      },
    );

    if (response.statusCode == 200) {
      Report report = Report.fromJson(jsonDecode(response.body));
      return report;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
