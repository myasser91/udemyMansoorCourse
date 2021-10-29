// ignore_for_file: unused_import

import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/SearchCubit/searchState.dart';
import 'package:messenger/models/ShopModels/searchModel.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/shared.network/endPoints.dart';
import 'package:messenger/shared/shared.network/remote/dio_Helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());
    
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      
    }).then((value) {emit(SearchSuccessState());}).catchError((error) {
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}
