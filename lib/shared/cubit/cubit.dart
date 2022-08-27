import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/network/local/cach_helper.dart';
import 'package:news/shared/cubit/states.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit(): super(AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool isDark=false;

  void changeMode({bool? sharedMode}){
    if(sharedMode!= null) {
      isDark = sharedMode;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CashHelper.putBoolData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }

  }

}