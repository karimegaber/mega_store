import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/get_cart.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/in_cart_product_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/product_details_model.dart';
import 'package:shop_app/models/search_products_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopAppStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  //Used in see all feature..
  void incIndex() {
    currentIndex++;
    emit(ShopIncreaseBNBState());
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  Map<int, bool> favorites = {};

  HomeModel? homeModel;

  void getModelData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  ChangeFavoritesModel? changeFavoritesModel;

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesDataState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesDataState());
    });
  }

  late LoginModel userModel;

  void getProfileData() {
    emit(ShopLoadingGetProfileDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessGetProfileDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProfileDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateProfileDataState());
    DioHelper.putData(
      url: UPDATE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateProfileDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateProfileDataState());
    });
  }

  SearchProductsModel? searchProductsModel;

  void getSearchData(String searchWord) {
    emit(ShopLoadingGetSearchDataState());

    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': '$searchWord',
    }).then((value) {
      searchProductsModel = SearchProductsModel.fromJson(value.data);
      emit(ShopSuccessGetSearchDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetSearchDataState());
    });
  }

  ProductDetailsModel? productDetailsModel;

  void getProductDetails(int productID) {
    emit(ShopLoadingGetProductDetailsState());
    DioHelper.getData(url: 'products/$productID', token: token).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ShopSuccessGetProductDetailsState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProductDetailsState());
    });
  }

  AddToCart? addToCart;

  void addProductToCart(int productID) {
    emit(ShopLoadingAddProductToCartState());

    DioHelper.postData(url: CART, token: token, data: {
      'product_id': '$productID',
    }).then((value) {
      addToCart = AddToCart.fromJson(value.data);
      print('${addToCart!.status}, Added Successfully.');
      emit(ShopSuccessAddProductToCartState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorAddProductToCartState());
    });
  }

  GetCart? getCart;

  void getInCartProducts() {
    emit(ShopLoadingGetCartState());
    DioHelper.getData(url: CART, token: token).then((value) {
      getCart = GetCart.fromJson(value.data);
      emit(ShopSuccessGetCartState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetCartState());
    });
  }

  void deleteProductFromCart(int inCartProductID) {
    emit(ShopLoadingDeleteProductFromCartState());
    DioHelper.deleteData(
      url: '$CART/$inCartProductID',
      token: token,
    ).then((value) {
      if (value.data['status']) {
        getInCartProducts();
      }
      print(value.data['message']);
      emit(ShopSuccessDeleteProductFromCartState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorDeleteProductFromCartState());
    });
  }

  void updateQuantityOfInCartProduct(int inCartProductID, int quantity) {
    emit(ShopLoadingUpdateQuantityState());
    DioHelper.putData(
      url: '$CART/$inCartProductID',
      data: {
        'quantity': quantity,
      },
      token: token,
    ).then((value) {
      if (value.data['status']) {
        getInCartProducts();
      }
      emit(ShopSuccessUpdateQuantityState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateQuantityState());
    });
  }
}
