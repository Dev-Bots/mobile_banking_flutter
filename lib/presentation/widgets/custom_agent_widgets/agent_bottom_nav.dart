import 'package:flutter/material.dart';

class AgentBottomNavigation extends StatelessWidget {
  const AgentBottomNavigation({this.selectedIndex = 0, required this.onTap});

  final int selectedIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money_sharp),
          label: 'Request Payment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.settings),
        //   label: 'Settings',
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.person),
        //   label: 'Profile',
        // ),
      ],
      elevation: 10,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.lightGreenAccent,
      unselectedItemColor: Colors.cyanAccent,
      onTap: onTap,
    );
  }
}
