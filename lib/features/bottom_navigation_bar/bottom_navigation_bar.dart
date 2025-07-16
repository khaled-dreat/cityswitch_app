// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cityswitch_app/features/add_store/presentation/pages/add_store_view.dart';
import 'package:cityswitch_app/features/home/presentation/pages/home_view.dart';

import '../../core/utils/style/app_colers.dart';
import '../../test.dart';
import '../../test2.dart';
import '../add_store/presentation/widgets/custom_select_categories.dart';
import '../my_messages/presentation/pages/my_messages.dart';
import '../my_store_details/presentation/pages/edit_my_store_view.dart';
import '../profile/presentation/pages/profile_view.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final bool userHasStore;
  const CustomBottomNavigationBar({super.key, required this.userHasStore});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 2;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      widget.userHasStore
          ? const EditMyStoreViewBody()
          : const AddStoreViewBody(),
      const ProfileView(),
      const HomeView(),
      MessagesScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.blue,
          unselectedItemColor: AppColors.grey400,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'My Store'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
          ],
        ),
      ),
    );
  }
}
