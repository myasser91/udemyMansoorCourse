// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/news_app/cubit/cubit.dart';
import 'package:messenger/layouts/news_app/cubit/states.dart';
import 'package:messenger/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var seachcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {

      var list = NewsCubit.get(context).searchlist!.articles;
        return Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: defaultFormField(
                controller: seachcontroller,
                type: TextInputType.text,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'search must not be empty';
                  }
                  return null;
                },
                onChange: (value) {
                NewsCubit.get(context).getsearch(value);
                },
                labelText: 'Search',
                prefixIcon: Icons.search_sharp,
              ),
            ),
            Expanded(child: Buildarticle(list, context,10,issearch: true,)),
          ]),
        );
      },
    );
  }
}
