import 'package:mobile_banking/presentation/config/route_generator.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_home.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_instantLoan.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_withdraw_screen.dart';
import 'package:mobile_banking/presentation/screens/history_page.dart';
import 'package:mobile_banking/presentation/screens/client_pages/client_transfer_screen.dart';
import 'package:mobile_banking/presentation/widgets/menu_card_layout.dart';
import 'package:mobile_banking/presentation/widgets/route_cards.dart';
import 'package:flutter/material.dart';

class ClientMenuLayout extends StatelessWidget {
  const ClientMenuLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MenuCardLayout(
      InkWell(
          child: RouteCard(
              "Transfer",
              Icon(
                Icons.import_export,
                color: Colors.lightGreen[800],
              ),
              Colors.blue),
          onTap: () {
            // Navigator.of(context).pushNamed('/userhome');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClientTransferPage()),
            );
          }),
      InkWell(
          child: RouteCard(
              "Instant Loan",
              Icon(Icons.monetization_on, color: Colors.blue[800]),
              Colors.lightGreen),
          onTap: () {
            // Navigator.of(context).pushNamed('/userhome');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClientInstantLoanPage()),
            );
          }),
      InkWell(
          child: RouteCard(
              "Rquest Withdraw",
              Icon(Icons.money_rounded, color: Colors.lightGreen[800]),
              Colors.blue),
          onTap: () {
            // Navigator.of(context).pushNamed('/userhome');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClientWithdrawPage()),
            );
          }),
      InkWell(
        child: RouteCard("Transactions",
            Icon(Icons.history, color: Colors.blue[800]), Colors.lightGreen),
        onTap: () {
          // Navigator.of(context).pushNamed('/userhome');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoryPage()),
          );
        },
      ),
    ));
  }
}
