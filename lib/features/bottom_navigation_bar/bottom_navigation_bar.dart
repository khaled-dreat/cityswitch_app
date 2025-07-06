import 'package:cityswitch_app/features/add_store/presentation/pages/add_store_view.dart';
import 'package:cityswitch_app/features/home/presentation/pages/home_view.dart';
import 'package:flutter/material.dart';

import '../../core/utils/style/app_colers.dart';
import '../../test.dart';
import '../add_store/presentation/widgets/custom_select_categories.dart';
import '../my_messages/presentation/pages/my_messages.dart';
import '../profile/presentation/pages/profile_view.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 2;

  // الصفحات التي ستظهر
  final List<Widget> _pages = [
    AddStoreView(),
    ProfileView(),
    HomeView(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 16,
          selectedIconTheme: IconThemeData(size: 30),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add_business),
              label: 'Add Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: AppColors.grey400,
          unselectedLabelStyle: TextStyle(
            color: AppColors.grey400,
            fontSize: 25,
          ),
          selectedItemColor: AppColors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
