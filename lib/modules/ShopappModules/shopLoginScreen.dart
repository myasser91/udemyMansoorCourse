import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/cubit/shopcubit.dart';
import 'package:messenger/layouts/shopApp/shopLayout.dart';

import 'package:messenger/modules/ShopappModules/logincubit.dart';
import 'package:messenger/modules/ShopappModules/loginstates.dart';

import 'package:messenger/modules/social_app_modules/social_Register_screen/SocialregisterScreen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
        create: (BuildContext context) => ShopLogInCubit(),
        child: BlocConsumer<ShopLogInCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSucsessState) {
              if (state.loginModel.status!) {
                showToast(
                    context: context,
                    t: state.loginModel.message!,
                    state: ToastStates.SUCCESS);
                CashHelper.savedata(
                        key: 'token', value: state.loginModel.data!.token)
                    .then((value) {
                  token = state.loginModel.data!.token;
                  NavigateToreplace(context, ShopLayout());
                });
              } else {
                print(state.loginModel.message);
                showToast(
                    context: context,
                    t: state.loginModel.message!,
                    state: ToastStates.ERROR);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN ',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.deepOrange),
                            // TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Login Now to Browse our Hoy Offers ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('email'),
                          SizedBox(
                            height: 5,
                          ),
                          defaultFormField(
                            controller: emailcontroller,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'must be entered';
                              }
                            },
                            type: TextInputType.emailAddress,
                            prefixIcon: Icons.email_outlined,
                            labelText: 'EMAIL ADRESS',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Password'),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            suffixpressed: () {
                              ShopLogInCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (formkey.currentState?.validate() != null) {
                                ShopLogInCubit.get(context).userLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                            controller: passwordcontroller,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'must be entered';
                              }
                            },
                            type: TextInputType.text,
                            prefixIcon: Icons.password,
                            isPass: ShopLogInCubit.get(context).isPassword,
                            labelText: 'PASSWORD',
                            suffixIcon: ShopLogInCubit.get(context).suffix,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          state is ShopLoginLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : defaultButtom(
                                  onpress: () {
                                    if (formkey.currentState?.validate() !=
                                        null) {
                                      ShopLogInCubit.get(context).userLogin(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text);
                                      ShopCubit.get(context).getuser();
                                      ShopCubit.get(context).getHomeData();
                                      ShopCubit.get(context).getFavorites();
                                      ShopCubit.get(context).getCategoryData();
                                    }
                                  },
                                  text: 'login',
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Don\'t have an account?'),
                              TextButton(
                                  onPressed: () {
                                    NavigateTo(
                                      context,
                                      RegisterScreen(),
                                    );
                                  },
                                  child: Text('Sign up ')),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
