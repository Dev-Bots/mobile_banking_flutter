import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:mobile_banking/application/bloc/auth_bloc/auth_bloc.dart';
import 'package:mobile_banking/infrastructure/infrastructure.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;
  TransactionBloc({required this.transactionRepository})
      : super(TransactionInitial());

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    // +++++++++++++++++++++++ Client ++++++++++++++++++++++++++++++++

    // ======================== Transfer  ================================================
    if (event is ClientTransferButtonPressed) {
      final amount = event.amount;
      final receiverAccountNumber = event.receiverAccount;

      yield ClientTransferProcessing();

      try {
        var transfer =
            await transactionRepository.transfer(receiverAccountNumber, amount);
        print('$amount and $receiverAccountNumber');
        print(transfer);

        if (transfer != null) {
          yield ClientTransferSuccess(transferMessage: transfer);
        } else {
          yield ClientTransferFailure(
              error: "Something went wrong. Please try again!");
        }
      } catch (error) {
        yield ClientTransferFailure(error: error.toString());
      }
    }

    // ========================  Withdraw  ================================================

    if (event is ClientWithdrawButtonPressed) {
      final amount = event.amount;
      final agentAccount = event.agentAccount;

      yield ClientWithdrawProcessing();

      try {
        var withdraw =
            await transactionRepository.withdraw(agentAccount, amount);
        print('$amount and $agentAccount');
        print(withdraw);

        if (withdraw != null) {
          yield ClientWithdrawSuccess(withdrawMessage: withdraw);
        } else {
          yield ClientWithdrawFailure(
              error: "Something went wrong. Please try again!");
        }
      } catch (error) {
        yield ClientWithdrawFailure(error: error.toString());
      }
    }

    // +++++++++++++++++++++++ Agent ++++++++++++++++++++++++++++++++

    //===========================depositToClient=========================

    if (event is AgentDepositButtonPressed) {
      //
      final amount = event.amount;
      final clientAccountNumber = event.clientAccount; //

      yield AgentDepositProcessing(); //

      try {
        var deposit = await transactionRepository.depositToClient(
            //
            clientAccountNumber,
            amount);
        print('$amount and $clientAccountNumber'); //
        print(deposit);

        if (deposit != null) {
          yield AgentDepositSuccess(depositMessage: deposit); //
        } else {
          yield AgentDepositFailure(
              //
              error: "Something went wrong. Please try again!");
        }
      } catch (error) {
        yield AgentDepositFailure(error: error.toString());
      }
    }

    //===========================AgentWithdraw=========================

    if (event is AgentWithdrawButtonPressed) {
      final amount = event.amount;
      final adminAccount = event.adminAccount;

      yield AgentWithdrawProcessing();

      try {
        var withdraw =
            await transactionRepository.agentWithdraw(adminAccount, amount);
        print('$amount and $adminAccount');
        print(withdraw);

        if (withdraw != null) {
          yield AgentWithdrawSuccess(withdrawMessage: withdraw);
        } else {
          yield AgentWithdrawFailure(
              error: "Something went wrong. Please try again!");
        }
      } catch (error) {
        yield ClientWithdrawFailure(error: error.toString());
      }
    }

    // +++++++++++++++++++++++ Admin ++++++++++++++++++++++++++++++++

    //===========================DepositToAgent=========================

    if (event is AgentDepositButtonPressed) {
      //
      final amount = event.amount;
      final agentAccountNumber = event.clientAccount; //

      yield AdminDepositProcessing(); //

      try {
        var deposit = await transactionRepository.depositToClient(
            //
            agentAccountNumber,
            amount);
        print('$amount and $agentAccountNumber'); //
        print(deposit);

        if (deposit != null) {
          yield AdminDepositSuccess(depositMessage: deposit); //
        } else {
          yield AdminDepositFailure(
              //
              error: "Something went wrong. Please try again!");
        }
      } catch (error) {
        yield AdminDepositFailure(error: error.toString());
      }
    }
  }
}
