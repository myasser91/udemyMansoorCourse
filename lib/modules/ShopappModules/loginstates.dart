import 'package:messenger/models/ShopModels/LoginModel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSucsessState extends ShopLoginStates {

  final ShopLoginModel loginModel;
  ShopLoginSucsessState (this.loginModel);
  
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}
class ShopLoginvisiblepassState extends ShopLoginStates{}