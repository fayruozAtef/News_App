abstract class NewsStates{}

class NewsIntialSate extends NewsStates{}

class NewsButtonNavSate extends NewsStates{}

class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSucessState extends  NewsStates{}

class NewsGetBusinessErrorState extends  NewsStates{
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsSucessState extends  NewsStates{}

class NewsGetSportsErrorState extends  NewsStates{
  final String error;
  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceSucessState extends  NewsStates{}

class NewsGetScienceErrorState extends  NewsStates{
  final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchSucessState extends  NewsStates{}

class NewsGetSearchErrorState extends  NewsStates{
  final String error;
  NewsGetSearchErrorState(this.error);
}