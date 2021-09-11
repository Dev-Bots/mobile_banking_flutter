import 'package:mobile_banking/presentation/screens/auth_page/login.dart';
import 'package:mobile_banking/presentation/widgets/bank_name.dart';
import 'package:mobile_banking/application/bloc/AuthBloc/auth_bloc.dart';
import 'package:mobile_banking/infrastructure/repository/auth/accountRepository.dart';
import 'package:mobile_banking/infrastructure/data_provider/auth/accountProvider.dart';
import 'package:mobile_banking/presentation/widgets/custom_admin_widgets/admin_menu.dart';
import 'package:mobile_banking/presentation/widgets/custom_client_widgets/client_menu.dart';
import 'package:mobile_banking/presentation/widgets/info_card.dart';
// import 'package:mobile_banking/presentation/widgets/menu_card_layout.dart';
import 'package:mobile_banking/presentation/widgets/name_card.dart';
import 'package:mobile_banking/presentation/theme/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AdminReport extends StatelessWidget {
  AdminReport({Key? key}) : super(key: key);

  final repo = AccountRepository(
      dataProvider: AccountDataProvider(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.repo,
      child: BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(accountRepository: this.repo)..add(GetGeneralReport()),
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is Proccessing) {
            return CircularProgressIndicator();
          } else if (state is ReportLoaded) {
            var report = state.report;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                toolbarHeight: 50,
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.white38,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    //Top Container
                    // color: AppColors.primaryWhite,
                    child: Column(
                      children: [
                        // BankName(),
                        // SizedBox(
                        //     height: MediaQuery.of(context).size.height / 5),
                        BankImage(),
                        ReportCard(
                            '\$${report.totalMoneyInBank}',
                            '\$${report.totalMoneyInLoan}',
                            '${report.numOfAdmins}',
                            '${report.numOfAgents}',
                            '${report.numOfClients}'),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return LoginScreen();
          }
        }),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String totalMoneyInBank;
  final String totalMoneyInLoan;
  final String numOfAdmins;
  final String numOfAgents;
  final String numOfClients;
  ReportCard(
    this.totalMoneyInBank,
    this.totalMoneyInLoan,
    this.numOfAdmins,
    this.numOfAgents,
    this.numOfClients,
  );
  @override
  Widget build(BuildContext context) {
    // var screensize = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 350,
          child: Card(
            color: Colors.lightBlue,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Total Budget Of Bank',
                          style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          this.totalMoneyInBank.toString(),
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Total Money in Loan ',
                          style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          this.totalMoneyInLoan.toString(),
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Number of Administrators ',
                          style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          this.numOfAdmins.toString(),
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Number of Agents ',
                          style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          this.numOfAgents.toString(),
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Number of Clients ',
                          style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          this.numOfClients.toString(),
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
          ),
        ),
      ],
    );
  }
}

class BankImage extends StatelessWidget {
  const BankImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: MediaQuery.of(context).size.height / 3,
      // decoration: BoxDecoration(color: Colors.black),
      child: Image.asset('assets/images/report.jpg'),
    );
  }
}
