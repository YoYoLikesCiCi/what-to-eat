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
            Text(Provider.of<CounterModel>(context,listen: true).value.toString()),
//            Consumer<ChatModel>(
//              builder: (context, ChatModel chater,_){
//                return Column(
//                  children: <Widget>[
//                    Text(chater.state.toString()),
//                    RaisedButton(
//                      child: Icon(Icons.refresh),
//                      onPressed: (){
//                        chater.changeState();
//                      },
//                    )
//                  ],
//                );
//              }
//
//            ),
            RaisedButton(
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SecondPage()));
              },
            ),
            
          ],
        ),
      ),
    );
  }
}

