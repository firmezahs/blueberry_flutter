import 'dart:async';

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
import 'package:blueberry/utils/widget/no_internet_widget.dart';
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
  await LocalNotificationService.instance.init();
  log('Background message: ${message.messageId}');
  FirebaseMessagingService.instance.handleBackgroundMessage(message);
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
  defaultRadius = 20;
  passwordLengthGlobal = 4;

  // Load saved preferences
  appStore.setLanguage(getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: DEFAULT_LANGUAGE));
  // appStore.setDarkModeStatus(getBoolAsync(SharePreferencesKey.isDarkTheme));
  authStore.setRememberValue(getBoolAsync(SharePreferencesKey.isRemember), isInitializing: true);

  userStore.setLoggedIn(getBoolAsync(SharePreferencesKey.loggedIn), isInitializing: true);
  if (userStore.isLoggedIn.validate()) {
    userStore.setAccessToken(getStringAsync(SharePreferencesKey.accessToken), isInitializing: true);
    userStore.loadEmployeeData();
    appStore.loadPackagingData();
    appStore.loadOrderStatusData();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    LiveStream().on(AppConfig.tokenStream, (value) {
      if (value == true) {
        userStore.logout();
      }
    });
  }

  void initConnectivity() {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      setState(() {
        isOffline = result.contains(ConnectivityResult.none);
      });
      if (isOffline) {
        toast('No Internet Connection');
      }
    });
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

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
          themeMode: ThemeMode.light,
          home: isOffline ? NoInternetWidget() : SplashScreen(),
          scrollBehavior: SBehavior(),
          supportedLocales: LanguageDataModel.languageLocales(),
          localizationsDelegates: [AppLocalizations(), GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
          localeResolutionCallback: (locale, supportedLocales) => locale,
          locale: Locale(appStore.selectedLanguageCode),
          builder: (context, child) {
            return Stack(
              children: [
                child!,
                if (isOffline) Positioned.fill(child: NoInternetWidget()),
              ],
            );
          },
        );
      },
    );
  }
}
