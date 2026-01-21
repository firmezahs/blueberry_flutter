import 'package:ag_widgets/ag_widgets.dart';
import 'package:ag_widgets/widgets/ag_app_button.dart';
import 'package:blueberry/generated/assets.dart';
import 'package:blueberry/main.dart';
import 'package:blueberry/utils/functions.dart';
import 'package:blueberry/view/auth/widget/auth_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBarWidget("Sign In"),
      body: AuthBodyWidget(
        title: "Welcome Back👋",
        subTitle: "Sign in to your account ",
        child: Form(
          key: authStore.signInFormState,
          child: AnimatedScrollView(
            padding: EdgeInsets.all(16),
            children: [
              AppTextField(
                textFieldType: TextFieldType.NUMBER,
                title: "Phone Number",
                controller: authStore.emailCont,
                focus: authStore.emailFocusNode,
                nextFocus: authStore.passwordFocusNode,
                decoration: inputDecoration(hint: "Enter phone number"),
              ),
              16.height,
              AppTextField(
                textFieldType: TextFieldType.PASSWORD,
                title: "Password",
                controller: authStore.passCont,
                focus: authStore.passwordFocusNode,
                suffixPasswordVisibleWidget: Assets.iconsIcPasswordShow.agLoadImage(height: 10, width: 10).paddingAll(14),
                suffixPasswordInvisibleWidget: Assets.iconsIcPasswordHide.agLoadImage(height: 10, width: 10).paddingAll(14),
                decoration: inputDecoration(hint: "Enter Password"),
              ),
              16.height,
              Observer(
                builder: (context) {
                  if (authStore.inValidCredentials.validate().isNotEmpty) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        8.height,
                        AgShakeText(text: authStore.inValidCredentials.validate()).paddingLeft(8),
                      ],
                    );
                  } else {
                    return Offstage();
                  }
                },
              ),
              16.height,
              AgAppButton(
                width: context.width(),
                text: "Login",
                textColor: Colors.white,
                solidColor: context.primaryColor,
                borderRadius: defaultRadius,
                isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.loginApiState].validate(),
                onPressed: () => authStore.onSignSubmit(token: appStore.fcmToken, context: context),
              ),
              16.height,
            ],
          ),
        ),
      ),
    );
  }
}
