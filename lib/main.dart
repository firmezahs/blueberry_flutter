import 'package:blueberry/controller/app_loader_store.dart';
import 'package:blueberry/controller/app_store.dart';
import 'package:blueberry/controller/user_store.dart';
import 'package:blueberry/firebase_options.dart';
import 'package:blueberry/utils/app_theme.dart';
import 'package:blueberry/utils/colors.dart';
import 'package:blueberry/utils/config.dart';
import 'package:blueberry/utils/constant.dart';
import 'package:blueberry/utils/functions.dart';
import 'package:blueberry/utils/locale/applocalizations.dart';
import 'package:blueberry/utils/locale/base_language.dart';
import 'package:blueberry/utils/widget/fcm_service.dart';
import 'package:blueberry/utils/widget/local_notification_service.dart';
import 'package:blueberry/view/auth/controller/auth_store.dart';
import 'package:blueberry/view/dashboard/controller/dashboard_store.dart';
import 'package:blueberry/view/orders/controller/add_order_store.dart';
import 'package:blueberry/view/orders/controller/order_detail_store.dart';
import 'package:blueberry/view/orders/controller/order_listing_store.dart';
import 'package:blueberry/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

export 'package:blueberry/controller/app_loader_store.dart';

//region App languages
Languages? languages;
//endregion

AppStore appStore = AppStore();
AppLoaderStore appLoaderStore = AppLoaderStore();

DashboardStore dashboardStore = DashboardStore();

AuthStore authStore = AuthStore();
UserStore userStore = UserStore();
OrderListingStore orderListingStore = OrderListingStore();
OrderDetailStore orderDetailStore = OrderDetailStore();
AddOrderStore addOrderStore = AddOrderStore();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await LocalNotificationService.instance.init();
    await FirebaseMessagingService.instance.init();
  } on Exception catch (e) {
    log(e.toString());
  }

  await initialize();
  localeLanguageList = languageList();

  appButtonBackgroundColorGlobal = primaryColor;
  defaultAppButtonTextColorGlobal = Colors.white;

  appStore.setLanguage(DEFAULT_LANGUAGE);

  await initialize();
  localeLanguageList = languageList();

  appButtonBackgroundColorGlobal = primaryColor;
  defaultAppButtonTextColorGlobal = Colors.white;
  defaultRadius = 20;
  passwordLengthGlobal = 4;
  // textBoldSizeGlobal = 14;
  // textPrimarySizeGlobal = 14;
  // textSecondarySizeGlobal = 12;

  userStore.setLoggedIn(getBoolAsync(SharePreferencesKey.loggedIn));

  if (userStore.isLoggedIn.validate()) {
    userStore.setAccessToken(getStringAsync(SharePreferencesKey.accessToken));
    userStore.loadEmployeeData();
    appStore.loadPackagingData();
    appStore.loadOrderStatusData();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          navigatorKey: navigatorKey,
          themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: SplashScreen(),
          scrollBehavior: SBehavior(),
          supportedLocales: LanguageDataModel.languageLocales(),
          localizationsDelegates: [AppLocalizations(), GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
          localeResolutionCallback: (locale, supportedLocales) => locale,
          locale: Locale(appStore.selectedLanguageCode),
        );
      },
    );
  }
}
