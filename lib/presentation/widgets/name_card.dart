import 'package:flutter/material.dart';

class NameCard extends StatelessWidget {
  final String name;
  final String role;
  const NameCard(
    this.name,
    this.role,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      // width: ,
      child: Card(
        color: Colors.blue,
        // semanticContainer: true,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ListTile(
                leading: Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: Icon(
                    Icons.camera,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                ),
                title: Text(
                  this.name,
                  style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  this.role,
                  style: TextStyle(
                      color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                ),
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
