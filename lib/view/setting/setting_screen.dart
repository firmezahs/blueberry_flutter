import 'package:ag_widgets/widgets/ag_app_button.dart';
import 'package:ag_widgets/widgets/ag_cached_image.dart';
import 'package:blueberry/generated/assets.dart';
import 'package:blueberry/main.dart';
import 'package:blueberry/utils/colors.dart';
import 'package:blueberry/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UniqueKey keyForExperienceWidget = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedScrollView(
        listAnimationType: ListAnimationType.None,
        padding: EdgeInsets.all(16),
        children: [
          context.statusBarHeight.toInt().height,
          Text("Profile Details", style: boldTextStyle(size: 20)).center(),
          26.height,
          AgCachedImage(imageUrl: "", width: 110, height: 110, isProfile: true, name: userStore.fullName.validate()).center(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: .min,
            children: [
              Text('${userStore.fullName.validate()}', style: boldTextStyle(size: 20)),
              2.height,
              Text('+91 ${userStore.mobileNumber.validate()}', style: primaryTextStyle()),
              2.height,
              Container(
                padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Icon(Icons.security_rounded, color: Colors.white, size: 16),
                    8.width,
                    Text('${userStore.isAdmin ? 'Admin' : 'Employee'}', style: secondaryTextStyle(color: Colors.white, size: 14)),
                  ],
                ),
                decoration: BoxDecoration(color: primaryColor, borderRadius: radius()),
              ),
            ],
          ).center(),
          32.height,
          // SettingItemWidget(
          //   padding: EdgeInsets.only(top: 10, bottom: 10),
          //   leading: buildLeadingWidget(context, image: Assets.iconsIcPassword, color: context.iconColor),
          //   title: "Terms & Conditions",
          //   trailing: buildTrailingWidget(context),
          //   onTap: () => CustomWebViewWidget(url: termsAndConditionsUrl, title: "Terms & Conditions", showBack: true).launch(context),
          // ),
          // SettingItemWidget(
          //   padding: EdgeInsets.only(top: 10, bottom: 10),
          //   leading: buildLeadingWidget(context, image: Assets.iconsIcPassword, color: context.iconColor),
          //   title: "Privacy Policy",
          //   trailing: buildTrailingWidget(context),
          //   onTap: () => CustomWebViewWidget(url: privacyPolicyUrl, title: "Privacy Policy", showBack: true).launch(context),
          // ),
          SettingItemWidget(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            leading: buildLeadingWidget(context, image: Assets.iconsIcPassword, color: context.iconColor),
            title: "App Version",
            trailing: FutureBuilder(
              future: getPackageInfo(),
              builder: (context, snap) {
                return Text("${snap.data?.versionName.validate()}", style: secondaryTextStyle());
              },
            ),
          ),
          32.height,
          AgAppButton(
            text: "Sign Out",
            onPressed: () {
              showConfirmDialogCustom(
                context,
                dialogType: DialogType.CONFIRMATION,
                primaryColor: context.primaryColor,
                positiveText: "Logout",
                title: "Log out",
                subTitle: "You’ll need to sign in again to continue.",
                onAccept: (context) {
                  userStore.logout();
                },
              );
            },
            solidColor: context.theme.colorScheme.error,
            textColor: Colors.white,
            borderColor: context.theme.colorScheme.error,
            borderRadius: 80,
            icon: Icon(Icons.logout, color: Colors.white),
          ),

          16.height,
          // Text("©${DateTime.now().year}. Made with ❤️ by Firmeza", style: secondaryTextStyle(color: context.primaryColor)).center(),
          // 20.height,
          if (isIOS) 24.height,
        ],
      ),
    );
  }
}
