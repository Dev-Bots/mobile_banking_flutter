import 'package:flutter/material.dart';

class MenuCardLayout extends StatelessWidget {
  final InkWell topLeft;
  final InkWell topRight;
  final InkWell bottomLeft;
  final InkWell bottomRight;
  const MenuCardLayout(
      this.topLeft, this.topRight, this.bottomLeft, this.bottomRight);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [this.topLeft, this.topRight],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              this.bottomLeft,
              this.bottomRight,
            ],
          ),
        ],
      ),
    );
  }
}
