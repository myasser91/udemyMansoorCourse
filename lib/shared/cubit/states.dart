abstract class Appstates {}

class Appinitialstate extends Appstates {}

class AppChangeBottomNavBarState extends Appstates {}

class Appcreatedatabasestate extends Appstates {}

class Appgetdatabasestate extends Appstates {}

class AppgetdatabaseLoadingstate extends Appstates {}

class Appinsertdatabasestate extends Appstates {}

class AppChangeBottomSheetBarState extends Appstates {}

class Appupdatedatabasestate extends Appstates {}

class Appdeletedatabasestate extends Appstates {}

class Darkmodetogglestate extends Appstates {}

class NewsGetSearchSucsessState extends Appstates {}
class NewsGetSearchLoadingState extends Appstates {}
class NewsGetSearchErrorState extends Appstates {
  NewsGetSearchErrorState(String string);
}