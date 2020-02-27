import 'package:flutter/material.dart';
import 'package:what_to_eat/functions/Functions.dart';
class MyLikePage extends StatefulWidget {
  @override
  _MyLikePageState createState() => _MyLikePageState();
}

class _MyLikePageState extends State<MyLikePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("前往登陆界面"),
            onPressed: (){
              Navigator.pushNamed(context, '/register');
            },
          ),
          RaisedButton(
            child: Text("logintest"),
            onPressed: ()async{
//              var aa = await localData('readuser');
//              print (aa);
              Map aa = {
                'name' : '孙起',
                'password' : '123456'
              };
              var bb = await Login(aa);
              print(bb.toString());
            },
          ),
          RaisedButton(
            child: Text("前往登陆界面"),
            onPressed: (){
              Navigator.pushNamed(context, '/signpage');
            },
          ),
          RaisedButton(
            child: Text("测试"),
            onPressed: ()async{
              print(await localData('readuser'));
            },
          ),
          RaisedButton(
            child: Text("remove"),
            onPressed: ()async{
              print(await localData('clear'));
      
            },
          ),

        ],
      )
    );
  }
}
