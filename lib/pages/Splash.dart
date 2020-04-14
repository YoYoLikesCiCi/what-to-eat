import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_to_eat/functions/Functions.dart';
import 'package:what_to_eat/models/Foods.dart';
import 'dart:async';
import '../functions/SharedPreferences.dart';

class SplashPage extends StatefulWidget{
    
    SplashPage({Key key}):super(key:key);
    @override
    _SplashPage createState()=> new _SplashPage();
    
}

class _SplashPage extends State<SplashPage>{
    
    bool isStartHomePage = false;
    var username2;
    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return Consumer<FoodModel>(
            // ignore: missing_return
            builder: (context,FoodModel foodmodel,_){

                return new GestureDetector(
                    onTap: goToHomePage,//设置页面点击事件
                    child: Image.asset("assets/SplashImage.png",fit: BoxFit.cover,),//此处fit: BoxFit.cover用于拉伸图片,使图片铺满全屏
                );
            });
        
    }
    
    //页面初始化状态的方法
    @override
    Future<void> initState() {
        super.initState();
        //开启倒计时
        countDown();
    }
    
    void countDown(){
        //设置倒计时1秒后执行跳转方法
        
        var duration = new Duration(seconds: 1);
        new Future.delayed(duration, goToHomePage);
        
    }
    
    void goToHomePage()async{
        username2 = await localData('readuser');
        if(username2 != 'empty'){
            Navigator.pushReplacementNamed(context, '/');
        }else{
            Navigator.of(context).pushNamedAndRemoveUntil('/signpage', (Route<dynamic> route) => false);
        }
        
        
    }
    
   
}
