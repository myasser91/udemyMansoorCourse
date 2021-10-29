// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/cubit/shopcubit.dart';
import 'package:messenger/layouts/shopApp/cubit/shopstates.dart';
import 'package:messenger/models/ShopModels/categoriesModel2.dart';
import 'package:messenger/models/ShopModels/categoriesModel.dart';
import 'package:messenger/models/ShopModels/favoritesModel.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ShopLoadingGetFavoritesState) {
            return Center(child: CircularProgressIndicator());
          } else
            return ListView.separated(
              itemBuilder: (context, index) => favoritesitem(
                  ShopCubit.get(context).favoritesModel!.data!.data![index].product,
                  context),
              separatorBuilder: (context, index) => SizedBox(),
              itemCount:
                  ShopCubit.get(context).favoritesModel!.data!.data!.length,
            );
        });
  }

 }
