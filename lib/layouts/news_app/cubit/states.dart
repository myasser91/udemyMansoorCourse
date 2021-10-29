abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomState extends NewsStates {}

class NewsGetBusinessSucsessState extends NewsStates {}

class NewsGetSportsSucsessState extends NewsStates {}

class NewsGetScienceSucsessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  NewsGetBusinessErrorState(String string);
}

class NewsGetSportsErrorState extends NewsStates {
  NewsGetSportsErrorState(String string);
}

class NewsGetScienceErrorState extends NewsStates {
  NewsGetScienceErrorState(String string);
}

class NewsLoadingState extends NewsStates {}

class SportsLoadingState extends NewsStates {}

class Darkmodetogglestate extends NewsStates {}
class NewsGetSearchSucsessState extends NewsStates {}
class NewsGetSearchLoadingState extends NewsStates {}
class NewsGetSearchErrorState extends NewsStates {
  NewsGetSearchErrorState(String string);
}
