import 'package:mobile_banking/infrastructure/infrastructure.dart';
import 'package:mobile_banking/presentation/screens/admin_pages/admin_pages_frame.dart';
import 'package:mobile_banking/presentation/screens/agent_pages/agent_pages_frame.dart';
import 'package:mobile_banking/presentation/screens/auth_page/login.dart';
import 'package:mobile_banking/presentation/screens/history_page.dart';
import 'package:mobile_banking/presentation/screens/saved_accounts.dart';
import 'package:flutter/material.dart';
import 'package:mobile_banking/presentation/screens/profile_page.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_pages_frame.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_transfer_screen.dart';
// import 'package:mobile_banking/screens/other.dart';

class RouteGenerator {
  static const String LoginPage = "/";

  // static const String userRandomPage = "/random";

  //Client
  static const String HomePage = "/userhome";
  static const String userHistoryPage = "/userhistory";
  static const String check = "";
  static const String TransferPageRoute = "/transfer";

  //Agent
  // static const String agentHomePage = "/agenthistory";

  //Admin
  // static const String adminHomePage = "/adminhistory";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings
    //     .arguments; //We will use it if we need to pass data to another screen There is anf if code in comment below to implement it.
    switch (settings.name) {
      case LoginPage:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case userHistoryPage:
        return MaterialPageRoute(builder: (_) => HistoryPage());

      case TransferPageRoute:
        return MaterialPageRoute(builder: (_) => ClientTransferPage());

      case HomePage:
        switch (settings.arguments) {
          case 'client':
            return MaterialPageRoute(builder: (_) => ClientDashboard());
          case 'agent':
            return MaterialPageRoute(
                builder: (_) => AgentDashboard()); // change this
          case 'admin':
            return MaterialPageRoute(
                builder: (_) => AdminDashboard()); // change this
          default:
            return MaterialPageRoute(builder: (_) => LoginScreen());
        }

      // Client Routes

      // case userHomePage:
      //   return MaterialPageRoute(builder: (_) => ClientDashboard());

      // case userRandomPage:
      // if (args is String) {
      // builder: (_) => theOtherPage(
      // data: args,
      // )};
      //   return MaterialPageRoute(builder: (_) => AccountInfo());

      // case '/saved':
      //   return MaterialPageRoute(builder: (_) => SavedAccounts());

      // Agent Routes
      // case agentHomePage:
      //   return MaterialPageRoute(builder: (_) => ClientDashboard());

      // User Routes

      // case adminHomePage:
      //   return MaterialPageRoute(builder: (_) => ClientDashboard());

      default:
        throw FormatException("Route was not found");
    }
  }
}

// We can create a Route<dynamic> classed error handler like in Flutter Routes & Navigation – Parameters, Named Routes, onGenerateRoute video on Reso Coder
