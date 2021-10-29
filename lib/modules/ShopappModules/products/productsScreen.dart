//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/cubit/shopcubit.dart';
import 'package:messenger/layouts/shopApp/cubit/shopstates.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:messenger/models/ShopModels/categoriesModel2.dart';
import 'package:messenger/models/ShopModels/homemodel.dart';
import 'package:messenger/shared/components/constants.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
      listener: (context, state) {
        if (state is ShopSuccessHomeDataState)ShopCubit.get(context).getuser();
      },
      builder: (context, state) {
        if (ShopCubit.get(context).homemodel == null ||
            ShopCubit.get(context).categoriesmodel == null ||
            ShopCubit.get(context).userModel == null ||
            ShopCubit.get(context).favoritesModel == null)
          return Center(child: CircularProgressIndicator());
        else
          return productbuilder(ShopCubit.get(context).homemodel!,
              ShopCubit.get(context).categoriesmodel!, context);
      },
    );
  }

  Widget productbuilder(
          HomeModel model, CategoriesModel categorymodel, context) =>
      SingleChildScrollView(
        
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
              items: model.data!.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categorymodel.data!.data![index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 5,
                          ),
                      itemCount: categorymodel.data!.data!.length),
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.7,
              children: List.generate(
                  model.data!.products.length,
                  (index) => buildGridProduct(
                      model.data!.products[index], index, context)),
            ),
          )
        ]),
      );

  Widget buildGridProduct(ProductsModel model, int index, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${model.price!.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: defaultColor,
                          height: 1,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice!.round()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            height: 1,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorite(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id]!
                                    ? defaultColor
                                    : Colors.grey,
                            child: Icon(Icons.favorite_border,
                                size: 14, color: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          
          Image(
            fit: BoxFit.cover,
            image: NetworkImage(model.image!),
            width: 100,
            height: 100,
          ),
          Container(
              color: Colors.black.withOpacity(.8),
              width: 100,
              child: Text(
                model.name!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              )),
        ],
      );
}
