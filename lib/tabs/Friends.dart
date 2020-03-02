import 'package:flutter/material.dart';
import '../functions/Functions.dart';
import '../functions/SharedPreferences.dart';
class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
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
