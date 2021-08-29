import 'package:mobile_banking/domain/models/Client.dart';
import 'package:mobile_banking/presentation/widgets/bank_name.dart';
import 'package:mobile_banking/application/bloc/AuthBloc/auth_bloc.dart';
import 'package:mobile_banking/insfrastructure/repository/auth/accountRepository.dart';
import 'package:mobile_banking/insfrastructure/data_provider/auth/accountProvider.dart';
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
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              //Top Container
              // color: AppColors.primaryWhite,
              child: Column(
                children: [
                  BankName(),
                  InfoCard(
                      'Corporate', '${user.accountNumber}', '\$${user.budget}'),

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
      onPressed: () {
        final authBloc = BlocProvider.of<AuthBloc>(context);
        authBloc.add(BlockUnblock(accountNumber: '$accountNumber'));
      },
      child: Text("Block Account"),
    );
  }
}
