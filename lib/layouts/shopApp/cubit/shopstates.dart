// ignore_for_file: unused_import

import 'package:messenger/layouts/shopApp/cubit/shopcubit.dart';
import 'package:messenger/models/ShopModels/ChangeFavoritesModel.dart';
import 'package:messenger/models/ShopModels/LoginModel.dart';
import 'package:messenger/models/ShopModels/registerModel.dart';

abstract class Shopstates {}

class ShopInitialState extends Shopstates {}

class ShopChangeBottomNavState extends Shopstates {}

class ShopLoadingHomeDataState extends Shopstates {}

class ShopSuccessHomeDataState extends Shopstates {}

class ShopErrorHomeDataState extends Shopstates {}

class ShopSuccessCategoriesDataState extends Shopstates {}

class ShopErrorCategoriesDataState extends Shopstates {}

class ShopSuccessChangeFavState extends Shopstates {}

class ShopChangeFavState extends Shopstates {}

class ShopErrorChangeFavState extends Shopstates {}

class ShopSuccessFAvoritesstate extends Shopstates {}

class ShopErrorFAvoritesstate extends Shopstates {}

class ShopLoadingGetFavoritesState extends Shopstates {}

class ShopSuccessUserdatastate extends Shopstates {
  final ShopLoginModel loginModel;

  ShopSuccessUserdatastate(this.loginModel);
}

class ShopErrorUserdatastate extends Shopstates {}

class ShopLoadingGetUserdataState extends Shopstates {}

class ShopRegisterSuccessState extends Shopstates {
  final ShopLoginModel model;

  ShopRegisterSuccessState(this.model);
}

class ShopRegisterErrorState extends Shopstates {}

class ShopRegistervisiblepassState extends Shopstates {}

class ShopUpdateSuccessState extends Shopstates {
  final ShopLoginModel model;

  ShopUpdateSuccessState(this.model);
}

class ShopUpdateLoadingState extends Shopstates {}

class ShopUpdateErrorState extends Shopstates {}
