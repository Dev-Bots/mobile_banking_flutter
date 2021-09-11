import 'package:flutter/material.dart';

class SavedAccounts extends StatelessWidget {
  const SavedAccounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 40,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   TodoDetail.routeName,
              //   arguments: "My Todo - ${index + 1}",
              // );
              print("Hello");
            },
            child: Container(
                height: 40.0,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                margin: EdgeInsets.symmetric(vertical: 1.0),
                color: Colors.lightBlue,

                // alignment: Alignment.center,
                child: Center(
                  child: Text(
                    "Todo ${index + 1}",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                )),
          );
        },
      ),
    );
  }
}
