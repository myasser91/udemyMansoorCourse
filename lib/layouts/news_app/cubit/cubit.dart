import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/news_app/cubit/states.dart';
// ignore: unused_import
import 'package:messenger/main.dart';

import 'package:messenger/models/NewsModels/topheadlineModel.dart';

import 'package:messenger/modules/newsmodules/Bussiness/Bussiness_screen.dart';
import 'package:messenger/modules/newsmodules/science/science_screen.dart';
import 'package:messenger/modules/newsmodules/sport/sport_screen.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';
import 'package:messenger/shared/shared.network/remote/dio_Helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<BottomNavigationBarItem> bottomitems = [
    BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'Bussiness'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
  ];
  List<Widget> screens = [
    BussinessScreen(),
    ScienceScreen(),
    SportScreen(),
  ];
  List<dynamic> business = [];

  List<dynamic> search = [];
  List<dynamic> sport = [];
  List<dynamic> science = [];
  void changenavbar(int index) {
    currentindex = index;
    if (index == 2) getSports();
    if (index == 1) getScience();
    emit(NewsBottomState());
  }
Headlines? searchlist;
  void getsearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apikey': 'f8022dac10334ba6b032b67fa50f2ea3',
      },
    ).then((value) {
      
      searchlist = Headlines.fromJson(value.data);
    
      emit(NewsGetSearchSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  Headlines? news;
  void getBusiness() {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apikey': 'f8022dac10334ba6b032b67fa50f2ea3',
      },
    ).then((value) {
      news = Headlines.fromJson(value.data);

      emit(NewsGetBusinessSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  Headlines? newssport;
  void getSports() {
    emit(SportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': 'f8022dac10334ba6b032b67fa50f2ea3',
      },
    ).then((value) {
      newssport = Headlines.fromJson(value.data);
      emit(NewsGetSportsSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  var isDark = false;
  void darkmodetoggle({bool? fromshared}) async {
    if (fromshared != null)
      isDark = fromshared;
    else
      isDark = !isDark;
    CashHelper.savedata(key: 'isDark', value: isDark).then((value) {
      emit(Darkmodetogglestate());
      print(isDark);
    });
  }

  Headlines? newsSience;
  void getScience() {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apikey': 'f8022dac10334ba6b032b67fa50f2ea3',
      },
    ).then((value) {
      newsSience = Headlines.fromJson(value.data);
      emit(NewsGetScienceSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }
}
