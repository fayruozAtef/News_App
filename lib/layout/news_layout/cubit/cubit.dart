import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_layout/cubit/states.dart';
import '../../../modules/business/business_screen.dart';
import '../../../modules/science/science_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{

  NewsCubit():super(NewsIntialSate());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottumItems=[
    const BottomNavigationBarItem(
      icon:  Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon:  Icon(
        Icons.sports_outlined,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon:  Icon(
        Icons.science_outlined,
      ),
      label: 'Science',
    ),
    /*const BottomNavigationBarItem(
      icon:  Icon(
        Icons.settings,
      ),
      label: 'Setting',
    ),*/
  ];

  List<Widget> screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> buisness=[];
  List<dynamic> sports=[];
  List<dynamic> science=[];
  List<dynamic> search=[];

  void changeButtonNavBar(int index){
    currentIndex=index;
    if(index==1) getSports();
    if(index==2) getScience();
    emit(NewsButtonNavSate());
  }

  void getBusiness(){
    if(buisness.length==0) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      }).then((value) {
        buisness = value.data['articles'];
        emit(NewsGetBusinessSucessState());
      }).catchError((onError) {
        print("There is an error" + onError.toString());
        if(onError is DioError){
          print('DioError --> '+onError.response!.data['message']);
        }
        emit(NewsGetBusinessErrorState(onError.toString()));
      });
    }else{
      emit(NewsGetBusinessSucessState());
    }
  }

  void getSports(){
    if(sports.length==0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSucessState());
      }).catchError((onError) {
        print("There is an error" + onError.toString());
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    }else{
      emit(NewsGetSportsSucessState());
    }
  }

  void getScience(){
    if(science.length==0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSucessState());
      }).catchError((onError) {
        print("There is an error" + onError.toString());
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    }else{
      emit(NewsGetScienceSucessState());
    }
  }

  void getSearch(String value){
    search=[];

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSucessState());
    }).catchError((onError) {
      print("There is an error" + onError.toString());
      emit(NewsGetSearchErrorState(onError.toString()));
    });

  }
}
