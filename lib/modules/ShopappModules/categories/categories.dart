import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/cubit/shopcubit.dart';
import 'package:messenger/layouts/shopApp/cubit/shopstates.dart';
import 'package:messenger/models/ShopModels/categoriesModel2.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) => builditem(ShopCubit.get(context).categoriesmodel!.data!.data![index]),
            separatorBuilder: (context, index) => SizedBox(),
            itemCount: ShopCubit.get(context).categoriesmodel!.data!.data!.length,
          );
        });
  }

  Widget builditem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image!,
              ),
              height: 100,
              width: 100,
            ),
            SizedBox(
              width: 20,
            ),
            Text(model.name!),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
