import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String AccType;
  final String AccNum;
  final String AccBalance;
  const InfoCard(
    this.AccType,
    this.AccNum,
    this.AccBalance,
  );
  @override
  Widget build(BuildContext context) {
    // var screensize = MediaQuery.of(context).size.width;
    return Container(
      height: 250,
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
                      'Account Type ',
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      this.AccType,
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
                      this.AccNum,
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
                      this.AccBalance,
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
