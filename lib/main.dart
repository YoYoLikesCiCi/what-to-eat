import 'package:flutter/material.dart';
import 'routes/Routes.dart';
import 'functions/Functions.dart';
void main(){
    runApp(MyApp());
}
//自定义组件
class MyApp extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
// TODO: implement build
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/splash',
            theme: ThemeData(primarySwatch: Colors.blue),
            onGenerateRoute: onGenerateRoute,
        );
    }
}

