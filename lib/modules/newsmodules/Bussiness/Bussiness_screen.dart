import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/news_app/cubit/cubit.dart';
import 'package:messenger/layouts/news_app/cubit/states.dart';
import 'package:messenger/shared/components/components.dart';

class BussinessScreen extends StatelessWidget {
  const BussinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).news;

          return Buildarticle(list!.articles, context,list.articles!.length);
        });
  }
}
