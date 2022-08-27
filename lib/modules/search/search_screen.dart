import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_layout/cubit/cubit.dart';
import 'package:news/layout/news_layout/cubit/states.dart';

import '../../shared/component/component.dart';

class SearchScreen extends StatelessWidget {

  var searchControler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: ( context, state) {

      },
      builder: (context, state){
        var list =NewsCubit.get(context).search;
        return  Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                NewsCubit.get(context).search=[];
              },
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                    input: TextInputType.text,
                    validate: (String? value) {
                      if(value!.isEmpty )
                        return 'enter something to search for';
                      return null;
                    },
                    controler: searchControler,
                    icon: Icons.search,
                    lable: 'Search',
                    onChange: (value){
                      NewsCubit.get(context).getSearch(value);
                    }

                ),
              ),
              Expanded(
                  child: articleBuilder(list, context,isSearch: true)
              ),
            ],
          ),
        );
      },
    );
  }
}
