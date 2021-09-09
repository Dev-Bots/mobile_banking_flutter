import 'package:mobile_banking/presentation/screens/agent_pages/deposit_to_client.dart';
import 'package:mobile_banking/presentation/screens/agent_pages/register_client.dart';
import 'package:mobile_banking/presentation/screens/history_page.dart';
import 'package:mobile_banking/presentation/widgets/menu_card_layout.dart';
import 'package:mobile_banking/presentation/widgets/route_cards.dart';
import 'package:flutter/material.dart';

class AgentMenuLayout extends StatelessWidget {
  const AgentMenuLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MenuCardLayout(
      InkWell(
        child: RouteCard("Add User", Icon(Icons.ac_unit), Colors.blue),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClientRegister()),
          );
        },
      ),
      InkWell(
        child: RouteCard(
            "Deposit to User", Icon(Icons.ac_unit), Colors.lightGreen),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DepositToClient()),
          );
        },
      ),
      InkWell(
        child: RouteCard("Transactions", Icon(Icons.ac_unit), Colors.blue),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoryPage()),
          );
        },
      ),
      InkWell(
        child: RouteCard("Request Pay", Icon(Icons.ac_unit), Colors.lightGreen),
      ),
    ));
  }
}
