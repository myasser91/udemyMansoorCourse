// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/SearchCubit/searchCubit.dart';
import 'package:messenger/layouts/shopApp/SearchCubit/searchState.dart';
import 'package:messenger/shared/components/components.dart';

class ShopSearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
 Widget build(BuildContext context) {
 return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: defaultFormField(
                              controller: searchController,
                              type: TextInputType.text,
                              labelText: 'SEARCH HERE ',
                              prefixIcon: Icons.search,
                              onSubmit: (String? searchController) {
                                SearchCubit.get(context)
                                    .search(searchController!);
                              },
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Enter someThing';
                                } else {
                                  return null;
                                }
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (state is SearchLoadingState)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: LinearProgressIndicator(),
                          ),
                        if (state is SearchSuccessState)
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) => SearchItem(
                                  SearchCubit.get(context)
                                      .model!
                                      .data!
                                      .data![index],
                                  context),
                              separatorBuilder: (context, index) => SizedBox(),
                              itemCount: SearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data!
                                  .length,
                            ),
                          ),
                      ],
                    ),
                  )),
            );
          },
        ));
  }
}
