// ignore_for_file: unused_import

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/cubit/shopstates.dart';
import 'package:messenger/layouts/social_app/registercubit/social_register_states.dart';
import 'package:messenger/models/ShopModels/ChangeFavoritesModel.dart';
import 'package:messenger/models/ShopModels/LoginModel.dart';
import 'package:messenger/models/ShopModels/categoriesModel2.dart';
import 'package:messenger/models/ShopModels/categoriesModel.dart';
import 'package:messenger/models/ShopModels/favoritesModel.dart';
import 'package:messenger/models/ShopModels/homeModel2.dart';
import 'package:messenger/models/ShopModels/homemodel.dart';
import 'package:messenger/models/ShopModels/registerModel.dart';
import 'package:messenger/models/socialModels/socialUserModel.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  //ShopLoginModel? userModel;
  
  void createUser({
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,
  }) {

SocialUserModel model = SocialUserModel(
  name: name,
  email: email,
  phone: phone,
  uId: uId,
  isEmailVerified : false,
  bio: 'Write your bio . .',
  coverimage:'https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg',

  image: 'https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg',
);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState(model.uId!));
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  void register({
    required String? name,
    required String? email,
    required String? phone,
    required String? password,
    
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!,)
        .then((value) {

            uId = value.user!.uid;
    
      createUser(name: name, email: email, phone: phone, uId: value.user!.uid);
     
    }).catchError((error) {
      emit(SocialRegisterErrorState());
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(SocialRegistervisiblepassState());
  }
}
