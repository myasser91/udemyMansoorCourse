// ignore_for_file: unused_import, non_constant_identifier_names

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:messenger/layouts/news_app/cubit/cubit.dart';
import 'package:messenger/layouts/shopApp/cubit/shopcubit.dart';

import 'package:messenger/models/NewsModels/topheadlineModel.dart';
import 'package:messenger/models/ShopModels/favoritesModel.dart';
import 'package:messenger/models/ShopModels/homemodel.dart';
import 'package:messenger/models/ShopModels/searchModel.dart';
import 'package:messenger/modules/newsmodules/webViewScreen/webview.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/cubit/cubit.dart';
import 'package:messenger/shared/cubit/states.dart';
import 'package:path/path.dart';
import 'package:tbib_toast/tbib_toast.dart';

Widget mytext({
  required String text,
  double? fontsize,
  FontWeight? weight,
  double? height,
  int? maxlines,
  TextOverflow? overflow,
}) =>
    Text(
      text,
      maxLines: maxlines,
      style: TextStyle(
        height: height ?? 1,
        color: Colors.black,
        fontSize: fontsize ?? 14,
        fontWeight: weight ?? FontWeight.normal,
        overflow: overflow,
      ),
    );

Widget defaultButtom({
  double width = double.infinity,
  Color background = Colors.black,
  double radius = 30,
  required Function onpress,
  required String text,
  Color bottomcolor = defaultColor,
}) =>
    Container(
      decoration: BoxDecoration(
          color: bottomcolor, borderRadius: BorderRadius.circular(radius)),
      width: width,
      height: 50,
      child: MaterialButton(
        onPressed: () {
          onpress();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );

Widget defaultFormField({
  TextEditingController? controller,
  String? labelText,
  Function? validate,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function? onChange,
  Function? onSubmit,
  Function? onTap,
  TextInputType? type,
  bool isPass = false,
  Function? suffixpressed,
  bool isclickable = true,
}) =>
    TextFormField(
      obscureText: isPass ? true : false,
      controller: controller,
      enabled: isclickable,
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () {
            if (suffixIcon != null) {
              suffixpressed!();
            } else {
              {}
            }
          },
        ),
        border: OutlineInputBorder(),
      ),
      validator: (value) => validate!(value),
      onChanged: (value) => onChange!(value),
      onFieldSubmitted: (value) => onSubmit!(value),
      onTap: () => onTap!(),
      keyboardType: type,
    );

Widget Buildtaskitem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  Appcubit.get(context)
                      .updatedata(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.done_rounded,
                  color: Colors.green,
                )),
            SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                  Appcubit.get(context)
                      .updatedata(status: 'acrchived', id: model['id']);
                },
                icon: Icon(
                  Icons.archive_outlined,
                  color: Colors.black54,
                )),
          ],
        ),
      ),
      onDismissed: (direction) {
        Appcubit.get(context).deletdata(id: model['id']);
      },
    );

Widget Buildarticle(list, context, int count, {issearch = false}) {
  return NewsCubit.get(context).newssport!.articles!.length > 0
      ? ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: count,
          separatorBuilder: (context, index) => SizedBox(
                height: 5,
              ),
          itemBuilder: (context, index) =>
              BuildArticleitem(list[index], context))
      : Center(child: issearch ? Container() : CircularProgressIndicator());
}

Widget BuildArticleitem(
  Article article,
  context,
) {
  if (article.urlToImage == null)
    article.urlToImage =
        'https://play-lh.googleusercontent.com/aCyq5_tBBCKcD5f4yuiE3kaNc1HDbPLA7Tq7PoEqBk1RVODSqJQUYpB_ekCrW23qnhw';
  return InkWell(
    onTap: () {
      NavigateTo(context, WebViewScreen(article.url!));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(article.urlToImage!)),
                borderRadius: BorderRadius.circular(18)),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      article.title != null ? article.title! : '',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    article.publishedAt != null
                        ? '${article.publishedAt.toString()}'
                        : '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void NavigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void NavigateToreplace(context, Widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => Widget));

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

void showToast({
  context,
  required String t,
  required ToastStates state,
}) =>
    Toast.show(t, context, backgroundColor: chooseToastColor(state));

Widget favoritesitem(
  Product? model,
  context,
) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model!.image!),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          model.image!,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Spacer(),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${model.price}",
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
                      if (1 != 0)
                        Text(
                          "${model.oldPrice}",
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
                                ShopCubit.get(context).favorites[model.id!]!
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
      ),
    );

Widget SearchItem(
  Products? model,
  context,
) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model!.image!),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          model.image!,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Spacer(),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${model.price}",
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
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorite(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id!]!
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
      ),
    );

Widget emailverification() {
  return Container(
    height: 50,
    color: Colors.amber,
    child: Row(
      children: [
        SizedBox(
          width: 5,
        ),
        Icon(Icons.info_outline),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: Text(
          '  please verify your email',
          style: TextStyle(color: Colors.black),
        )),
        defaultButtom(
          width: 80,
          bottomcolor: Colors.transparent,
          onpress: () {
            FirebaseAuth.instance.currentUser!
                .sendEmailVerification()
                .then((value) {
              showToast(
                  context: context,
                  t: 'Check your Email',
                  state: ToastStates.SUCCESS);
            }).catchError((error) {
              print(error.toString());
            });
          },
          text: 'send',
        ),
      ],
    ),
  );
}
          //   (!FirebaseAuth.instance.currentUser!.emailVerified)
          //        },
          // ),   return if