import 'package:flutter/material.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/home_screen/widgets/home_add_button.dart';

class CategoryTitle extends StatelessWidget {
  final Function() onTap;

  const CategoryTitle({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          S.current.categories,
          style: AppTextStyle.blackS15W500,
        ),
        HomeAddButton(
          onTap: onTap,
        ),
      ],
    );
  }
}
