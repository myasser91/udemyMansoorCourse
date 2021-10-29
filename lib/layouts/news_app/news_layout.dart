// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/news_app/cubit/cubit.dart';
import 'package:messenger/layouts/news_app/cubit/states.dart';
import 'package:messenger/main.dart';
import 'package:messenger/modules/newsmodules/search_module/searchScreen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/cubit/cubit.dart';
import 'package:messenger/shared/shared.network/remote/dio_Helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {
                NewsCubit.get(context).search = [];
NavigateTo(context, SearchScreen());


              }, icon: Icon(Icons.search_rounded)),
              IconButton(
                  onPressed: () {
                    NewsCubit.get(context).darkmodetoggle();
                    
                  },
                  icon: Icon(NewsCubit.get(context).isDark
                      ? Icons.dark_mode
                      : Icons.light_mode))
            ],
            title: Text('NEWS APP'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changenavbar(index);
            },
            currentIndex: cubit.currentindex,
            items: cubit.bottomitems,
          ),
          body: cubit.screens[cubit.currentindex],
        );
      },
    );
  }
}
