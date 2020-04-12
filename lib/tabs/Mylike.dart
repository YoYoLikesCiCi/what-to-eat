import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../functions/ProviderChat.dart';
import '../pages/First.dart';

import '../pages/Second.dart';
class MyLikePage extends StatelessWidget {

  
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterModel>(
      create: (_) => CounterModel(),
      child: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Icon(Icons.add),
              onPressed: (){
              },
            ),
            
          ],
        ),
      ),
    );
  }
}

