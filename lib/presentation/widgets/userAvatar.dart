import 'package:flutter/material.dart';
// import 'package:project_demo/screens/other.dart';

class UserAvatar extends StatelessWidget {
  final Color color;
  const UserAvatar(
    this.color,
  );

  // const UserAvatar({Key key, this.color = Colors.red}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      backgroundColor: this.color,
    );
  }
}
