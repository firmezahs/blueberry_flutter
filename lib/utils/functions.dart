import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'assets/icons/ic_us.png'),
    LanguageDataModel(id: 13, name: 'Vietnam', languageCode: 'vi', fullLanguageCode: 'vi-VI', flag: 'assets/icons/ic_vi.png'),
  ];
}

InputDecoration inputDecoration({Widget? prefixIcon, Widget? suffixIcon, String? hint}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintText: hint,
    prefixIconConstraints: BoxConstraints(maxWidth: 80, minHeight: 0),
    // Adjust maxWidth
    suffixIconConstraints: suffixIcon != null ? BoxConstraints(maxWidth: 80, minHeight: 0) : null, // Adjust maxWidth
  );
}

String getCreatedOrEditedLabel({required String createdAt, required String updatedAt}) {
  final DateTime created = DateTime.parse(createdAt).toLocal();
  final DateTime updated = DateTime.parse(updatedAt).toLocal();

  String prefix = "Created at";

  // If both timestamps are different → Edited
  if (!created.isAtSameMomentAs(updated)) {
    prefix = 'Edited on';
  }

  // Format: Mon, 04 26 • 12:00 AM
  final String formattedDate = DateFormat('EEE, dd MM • hh:mm a').format(created);

  return '$prefix $formattedDate';
}

Widget buildTrailingWidget(BuildContext context, {IconData? iconData, Color? color, double? size}) {
  return Icon(iconData ?? Icons.arrow_forward_ios_rounded, size: size ?? 12, color: color ?? context.iconColor);
}

Widget buildLeadingWidget(BuildContext context, {required String? image, Color? color}) {
  return (image ?? "").agLoadImage(width: 22, height: 22, color: color ?? context.iconColor);
}

Widget buildDividerWidget() {
  return Divider(
    height: 0,
    indent: 0,
    // color: borderColor,
  );
}
