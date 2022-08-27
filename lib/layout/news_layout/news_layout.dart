import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_layout/cubit/cubit.dart';
import 'package:news/modules/search/search_screen.dart';
import 'package:news/shared/component/component.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: ( context, state) {},
      builder: ( context,  state) {
        var cubit = NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title:const Text(
                'News'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search_outlined,)
              ),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined,)
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottumItems,
            onTap: (index){
              cubit.changeButtonNavBar(index);
            },
          ),
        );
      },

    );
  }
}
