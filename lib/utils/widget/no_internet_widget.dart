import 'package:ag_widgets/widgets/ag_app_button.dart';
import 'package:blueberry/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 80, color: primaryColor),
          16.height,
          Text('No Internet Connection', style: boldTextStyle(size: 20)),
          8.height,
          Text('Please check your network settings and try again.', textAlign: TextAlign.center, style: secondaryTextStyle()).paddingSymmetric(horizontal: 32),
          24.height,
          AgAppButton(
            text: 'Retry',
            solidColor: primaryColor,
            textColor: Colors.white,
            onPressed: () async {
              if (await isNetworkAvailable()) {
                finish(context);
              } else {
                toast('Still no internet');
              }
            },
          ),
        ],
      ).center(),
    );
  }
}
