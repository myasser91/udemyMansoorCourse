import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/news_app/cubit/states.dart';
// ignore: unused_import
import 'package:messenger/main.dart';
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

  void getsearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apikey': '5f2798d699894a6db8f39336271e068a',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  void getBusiness() {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apikey': '5f2798d699894a6db8f39336271e068a',
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(SportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': '5f2798d699894a6db8f39336271e068a',
      },
    ).then((value) {
      sport = value.data['articles'];
      print(sport[0]['title']);
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

  void getScience() {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apikey': '5f2798d699894a6db8f39336271e068a',
      },
    ).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }
}
