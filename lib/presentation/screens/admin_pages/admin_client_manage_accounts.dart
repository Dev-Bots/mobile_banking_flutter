import 'dart:io';

import 'package:mobile_banking/domain/models/Client.dart';
import 'package:mobile_banking/presentation/screens/admin_pages/admin_search_accounts.dart';
import 'package:mobile_banking/presentation/widgets/bank_name.dart';
import 'package:mobile_banking/application/bloc/AuthBloc/auth_bloc.dart';
import 'package:mobile_banking/infrastructure/repository/auth/accountRepository.dart';
import 'package:mobile_banking/infrastructure/data_provider/auth/accountProvider.dart';
import 'package:mobile_banking/presentation/widgets/info_card.dart';
import 'package:mobile_banking/presentation/theme/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AdminClientManageAccount extends StatelessWidget {
  final user;

  AdminClientManageAccount({
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
                  InfoCard('${user.accountType}', '${user.accountNumber}',
                      '\$${user.balance}'),
                  Dropdown(
                    accountNumber: user.accountNumber,
                  ),
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

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminSearchUser()),
        );
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

/// This is the stateful widget that the main application instantiates.
class Dropdown extends StatefulWidget {
  final accountNumber;
  const Dropdown({required this.accountNumber});

  @override
  State<Dropdown> createState() => DropdownWidget(accountNumber: accountNumber);
}

/// This is the private State class that goes with MyStatefulWidget.
class DropdownWidget extends State<Dropdown> {
  final accountNumber;
  DropdownWidget({required this.accountNumber});
  var holder = "";
  String dropdownValue = "Bronze";

  List<String> options = ['Gold', 'Silver', 'Bronze'];

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: dropdownValue,
          // icon: const Icon(Icons.arrow_downward),
          // iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 4,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        ElevatedButton(
          onPressed: () {
            int type = 3;
            final authBloc = BlocProvider.of<AuthBloc>(context);
            getDropDownItem();
            if (holder == 'Bronze') {
              type = 3;
            } else if (holder == 'Silver') {
              type = 2;
            } else if (holder == 'Gold') {
              type = 1;
            }

            authBloc.add(ChangeAccountType(
                accountNumber: '$accountNumber', accountType: type));
          },
          child: Text("Change Account Type"),
        ),
      ],
    );
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
