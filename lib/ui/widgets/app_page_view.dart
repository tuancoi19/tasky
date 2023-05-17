// import 'package:flutter/material.dart';
// import 'package:tasky/common/app_text_styles.dart';
//
// class AppPageCommon extends StatefulWidget {
//   final String? title;
//   final Widget? child;
//   final bool? centerTitle;
//   final bool isShowBackButton;
//   final VoidCallback? onBackPressed;
//   final bool isHideAppBar;
//   final bool? isSearchField;
//   final Color? backgroundColor;
//   final Function(String)? callBackKeywordChange;
//   final TextEditingController? searchController;
//   final List<Widget>? rightActions;
//   final bool? resizeToAvoidBottomInset;
//   final Widget? floatingActionButton;
//   final bool? isMultiLineTitle;
//
//   final bool hasChangeLanguagesItem;
//   final bool languageItemAtRight;
//
//   final Function? onReloadPage;
//
//   const AppPageCommon({
//     Key? key,
//     this.title,
//     this.child,
//     this.centerTitle,
//     this.isShowBackButton = true,
//     this.onBackPressed,
//     this.isHideAppBar = false,
//     this.isSearchField = false,
//     this.backgroundColor,
//     this.callBackKeywordChange,
//     this.searchController,
//     this.rightActions = const [],
//     this.resizeToAvoidBottomInset,
//     this.floatingActionButton,
//     this.isMultiLineTitle,
//     this.hasChangeLanguagesItem = true,
//     this.languageItemAtRight = true,
//     this.onReloadPage,
//   }) : super(key: key);
//
//   @override
//   State<AppPageCommon> createState() => _AppPageCommonState();
// }
//
// class _AppPageCommonState extends State<AppPageCommon> {
//   bool isShowSuffixClear = false;
//
//   double appbarHeight(String text, double maxWidth) {
//     final TextPainter textPainter = TextPainter(
//       text: TextSpan(text: text, style: AppTextStyle.secondaryS18),
//       textDirection: TextDirection.ltr,
//       textAlign: TextAlign.justify,
//       maxLines: 10,
//     )..layout(
//       minWidth: 0,
//       maxWidth: maxWidth - 64,
//     );
//     return textPainter.size.height;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
//       backgroundColor: widget.backgroundColor ?? AppColors.background,
//       appBar: widget.isHideAppBar
//           ? null
//           : AppBarWidget(
//         isMultiTitle: widget.isMultiLineTitle ?? false,
//         toolbarHeight: appbarHeight(
//             widget.title ?? "", MediaQuery.of(context).size.width) +
//             35,
//         title: widget.title ?? "",
//         titleTextStyle: AppTextStyle.primaryS18W600,
//         centerTitle: widget.centerTitle,
//         titleSpacing: 0,
//         isShowBackButton: widget.isShowBackButton,
//         onBackPressed: widget.onBackPressed,
//         searchWidget:
//         widget.isSearchField == true ? buildSearchField() : null,
//         rightActions: [
//           if (widget.hasChangeLanguagesItem &&
//               widget.languageItemAtRight == false) ...[
//             ChangeLanguageItem(
//               onReloadPage: widget.onReloadPage,
//             ),
//             const SizedBox(width: 15),
//           ],
//           ...widget.rightActions!,
//           if (widget.hasChangeLanguagesItem &&
//               widget.languageItemAtRight == true) ...[
//             ChangeLanguageItem(
//               onReloadPage: widget.onReloadPage,
//             ),
//             const SizedBox(width: 15),
//           ],
//         ],
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         child: widget.child,
//       ),
//       floatingActionButton: widget.floatingActionButton,
//     );
//   }
//
//   onChangeValue(String? text) {
//     if (widget.callBackKeywordChange != null) {
//       widget.callBackKeywordChange!(text ?? '');
//     }
//     setState(() {
//       isShowSuffixClear = text!.isNotEmpty;
//     });
//   }
//
//   Widget buildSearchField() {
//     return Container(
//       padding: const EdgeInsets.only(right: 16),
//       height: 36,
//       child: TextField(
//         autofocus: true,
//         controller: widget.searchController,
//         textAlignVertical: TextAlignVertical.center,
//         onChanged: onChangeValue,
//         style: AppTextStyle.blackS12,
//         decoration: InputDecoration(
//           hintText: S.current.search_hint,
//           filled: true,
//           fillColor: AppColors.backgroundSearchInput,
//           prefixIcon: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: SvgPicture.asset(
//               AppVectors.icSearch,
//             ),
//           ),
//           suffixIcon: isShowSuffixClear
//               ? InkWell(
//             onTap: () {
//               setState(() {
//                 isShowSuffixClear = false;
//               });
//               widget.searchController!.text = "";
//               if (widget.callBackKeywordChange != null) {
//                 widget.callBackKeywordChange!('');
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: SvgPicture.asset(
//                 AppVectors.icFalseAnswer,
//                 color: AppColors.secondary,
//               ),
//             ),
//           )
//               : const SizedBox(),
//           hintStyle: AppTextStyle.greyS12,
//           suffixIconConstraints: const BoxConstraints(maxHeight: 19),
//           prefixIconConstraints: const BoxConstraints(maxHeight: 19),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(width: 1, color: AppColors.divider),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(width: 1, color: AppColors.divider),
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }
// }
