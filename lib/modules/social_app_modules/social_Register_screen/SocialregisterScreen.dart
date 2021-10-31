// ignore_for_file: unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/registercubit/social_register_cubit.dart';
import 'package:messenger/layouts/social_app/registercubit/social_register_states.dart';
import 'package:messenger/layouts/social_app/social_Layout.dart';
import 'package:messenger/modules/social_app_modules/social_login_screen/social_login_screen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialRegisterCubit(),
        child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
            listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            CashHelper.savedata(key: 'uId', value: state.uId);
            

            NavigateToreplace(context, SocialLayout());
          }
        }, builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormField(
                            controller: nameController,
                            labelText: 'NAME',
                            type: TextInputType.name,
                            prefixIcon: Icons.person,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'must be entered';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormField(
                            controller: emailController,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'must be entered';
                              }
                            },
                            type: TextInputType.emailAddress,
                            prefixIcon: Icons.email_outlined,
                            labelText: 'EMAIL ADRESS',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormField(
                            controller: phoneController,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'must be entered';
                              }
                            },
                            type: TextInputType.phone,
                            prefixIcon: Icons.phone,
                            labelText: 'PHONE NUMBER',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormField(
                              controller: passwordController,
                              validate: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'must be entered';
                                }
                              },
                              type: TextInputType.phone,
                              prefixIcon: Icons.password,
                              labelText: 'PASSWORD',
                              isPass:
                                  SocialRegisterCubit.get(context).isPassword,
                              suffixIcon:
                                  SocialRegisterCubit.get(context).suffix,
                              suffixpressed: () {
                                SocialRegisterCubit.get(context)
                                    .changePasswordVisibility();
                              }),
                        ),
                        state is SocialRegisterLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: defaultButtom(
                                  onpress: () {
                                    if (formkey.currentState?.validate() !=
                                        null) {
                                      SocialRegisterCubit.get(context).register(
                                          email: emailController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'register',
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
