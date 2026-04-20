import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomConfirmDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? positiveText;
  final String? negativeText;
  final Color? positiveColor;
  final VoidCallback onAccept;
  final VoidCallback? onCancel;

  const CustomConfirmDialog({
    super.key,
    required this.title,
    required this.subTitle,
    this.positiveText,
    this.negativeText,
    this.positiveColor,
    required this.onAccept,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: radius(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: radius(20),
          boxShadow: defaultBoxShadow(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (positiveColor ?? context.primaryColor).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.help_outline,
                size: 32,
                color: positiveColor ?? context.primaryColor,
              ),
            ),
            24.height,
            Text(title, style: boldTextStyle(size: 20), textAlign: TextAlign.center),
            12.height,
            Text(subTitle, style: secondaryTextStyle(size: 14), textAlign: TextAlign.center),
            24.height,
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: negativeText ?? "Cancel",
                    textStyle: boldTextStyle(color: context.primaryColor),
                    color: context.cardColor,
                    onTap: () {
                      finish(context);
                      onCancel?.call();
                    },
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: radius(12),
                      side: BorderSide(color: context.primaryColor, width: 1),
                    ),
                    elevation: 0,
                  ),
                ),
                16.width,
                Expanded(
                  child: AppButton(
                    text: positiveText ?? "Confirm",
                    textStyle: boldTextStyle(color: Colors.white),
                    color: positiveColor ?? context.primaryColor,
                    onTap: () {
                      finish(context);
                      onAccept();
                    },
                    shapeBorder: RoundedRectangleBorder(borderRadius: radius(12)),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showCustomConfirmDialog(
  BuildContext context, {
  required String title,
  required String subTitle,
  String? positiveText,
  String? negativeText,
  Color? positiveColor,
  required VoidCallback onAccept,
  VoidCallback? onCancel,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CustomConfirmDialog(
        title: title,
        subTitle: subTitle,
        positiveText: positiveText,
        negativeText: negativeText,
        positiveColor: positiveColor,
        onAccept: onAccept,
        onCancel: onCancel,
      );
    },
  );
}
