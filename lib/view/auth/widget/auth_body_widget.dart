import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:blueberry/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthBodyWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Widget child;
  final Widget? headerChild;
  final bool? needBackButton;

  const AuthBodyWidget({Key? key, this.title, this.subTitle, required this.child, this.headerChild, this.needBackButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedScrollView(
          listAnimationType: ListAnimationType.None,
          padding: EdgeInsets.all(16),
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 👈 centers vertically
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Assets.assetsIcApplogo.agLoadImage(height: 140, width: 240, fit: BoxFit.contain).center(),
                    30.height,
                    Text(title ?? 'Welcome Back👋', style: primaryTextStyle(size: 28)).center(),
                    8.height,
                    Text(subTitle ?? 'Sign in to your account', style: secondaryTextStyle(size: 14)).center(),
                    26.height,
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: radius()),
                      child: child,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
