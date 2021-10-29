// ignore_for_file: unused_import

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/cubit/shopstates.dart';
import 'package:messenger/models/ShopModels/ChangeFavoritesModel.dart';
import 'package:messenger/models/ShopModels/LoginModel.dart';
import 'package:messenger/models/ShopModels/categoriesModel2.dart';
import 'package:messenger/models/ShopModels/categoriesModel.dart';
import 'package:messenger/models/ShopModels/favoritesModel.dart';
import 'package:messenger/models/ShopModels/homeModel2.dart';
import 'package:messenger/models/ShopModels/homemodel.dart';
import 'package:messenger/models/ShopModels/registerModel.dart';
import 'package:messenger/modules/ShopappModules/categories/categories.dart';
import 'package:messenger/modules/ShopappModules/favorites/favories.dart';
import 'package:messenger/modules/ShopappModules/products/productsScreen.dart';

import 'package:messenger/modules/ShopappModules/setting/SettingsScreen.dart';
import 'package:messenger/modules/newsmodules/search_module/searchScreen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/shared.network/endPoints.dart';
import 'package:messenger/shared/shared.network/remote/dio_Helper.dart';
import 'package:path/path.dart';

class ShopCubit extends Cubit<Shopstates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> bottomscreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ShopSettingsScreen(),
  ];
  void changeBottomNav(int index) {
    currentindex = index;

    emit(ShopChangeBottomNavState());
  }

  Map<int, bool> favorites = {};

  HomeModel? homemodel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homemodel = HomeModel.fromjson(value.data);
      homemodel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print(token);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesmodel;
  void getCategoryData() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesmodel = CategoriesModel.fromJson(value.data);
      // print(token);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(token: token, url: FAVORITES).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(token);
      emit(ShopSuccessFAvoritesstate());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFAvoritesstate());
    });
  }

  ShopLoginModel? userModel;
  void getuser() {
    emit(ShopLoadingGetUserdataState());
    DioHelper.getData(token: token, url: PROFILE).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      // print(userModel!.data!.name);
      // print(userModel!.data!.phone);
      // print(userModel!.data!.email);
    }).then((value) {
      emit(ShopSuccessUserdatastate(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserdatastate());
    });
  }

  void register({
    required String? name,
    required String? email,
    required String? phone,
    required String? password,
  }) {
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
      },
    ).then((value) {
      print(value.data);
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState());
    });
  }
ShopLoginModel? usermodel2;
  void updateUserDAta({
    String? name,
    String? email,
    String? phone,
  }) {
    emit(ShopUpdateLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'email': email,
        'phone': phone,
        'name': name,
      },
    ).then((value) {
      usermodel2 = ShopLoginModel.fromJson(value.data);

      print('GEtting user data');
    }).then((value) {
      emit(ShopUpdateSuccessState(usermodel2!));
    }).catchError((error) {
      print(error.toString());

      emit(ShopUpdateErrorState());
    });
  }

  ChangeFavoritesModel? changeFavorites;
  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavState());
    DioHelper.postData(url: FAVORITES, token: token, data: {
      'product_id': productId,
    }).then((value) {
      changeFavorites = ChangeFavoritesModel.fromJson(value.data);
      print(changeFavorites!.status);
      if (changeFavorites!.status == false) {
        favorites[productId] = !favorites[productId]!;
        print(changeFavorites!.message!);
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavState());
    }).catchError((error) {
      print(error.toString());
      favorites[productId] = !favorites[productId]!;
      print(changeFavorites!.message!);
      emit(ShopErrorChangeFavState());
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ShopRegistervisiblepassState());
  }
}
