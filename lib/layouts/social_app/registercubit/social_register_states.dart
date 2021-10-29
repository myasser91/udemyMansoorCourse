// ignore_for_file: unused_import

import 'package:messenger/models/ShopModels/LoginModel.dart';

abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}
  // final ShopLoginModel model;
  // SocialRegisterSuccessState(this.model);


class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {}

class SocialRegistervisiblepassState extends SocialRegisterStates {}
class SocialCreateUserSuccessState extends SocialRegisterStates{

  final String uId;

  SocialCreateUserSuccessState(this.uId);
  
}
class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;
  SocialCreateUserErrorState(this.error);
}
