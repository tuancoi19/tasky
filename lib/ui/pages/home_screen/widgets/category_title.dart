import 'package:flutter/material.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/app_title_with_add_button.dart';

class CategoryTitle extends StatelessWidget {
  final Function() onTap;

  const CategoryTitle({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTitleWithAddButton(
      onTap: onTap,
      titleWidget: Text(
        S.current.categories,
        style: AppTextStyle.blackS15W500,
      ),
    );
  }
}
