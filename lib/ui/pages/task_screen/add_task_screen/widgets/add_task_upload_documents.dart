import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/app_title_with_add_button.dart';
import 'package:tasky/utils/file_utils.dart';

class AddTaskUploadDocuments extends StatelessWidget {
  final List<String> documentList;
  final Function(List<String>) onDelete;

  const AddTaskUploadDocuments({
    Key? key,
    required this.documentList,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTitleWithAddButton(
          onTap: () {},
          titleWidget: Text(
            S.current.category,
            style: AppTextStyle.blackS15W500,
          ),
        ),
        SizedBox(height: 20.h),
        Flexible(
          fit: FlexFit.loose,
          child: buildDocumentListView(),
        ),
      ],
    );
  }

  Widget buildDocumentListView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildDocumentItem(
          document: documentList[index],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8.h);
      },
      itemCount: documentList.length,
    );
  }

  Widget buildDocumentItem({
    required String document,
  }) {
    bool isTextFile = AppConfigs.listTextFileType.contains(
      splitDocumentName(document).last,
    );
    return SizedBox(
      height: 48.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 48.h,
            width: 48.h,
            decoration: BoxDecoration(
              color: AppColors.iconBackgroundColor,
              borderRadius: BorderRadius.circular(10).r,
            ),
            child: Center(
              child: SvgPicture.asset(
                isTextFile ? AppVectors.icTextFile : AppVectors.icImageFile,
                width: 24.h,
                height: 24.h,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  splitDocumentName(document).first,
                  style: AppTextStyle.blackO90S15W500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${splitDocumentName(document).last} file',
                  style: AppTextStyle.blackO50S13W400,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 24.w),
          InkWell(
            onTap: () {
              final List<String> removedList = [...documentList];
              removedList.remove(document);
              onDelete(removedList);
            },
            child: Icon(
              Icons.close,
              size: 24.r,
              color: AppColors.textBlack.withOpacity(0.45),
            ),
          ),
        ],
      ),
    );
  }

  List<String> splitDocumentName(String document) {
    return FileUtils.getDocumentName(document).split('.');
  }
}
