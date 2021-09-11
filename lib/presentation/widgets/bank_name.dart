import 'package:flutter/material.dart';

class BankName extends StatelessWidget {
  const BankName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Bank Name and Logo
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance,
            color: Colors.blue[700],
          ),
          SizedBox(width: 10),
          Text(
            'Dominion Bank Corporation',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
                fontSize: 25),
          ),
        ],
      ),
    );
  }
}
