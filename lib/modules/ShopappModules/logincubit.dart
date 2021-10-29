import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/models/ShopModels/LoginModel.dart';
import 'package:messenger/modules/ShopappModules/loginstates.dart';
import 'package:messenger/shared/shared.network/endPoints.dart';
import 'package:messenger/shared/shared.network/remote/dio_Helper.dart';

class ShopLogInCubit extends Cubit<ShopLoginStates> {
  ShopLogInCubit() : super(ShopLoginInitialState());
  static ShopLogInCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginmodel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginmodel = ShopLoginModel.fromJson(value.data);
      
      emit(ShopLoginSucsessState(loginmodel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ShopLoginvisiblepassState());
  }
}
