import 'package:mobile_banking/domain/models/Client.dart';
import 'package:mobile_banking/presentation/widgets/bank_name.dart';
import 'package:mobile_banking/application/bloc/AuthBloc/auth_bloc.dart';
import 'package:mobile_banking/infrastructure/repository/auth/accountRepository.dart';
import 'package:mobile_banking/infrastructure/data_provider/auth/accountProvider.dart';
import 'package:mobile_banking/presentation/widgets/info_card.dart';
import 'package:mobile_banking/presentation/theme/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AdminAgentManageAccount extends StatelessWidget {
  final user;

  AdminAgentManageAccount({
    required this.user,
  });

  final repo = AccountRepository(
      dataProvider: AccountDataProvider(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 50,
          iconTheme: IconThemeData(color: Colors.lightBlue),
          backgroundColor: Colors.white38,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              //Top Container
              // color: AppColors.primaryWhite,
              child: Column(
                children: [
                  BankName(),
                  ManageCard('${user.fullName}', 'Corporate',
                      '${user.accountNumber}', '\$${user.budget}'),

                  BlockButton(
                    accountNumber: user.accountNumber,
                  ),
                  // TextButton(onPressed: ChangeAccountType(accountNumber: user.accountNumber, accountType: 2), child: child)
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is ProccessFinished) {
        final snackBar = SnackBar(content: Text(state.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (state is ProccessFailed) {
        print(state.error);
        final snackBar = SnackBar(content: Text(state.error));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (state is Proccessing) {
        final snackBar = SnackBar(content: Text(state.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}

class BlockButton extends StatelessWidget {
  final accountNumber;
  BlockButton({required this.accountNumber});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
      ),
      onPressed: () {
        final authBloc = BlocProvider.of<AuthBloc>(context);
        authBloc.add(BlockUnblock(accountNumber: '$accountNumber'));
      },
      child: Text("Block Account"),
    );
  }
}

class ManageCard extends StatelessWidget {
  final String fullName;
  final String accType;
  final String accNum;
  final String accBalance;
  const ManageCard(
    this.fullName,
    this.accType,
    this.accNum,
    this.accBalance,
  );
  @override
  Widget build(BuildContext context) {
    // var screensize = MediaQuery.of(context).size.width;
    return Container(
      height: 300,
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
                      'Owner Name ',
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      this.fullName,
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Account Type ',
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      this.accType,
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Account Number ',
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      this.accNum,
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Account Balance ',
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      this.accBalance,
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
    );
  }
}
