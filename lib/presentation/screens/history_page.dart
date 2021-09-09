// import 'dart:io';

import 'package:mobile_banking/application/bloc/Historybloc/history_bloc.dart';
import 'package:mobile_banking/insfrastructure/data_provider/transaction/transactionProvider.dart';
import 'package:mobile_banking/insfrastructure/repository/transaction/TransactionRepository.dart';
import 'package:mobile_banking/presentation/theme/color_const.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);
  final transactionRepository = TransactionRepository(
      dataProvider: TransactionDataProvider(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.blue),
            backgroundColor: Colors.white38,
            title: Text(
              "My History",
              style: TextStyle(color: Colors.black),
            )),
        body: BlocProvider(
          create: (context) =>
              HistoryBloc(transactionRepository: transactionRepository)
                ..add(
                  GetTransactionsList(),
                ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<HistoryBloc, HistoryState>(
                    builder: (_, state) {
                      if (state is HistoryError) {
                        print("HistoryError");
                        return Text('Could not do course operation');
                      }
                      if (state is HistoryLoaded) {
                        print("HistoryLoaded");

                        final transactionHistorys = state.transactionHistorys;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: transactionHistorys.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Text(
                                    '${transactionHistorys[index].relatedAccount}'),
                                subtitle: Text(
                                    '${transactionHistorys[index].remark} + ${transactionHistorys.length} ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                                trailing: Text(
                                  '${transactionHistorys[index].transactionType}',
                                ));
                          },
                        );
                      }
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),

                          // height: 50,
                          // width: 50,
                          // child: ElevatedButton(
                          //   onPressed: () {
                          //     // HistoryBloc.add(GetTransactionsList());
                          //   },
                          //   child:
                          // ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
