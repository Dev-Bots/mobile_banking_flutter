import 'package:flutter/material.dart';

class ClientBottomNavigation extends StatelessWidget {
  const ClientBottomNavigation({this.selectedIndex = 0, required this.onTap});

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
          icon: Icon(Icons.payment_rounded),
          label: 'Manage Loan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved Accounts',
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
