// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiktok_tdd/core/common/widgets/icon/custom_add_icon.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/chat/presentation/pages/messages_screen.dart';
import 'package:tiktok_tdd/src/profile/presentation/pages/user_profile.dart';
import 'package:tiktok_tdd/src/reels/presentation/pages/feeds_screen.dart';
import 'package:tiktok_tdd/src/reels/presentation/pages/select_video_screen.dart';
import 'package:tiktok_tdd/src/search/presentation/pages/search_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _bottomNavIndex = 0;

  void changePage(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  List<Widget> bodyWidget = const [
    FeedsScreen(),
    SearchScreen(),
    SelectVideoScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<AppUserCubit>().getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        backgroundColor: TColors.background,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: changePage,
        currentIndex: _bottomNavIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade800,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: CustomAddIcon(), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
