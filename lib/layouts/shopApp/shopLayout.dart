// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/cubit/shopcubit.dart';
import 'package:messenger/layouts/shopApp/cubit/shopstates.dart';
import 'package:messenger/modules/ShopappModules/SearchScreen/SearchScreen.dart';
import 'package:messenger/modules/ShopappModules/shopLoginScreen.dart';
import 'package:messenger/modules/otherModules/login/log_in.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';
import 'package:path/path.dart';

class ShopLayout extends StatelessWidget {
  void Logout(context) {
    CashHelper.removedata(key: 'token').then((value) {
      if (value) {
        ShopCubit.get(context).currentindex = 0;
        NavigateToreplace(context, ShopLoginScreen());
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){

                cubit.getHomeData();
                cubit.getFavorites();
                cubit.getuser();
                cubit.getCategoryData();
              }, icon: Icon(Icons.refresh)),
              IconButton(
                  onPressed: () {
                    NavigateTo(context, ShopSearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
              IconButton(
                onPressed: () {
                  Logout(context);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          body: cubit.bottomscreens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: ((int index) {
              cubit.changeBottomNav(index);
            }),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.grid_on_sharp), label: 'categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
