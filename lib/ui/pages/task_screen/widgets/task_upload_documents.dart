import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/commons/app_bottom_sheet.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_upload_document_options.dart';
import 'package:tasky/ui/widgets/app_title_with_add_button.dart';
import 'package:tasky/utils/file_utils.dart';

class TaskUploadDocuments extends StatelessWidget {
  final List<String> documentList;
  final Function(List<String>) onDelete;
  final Function(File) sendImage;
  final Function(File) sendTextFile;
  final Color buttonColor;
  final bool allowToEdit;

  const TaskUploadDocuments({
    Key? key,
    required this.documentList,
    required this.onDelete,
    required this.sendImage,
    required this.sendTextFile,
    required this.buttonColor,
    required this.allowToEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> documents = [];
    for (var e in documentList) {
      documents.add(
        e.startsWith(AppConfigs.firebaseStoragePrefix)
            ? FileUtils.getFileNameFromUrl(e)
            : FileUtils.getDocumentName(e),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        allowToEdit
            ? AppTitleWithAddButton(
                onTap: () {
                  AppBottomSheet.show(
                    bottomSheet: TaskUploadDocumentOptions(
                      sendImage: sendImage,
                      sendTextFile: sendTextFile,
                    ),
                  );
                },
                color: buttonColor,
                titleWidget: Text(
                  S.current.documents,
                  style: AppTextStyle.blackS15W500,
                ),
              )
            : Text(
                S.current.documents,
                style: AppTextStyle.blackS15W500,
              ),
        SizedBox(height: 20.h),
        Flexible(
          fit: FlexFit.loose,
          child: buildDocumentListView(documents),
        ),
      ],
    );
  }

  Widget buildDocumentListView(List<String> documents) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildDocumentItem(
          document: documents[index],
          url: documentList[index],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8.h);
      },
      itemCount: documents.length,
    );
  }

  Widget buildDocumentItem({
    required String document,
    required String url,
  }) {
    bool isTextFile = AppConfigs.listTextFileType.contains(
      splitDocumentName(document).last,
    );
    return InkWell(
      onTap: () async {
        await FileUtils.openFile(url);
      },
      child: SizedBox(
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
                    S.current.type_file(
                      splitDocumentName(document).last.toUpperCase(),
                    ),
                    style: AppTextStyle.blackO50S13W400,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 24.w),
            if (allowToEdit)
              InkWell(
                onTap: () async {
                  await AppDialog.showConfirmDialog(
                    onConfirm: () {
                      final List<String> removedList = [...documentList];
                      removedList.removeWhere((element) {
                        final name =
                            element.startsWith(AppConfigs.firebaseStoragePrefix)
                                ? FileUtils.getFileNameFromUrl(element)
                                : FileUtils.getDocumentName(element);
                        return document == name;
                      });
                      onDelete(removedList);
                      Get.back();
                    },
                    title: S.current.delete_task,
                    message: S.current.delete_message,
                    color: buttonColor,
                  );
                },
                child: Icon(
                  Icons.close,
                  size: 24.r,
                  color: AppColors.textBlack.withOpacity(0.45),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<String> splitDocumentName(String document) {
    return FileUtils.getDocumentName(document).split('.');
  }
}
