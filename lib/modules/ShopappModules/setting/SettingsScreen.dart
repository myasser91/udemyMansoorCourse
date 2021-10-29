// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/cubit/shopcubit.dart';
import 'package:messenger/layouts/shopApp/cubit/shopstates.dart';
import 'package:messenger/modules/ShopappModules/shopLoginScreen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';
class ShopSettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(listener: (context, state) {
      if (state is ShopUpdateSuccessState) {
        if (state.model.status!) {
          showToast(
              context: context,
              t: state.model.message!,
              state: ToastStates.SUCCESS);
          ShopCubit.get(context).getuser();
        } else {
          print(state.model.message);
          showToast(
              context: context,
              t: state.model.message!,
              state: ToastStates.ERROR);
          ShopCubit.get(context).getuser();
        }
      }
    }, builder: (context, state) {
      
      nameController.text = ShopCubit.get(context).userModel!.data!.name!;
      emailController.text = ShopCubit.get(context).userModel!.data!.email!;
      phoneController.text = ShopCubit.get(context).userModel!.data!.phone!;
      if (ShopCubit.get(context).userModel == null) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Form(
          key: formkey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is ShopUpdateLoadingState)
                      LinearProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'must be entered';
                            }
                          },
                          labelText: 'FULL NAME',
                          prefixIcon: Icons.person,
                          onChange: (value) {
                            print(value);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defaultFormField(
                        controller: emailController,
                        type: TextInputType.name,
                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'must be entered';
                          }
                        },
                        labelText: 'EMAIL ADDRESS',
                        prefixIcon: Icons.email,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defaultFormField(
                          controller: phoneController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'must be entered';
                            }
                          },
                          labelText: 'PHONE NUMBER',
                          prefixIcon: Icons.phone_android),
                    ),
                    state is ShopUpdateLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: defaultButtom(
                                onpress: () {
                                  if (formkey.currentState?.validate() !=
                                      null) {
                                    ShopCubit.get(context).updateUserDAta(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text);
                                  }
                                },
                                text: 'update'),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defaultButtom(
                          onpress: () => SignOut(context), text: 'logout'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  void SignOut(context) {
    CashHelper.removedata(key: 'token').then((value) {
      if (value) {
        NavigateToreplace(context, ShopLoginScreen());
        ShopCubit.get(context).currentindex = 0;
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
}
