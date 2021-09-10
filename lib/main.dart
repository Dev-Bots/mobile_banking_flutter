import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_banking/domain/models/Agent.dart';
import 'package:mobile_banking/presentation/config/route_generator.dart';

// import 'application/bloc/auth_bloc/auth_bloc.dart';
import 'application/bloc/AuthBloc/auth_bloc.dart';

import 'package:mobile_banking/infrastructure/data_provider/data_provider.dart';
import 'package:mobile_banking/infrastructure/repository/repository.dart';
import 'package:http/http.dart' as http;

WidgetsBinding ensureInitialized() {
  if (WidgetsBinding.instance == null) WidgetsFlutterBinding();
  return WidgetsBinding.instance!;
}

void main() async {
  ensureInitialized();

  final repo = AccountRepository(
      dataProvider: AccountDataProvider(httpClient: http.Client()));

  runApp(BankingApp(
    accountRepository: repo,
  ));
  // repo.getCurrentUser();

  // var data_provider = TransactionDataProvider(httpClient: http.Client());
  // var repo = TransactionRepository(dataProvider: data_provider);

  // repo.depositToAgent('1000000002', 330);

  // runApp(MyApp());
}

class BankingApp extends StatelessWidget {
  final AccountRepository accountRepository;

  BankingApp({required this.accountRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.accountRepository,
      child: BlocProvider(
        create: (context) =>
            AuthBloc(accountRepository: this.accountRepository),
        child: MaterialApp(
          title: 'Banking App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: RouteGenerator.LoginPage,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}



// void main() => runApp(MyApp());

// void main() {
//   // ignore: non_constant_identifier_names
//   var data_provider = AccountDataProvider(httpClient: http.Client());
//   var repo = AccountRepository(dataProvider: data_provider);
//   print(repo.login('new', '1234'));

//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: RouteGenerator.LoginPage,
//       onGenerateRoute: RouteGenerator.generateRoute,
//     ),
//   );
// }

// var data_provider = TransactionDataProvider(httpClient: http.Client());
  // var repo = TransactionRepository(dataProvider: data_provider);
  // repo.getTransactions();

// void main() {
  // ignore: non_constant_identifier_names
  // var data_provider = AccountDataProvider(httpClient: http.Client());
  // var repo = AccountRepository(dataProvider: data_provider);
  // print(repo.login('new', '1234'));

  // final repo = AccountRepository(
  //     dataProvider: AccountDataProvider(httpClient: http.Client()));
  
