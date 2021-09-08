import 'package:flutter/material.dart';

class AdminBottomNavigation extends StatelessWidget {
  const AdminBottomNavigation({this.selectedIndex = 0, required this.onTap});

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
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.payment_rounded),
        //   label: 'Manage Loan',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pending_actions_sharp),
          label: 'Report',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'My Profile',
        ),
      ],
      elevation: 10,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.lightGreenAccent,
      unselectedItemColor: Colors.cyanAccent,
      onTap: onTap,
    );
  }
}
