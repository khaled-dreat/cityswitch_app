import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:cityswitch_app/core/utils/local_data/app_local_data_key.dart';
import 'package:cityswitch_app/features/add_store/presentation/pages/add_store_view.dart';
import 'package:cityswitch_app/features/home/presentation/pages/home_view.dart';
import 'package:cityswitch_app/features/my_store_details/presentation/pages/edit_my_store_view.dart';
import 'package:cityswitch_app/features/profile/presentation/pages/profile_view.dart';
import 'package:cityswitch_app/features/auth/domain/entities/user_entites.dart';

import '../../core/user_session/user_session_app.dart';
import '../my_messages/presentation/maneg/chat_cubit/messages_cubit.dart';
import '../my_messages/presentation/pages/my_messages.dart';
import '../my_msg_test/chat_view.dart';
import '../my_msg_test/socket_cubit.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final bool userHasStore;
  const CustomBottomNavigationBar({super.key, required this.userHasStore});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 2;
  late List<Widget> _pages = [const SizedBox()];

  @override
  void initState() {
    super.initState();
    loadFunctions();

    _setupPages();
  }

  Future<void> loadFunctions() async {
    context.read<MessagesCubit>().fetchConversation();
  }

  void _setupPages() {
    _pages = [
      // widget.userHasStore
      const EditMyStoreViewBody(),
      // : const AddStoreViewBody(),
      const ProfileView(),
      const HomeView(),
      MessagesScreen(),
    ];
    setState(() {});
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
