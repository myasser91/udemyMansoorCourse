//import 'package:messenger/models/ShopModels/LoginModel.dart';

abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSucsessState extends SocialLoginStates {
  final String uId;

  SocialLoginSucsessState(this.uId);

}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialLoginvisiblepassState extends SocialLoginStates {}
class SocialGetUserLoadingState extends SocialLoginStates{}

