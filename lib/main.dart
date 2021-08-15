import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app_layout.dart';
import 'package:shop_app/modules/about_us_screen/about_us_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/orders_screen/orders_screen.dart';
import 'package:shop_app/modules/products/product_details/product_details.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/shopping_cart/shopping_cart.dart';
import 'package:shop_app/modules/terms_and_conditions_screen/terms_and_conditions_screen.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoardingSkip = CacheHelper.getData(key: 'onBoardingSkip') ?? false;
  token = CacheHelper.getData(key: 'token') ?? '';
  runApp(MyApp(
    onBoardingSkip: onBoardingSkip,
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoardingSkip;
  final String token;

  MyApp({
    required this.onBoardingSkip,
    required this.token,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopCubit>(
          create: (BuildContext context) => ShopCubit()
            ..getModelData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getProfileData()
            ..getProductDetails(53)
            ..getInCartProducts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Karim Shop',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        routes: {
          LoginScreen.loginScreenRoute: (context) => LoginScreen(),
          RegisterScreen.registerScreenRoute: (context) => RegisterScreen(),
          ShopLayout.shopLayoutRoute: (context) => ShopLayout(),
          SearchScreen.searchScreenRoute: (context) => SearchScreen(),
          ProductDetails.productDetailsScreen: (context) => ProductDetails(),
          ShoppingCart.shoppingCartRoute: (context) => ShoppingCart(),
          ProfileScreen.profileScreenRoute: (context) => ProfileScreen(),
          AboutUsScreen.aboutUsScreen: (context) => AboutUsScreen(),
          TermsAndConditions.termsAndConditionsScreen: (context) =>
              TermsAndConditions(),
          OrdersScreen.ordersScreenRoute: (context) => OrdersScreen(),
        },
        home: onBoardingSkip
            ? ((token.isEmpty) ? LoginScreen() : ShopLayout())
            : OnBoardingScreen(),
      ),
    );
  }
}
