import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/Routes.dart';
import 'provider_setup.dart';

void main(){
    runApp(
        MultiProvider(
            providers: providers,
            child: MyApp(),
        )
    );
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

