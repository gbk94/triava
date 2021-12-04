import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarItemWidget extends StatelessWidget {
  const BottomNavigationBarItemWidget({
    Key? key,
    required this.iconPath,
    required this.selected,
    required this.onTap,
  }) : super(key: key);
  final String iconPath;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            height: 40,
            width: 40,
            constraints: const BoxConstraints(maxHeight: 40, maxWidth: 40),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              iconPath,
            ),
          ),
        ),
      ),
    );
  }
}
