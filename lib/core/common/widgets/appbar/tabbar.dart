// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({
    Key? key,
    required this.tabs,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
  }) : super(key: key);

  final List<Widget> tabs;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TColors.background,
      child: TabBar(
        isScrollable: false,
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        indicatorColor: indicatorColor,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: tabs,
        dividerColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
