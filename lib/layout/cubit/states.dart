import 'package:shop_app/models/change_favorites_model.dart';

abstract class ShopAppStates {}

class ShopInitialState extends ShopAppStates {}

class ShopChangeBottomNavBarState extends ShopAppStates {}

class ShopLoadingHomeDataState extends ShopAppStates {}

class ShopSuccessHomeDataState extends ShopAppStates {}

class ShopErrorHomeDataState extends ShopAppStates {}

class ShopSuccessCategoriesDataState extends ShopAppStates {}

class ShopErrorCategoriesDataState extends ShopAppStates {}

class ShopIncreaseBNBState extends ShopAppStates {}

class ShopSuccessChangeFavoritesState extends ShopAppStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopAppStates {}

class ShopChangeFavoritesState extends ShopAppStates {}

class ShopLoadingGetFavoritesDataState extends ShopAppStates {}

class ShopSuccessGetFavoritesDataState extends ShopAppStates {}

class ShopErrorGetFavoritesDataState extends ShopAppStates {}

class ShopLoadingGetProfileDataState extends ShopAppStates {}

class ShopSuccessGetProfileDataState extends ShopAppStates {}

class ShopErrorGetProfileDataState extends ShopAppStates {}

class ShopLoadingUpdateProfileDataState extends ShopAppStates {}

class ShopSuccessUpdateProfileDataState extends ShopAppStates {}

class ShopErrorUpdateProfileDataState extends ShopAppStates {}

class ShopLoadingGetSearchDataState extends ShopAppStates {}

class ShopSuccessGetSearchDataState extends ShopAppStates {}

class ShopErrorGetSearchDataState extends ShopAppStates {}

class ShopLoadingGetProductDetailsState extends ShopAppStates {}

class ShopSuccessGetProductDetailsState extends ShopAppStates {}

class ShopErrorGetProductDetailsState extends ShopAppStates {}

class ShopLoadingAddProductToCartState extends ShopAppStates {}

class ShopSuccessAddProductToCartState extends ShopAppStates {}

class ShopErrorAddProductToCartState extends ShopAppStates {}

class ShopLoadingGetCartState extends ShopAppStates {}

class ShopSuccessGetCartState extends ShopAppStates {}

class ShopErrorGetCartState extends ShopAppStates {}

class ShopLoadingDeleteProductFromCartState extends ShopAppStates {}

class ShopSuccessDeleteProductFromCartState extends ShopAppStates {}

class ShopErrorDeleteProductFromCartState extends ShopAppStates {}

class ShopLoadingUpdateQuantityState extends ShopAppStates {}

class ShopSuccessUpdateQuantityState extends ShopAppStates {}

class ShopErrorUpdateQuantityState extends ShopAppStates {}
