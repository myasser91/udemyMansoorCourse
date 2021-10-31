import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/sociallogincubit/socialLogInStates.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';

class SocialLogInCubit extends Cubit<SocialLoginStates> {
  SocialLogInCubit() : super(SocialLoginInitialState());
  //ShopLoginModel? loginmodel;

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  static SocialLogInCubit get(context) => BlocProvider.of(context);

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(SocialLoginvisiblepassState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = value.user!.uid;
      CashHelper.savedata(key: 'uId', value: value.user!.uid);

      emit(SocialLoginSucsessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
      print(error.toString());
    });
  }
}
