import 'package:flutter/material.dart';
// import 'package:project_demo/screens/other.dart';

class RouteCard extends StatelessWidget {
  final Icon functionalityIcon;
  final String functionality;
  final Color colorCard;
  const RouteCard(
    this.functionality,
    this.functionalityIcon,
    this.colorCard,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        width: MediaQuery.of(context).size.width / 2.3,
        child: Card(
          color: this.colorCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: this.functionalityIcon),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      this.functionality,
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ));
  }
}
