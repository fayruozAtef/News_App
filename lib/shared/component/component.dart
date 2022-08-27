import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/web_view/web_view_screen.dart';

Widget defaultTextFormField({
  required TextEditingController controler,
  required TextInputType input,
  bool isPassword=false,
  Function(String)? onSubmitted,
  Function(String)? onChange,
  required String?Function(String?) validate,
  required String lable,
  required IconData icon,
  IconData? sufixIcon,
  VoidCallback? suffixWork,
})=>TextFormField(
  controller: controler,
  keyboardType: input,
  obscureText: isPassword,
  onFieldSubmitted: onSubmitted,
  onChanged: onChange,
  validator: validate,
  decoration: InputDecoration(
    labelText: lable,
    prefixIcon: Icon(
      icon,
    ),
    suffixIcon: IconButton(
      icon: Icon(
        sufixIcon,
      ),
      onPressed: suffixWork,
    ),
    border: OutlineInputBorder(),
  ),
);

Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal:10.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4.0, // shadow direction: bottom right
          )
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.all(17.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage'] ?? 'https://img.freepik.com/free-vector/red-prohibited-sign_1284-42862.jpg?t=st=1655862253~exp=1655862853~hmac=b8fb517658a1f3a1f0ab4c849258262ae351475b5aa1c71855ea6c8794e6024f&w=740'}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20.0,),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1
                    ),
                  ),
                  Text(
                    '${article['publishedAt'] }',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);

Widget articleBuilder(list,context,{ isSearch = false })=>ConditionalBuilder(
  condition: list.length>0,
  builder: (BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildArticleItem(list[index],context),
      separatorBuilder: (context , index)=>const SizedBox(height: 5.0,),
      itemCount: list.length,
    );
  },
  fallback: (BuildContext context) {
    return Center(child: isSearch? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Container(
           width: 250,
           height: 250,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20.0),

           ),
           child: Image(
             image: const NetworkImage('https://img.freepik.com/free-vector/magnifying-glass-with-file-searching_52683-22967.jpg?t=st=1655910754~exp=1655911354~hmac=1ad14966678f3e764d3e54b402b997cd6948b22754692401881502c9c56a788c&w=740'),
             fit: BoxFit.cover,
           color: Colors.grey.withOpacity(0.2),
           colorBlendMode:  BlendMode.modulate,),
         ),
      ],
    ) : CircularProgressIndicator());
  },
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);