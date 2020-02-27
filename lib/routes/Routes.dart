

import 'package:flutter/material.dart';
import 'package:what_to_eat/tabs/Tabs.dart';
import '../pages/Register.dart';
import '../pages/Login.dart';
import '../pages/Splash.dart';


final routes= {
    '/': (context) => Tabs(),
    '/register':(context) => RegisterPage(),
    '/signpage':(context) => LoginPage(),
    '/splash':(context) => SplashPage(),
};


//固定写法
var onGenerateRoute = (RouteSettings settings) {
    
    final String name = settings.name;
    final Function pageContentBuilder = routes[name];
    
    // If you push the PassArguments route
    if (pageContentBuilder != null){
        if (settings.arguments != null) {
            // Cast the arguments to the correct type: ScreenArguments.
            final Route route = MaterialPageRoute(
                builder: (context) =>
                    pageContentBuilder(context, arguments:settings.arguments)
            );
            return route;
        }
        else{
            final Route route = MaterialPageRoute(
                builder: (context)=> pageContentBuilder(context)
            );
            return route;
        }
    }
};