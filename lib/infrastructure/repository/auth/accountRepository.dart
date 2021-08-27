import 'package:mobile_banking/domain/models/models.dart';
import 'package:mobile_banking/domain/models/TransactionHistory.dart';
import 'package:mobile_banking/insfrastructure/data_provider/auth/accountProvider.dart';

class AccountRepository {
  final AccountDataProvider dataProvider;

  AccountRepository({required this.dataProvider});

  Future login(String username, String password) async {
    return await dataProvider.login(username, password);
  }

  Future registerAgent(Agent agent) async {
    return await dataProvider.registerAgent(agent);
  }

  Future registerClient(Client client) async {
    return await dataProvider.registerClient(client);
  }

  Future getAccount(String accountNumber) async {
    return await dataProvider.getAccount(accountNumber);
  }

  Future changePassword(String newPassword) async {
    return await dataProvider.changePassword(newPassword);
  }

  Future saveAccount(String accountNumber) async {
    return await dataProvider.saveAccount(accountNumber);
  }

  Future removeSavedAccount(String accountNumber) async {
    return await dataProvider.removeSaveAccount(accountNumber);
  }

  Future blockUnblockAccount(String accountNumber) async {
    return await dataProvider.blockUnblocAccount(accountNumber);
  }

  Future changeAccountType(String accountNumber, int type) async {
    return await dataProvider.changeAccountType(accountNumber, type);
  }

  Future getCurrentUser() async {
    return await dataProvider.getCurrentUser();
  }

// ############ admin reports
  Future getGeneralReport() async {
    return await dataProvider.getReport();
  }

  Future getAllLoans() async {
    Report data = await dataProvider.getReport();
    List loanJsonList = data.loans;
    var loans = loanJsonList.map((loan) => Loan.fromJson(loan)).toList();
    return loans;
  }

  Future getAllDatePassedLoans() async {
    Report data = await dataProvider.getReport();
    List loanJsonList = data.loans;
    var loans = loanJsonList
        .expand((loan) => [if (loan['date_passed']) Loan.fromJson(loan)])
        .toList();
    return loans;
  }

  Future getAllAccounts() async {
    Report data = await dataProvider.getReport();
    List accountJsonList = data.allAccounts;
    var accounts =
        accountJsonList.map((account) => Account.fromJson(account)).toList();
    return accounts;
  }
}

class NetworkError extends Error {}
