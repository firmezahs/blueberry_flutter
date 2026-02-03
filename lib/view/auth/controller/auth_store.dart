import 'package:blueberry/main.dart';
import 'package:blueberry/utils/config.dart';
import 'package:blueberry/view/auth/controller/auth_api_controller.dart';
import 'package:blueberry/view/dashboard/dashboard_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  @observable
  TextEditingController emailCont = TextEditingController();

  @observable
  TextEditingController passCont = TextEditingController();

  @observable
  bool isRemember = true;

  @observable
  String? fcmToken;

  @observable
  String? inValidCredentials;

  @observable
  FocusNode emailFocusNode = FocusNode();

  @observable
  FocusNode passwordFocusNode = FocusNode();

  @action
  Future<void> setRememberValue(bool val, {bool isInitializing = false}) async {
    isRemember = val;
    if (!isInitializing) await setValue(SharePreferencesKey.isRemember, val);
  }

  @action
  Future<void> setInValidCredentialsValue(String? val) async {
    inValidCredentials = val;
  }

  @observable
  GlobalKey<FormState> signInFormState = GlobalKey();

  @action
  Future<void> onSignSubmit({required String? token, required BuildContext context}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
    if (signInFormState.currentState!.validate()) {
      signInFormState.currentState!.save();

      setInValidCredentialsValue(null);
      hideKeyboard(context);

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: true);

      Map<String, dynamic> request = {
        "mobile_number": emailCont.text,
        "password": passCont.text,
        "device_token": token != null && token.isNotEmpty ? token : getStringAsync(SharePreferencesKey.firebaseToken),
      };

      await AuthApiController.loginApi(request: request)
          .then((value) async {
            appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
            userStore.setAccessToken(value.loginData!.accessToken.validate());
            userStore.setEmployeeData(value.loginData!);

            userStore.setLoggedIn(true);

            appStore.init();

            toast("Login Successfully!!!");

            DashboardView().launch(getContext, isNewTask: true);
          })
          .catchError((e) {
            log(e);
            setInValidCredentialsValue(e);
            appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
          })
          .whenComplete(() {
            appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
          });
    }
  }

  @action
  Future<void> dispose() async {
    // Enter the dispose methods
    emailCont.clear();
    passCont.clear();
    setInValidCredentialsValue(null);
    signInFormState = GlobalKey();
  }
}
