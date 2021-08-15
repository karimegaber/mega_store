import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

String token = '';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.loginScreenRoute);
    }
  });
}

String priceFix(String price) {
  if (price.length == 7) {
    return '${price.substring(0, 1)},${price.substring(1, price.length)} L.E';
  } else if (price.length == 6) {
    return '${price.substring(0, 3)},${price.substring(3, price.length)} L.E';
  } else if (price.length == 5) {
    return '${price.substring(0, 2)},${price.substring(2, price.length)} L.E';
  } else if (price.length == 4) {
    return '${price.substring(0, 1)},${price.substring(1, price.length)} L.E';
  } else {
    return '$price  L.E';
  }
}
