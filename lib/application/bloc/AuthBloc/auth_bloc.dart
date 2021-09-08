import 'dart:async';
import 'package:mobile_banking/domain/models/models.dart';
import 'package:mobile_banking/insfrastructure/insfrastructure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AccountRepository accountRepository;
  // final AuthBloc authBloc;

  AuthBloc({required this.accountRepository}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is GetMyAccount) {
      yield AccountLoading();

      try {
        var user = await accountRepository.getCurrentUser();

        if (user != null) {
          yield AccountLoaded(user: user);
        } else {
          yield AccountFailed(error: "Failed to load.");
        }
      } catch (error) {
        yield AccountFailed(error: error.toString());
      }
    } else if (event is GetAccount) {
      yield AccountLoading();
      try {
        var user = await accountRepository.getAccount(event.accountNumber);
        if (user != null) {
          yield AccountLoaded(user: user);
        } else {
          yield AccountFailed(error: "Failed to load.");
        }
      } catch (error) {
        yield AccountFailed(error: error.toString());
      }
    } else if (event is RegisterAgent) {
      yield Proccessing(message: "Registering agent...");
      try {
        var proccess = await accountRepository.registerAgent(event.agent);
        yield ProccessFinished(message: proccess);
      } catch (error) {
        ProccessFailed(error: error.toString());
      }
    } else if (event is RegisterClient) {
      yield Proccessing(message: "Registering client...");
      try {
        var proccess = await accountRepository.registerClient(event.client);
        yield ProccessFinished(message: proccess);
      } catch (error) {
        ProccessFailed(error: error.toString());
      }
    } else if (event is ChangePassword) {
      yield Proccessing(message: "Changing password...");
      try {
        var proccess = await accountRepository.changePassword(event.password);
        yield ProccessFinished(message: proccess);
        print(proccess);
      } catch (error) {
        ProccessFailed(error: error.toString());
      }
    } else if (event is SaveAccount) {
      yield Proccessing(message: "Saving account...");
      try {
        var proccess = await accountRepository.saveAccount(event.accountNumber);
        yield ProccessFinished(message: proccess);
      } catch (error) {
        ProccessFailed(error: error.toString());
      }
    } else if (event is RemoveFromSaved) {
      yield Proccessing(message: "Removing account from list...");
      try {
        var proccess =
            await accountRepository.removeSavedAccount(event.accountNumber);
        yield ProccessFinished(message: proccess);
      } catch (error) {
        ProccessFailed(error: error.toString());
      }
    } else if (event is BlockUnblock) {
      yield Proccessing(message: "Processing request...");
      try {
        var proccess =
            await accountRepository.blockUnblockAccount(event.accountNumber);
        yield ProccessFinished(message: proccess);
      } catch (error) {
        ProccessFailed(error: error.toString());
      }
    } else if (event is ChangeAccountType) {
      yield Proccessing(message: "Account type change in progress...");
      try {
        var proccess = await accountRepository.changeAccountType(
            event.accountNumber, event.accountType);

        yield ProccessFinished(message: proccess);
      } catch (error) {
        ProccessFailed(error: error.toString());
      }
    } else if (event is GetGeneralReport) {
      yield Proccessing(message: "Getting Report...");
      try {
        var report = await accountRepository.getGeneralReport();
        yield ReportLoaded(report: report);
      } catch (error) {
        ProccessFailed(error: error.toString());
      }
    }
  }
}
