import 'package:flutter/material.dart';
import '../functions/Functions.dart';
import 'dart:async';
import '../routes/Routes.dart';

class SplashPage extends StatefulWidget{
    
    SplashPage({Key key}):super(key:key);
    @override
    _SplashPage createState()=> new _SplashPage();
    
}

class _SplashPage extends State<SplashPage>{
    
    bool isStartHomePage = false;
    
    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return new GestureDetector(
            onTap: goToHomePage,//设置页面点击事件
            child: Image.asset("assets/SplashImage.png",fit: BoxFit.cover,),//此处fit: BoxFit.cover用于拉伸图片,使图片铺满全屏
        );
    }
    
    //页面初始化状态的方法
    @override
    void initState() {
        super.initState();
        //开启倒计时
        countDown();
    }
    
    void countDown() {
        //设置倒计时三秒后执行跳转方法
        var duration = new Duration(seconds: 3);
        new Future.delayed(duration, goToHomePage);
        
    }
    
    void goToHomePage()async{
        
        Navigator.pushReplacementNamed(context, (await localData('readuser')=='empty')?'/signpage':'/');
        
    }
}
