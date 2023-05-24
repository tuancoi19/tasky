import 'package:flutter/material.dart';
import 'package:tasky/ui/widgets/buttons/home_add_button.dart';

class AppTitleWithAddButton extends StatelessWidget {
  final Widget titleWidget;
  final Function() onTap;
  final Color? color;

  const AppTitleWithAddButton({
    Key? key,
    required this.onTap,
    required this.titleWidget,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        titleWidget,
        HomeAddButton(
          onTap: onTap,
          color: color,
        ),
      ],
    );
  }
}
