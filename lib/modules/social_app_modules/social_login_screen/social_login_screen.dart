import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/social_Layout.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/sociallogincubit/socialLogInCubit.dart';
import 'package:messenger/layouts/social_app/sociallogincubit/socialLogInStates.dart';

import 'package:messenger/modules/social_app_modules/social_Register_screen/SocialregisterScreen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => SocialCubit()),
          BlocProvider(create: (BuildContext context) => SocialLogInCubit()),
        ],
        child: BlocConsumer<SocialLogInCubit, SocialLoginStates>(
          listener: (context, state) {
            if (state is SocialLoginErrorState) {
              showToast(
                  t: state.error.toString(),
                  state: ToastStates.ERROR,
                  context: context);
            }
            if (state is SocialLoginSucsessState) {
              CashHelper.savedata(
                key: 'uId',
                value: state.uId,
              );
              NavigateToreplace(context, SocialLayout());
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
                                .copyWith(color: Colors.teal),
                            // TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Welcome to Social App ',
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
                              } else
                                return null;
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
                              SocialLogInCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (formkey.currentState?.validate() != null) {
                                SocialLogInCubit.get(context).userLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                            controller: passwordcontroller,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'must be entered';
                              } else
                                return null;
                            },
                            type: TextInputType.text,
                            prefixIcon: Icons.password,
                            isPass: SocialLogInCubit.get(context).isPassword,
                            labelText: 'PASSWORD',
                            suffixIcon: SocialLogInCubit.get(context).suffix,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          state is SocialLoginLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : defaultButtom(radius: 30,width: 350,
                                  onpress: () {
                                    if (formkey.currentState?.validate() !=
                                        null) {
                                      SocialLogInCubit.get(context).userLogin(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text);
                                      // SocialCubit.get(context).getUserData();
                                      //  SocialCubit.get(context).getUsers();

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
