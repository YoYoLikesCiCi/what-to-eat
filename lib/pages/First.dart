
import 'package:flutter/material.dart';
import '../functions/ProviderChat.dart';
import 'package:provider/provider.dart';
import '../pages/Second.dart';

class FirstScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        final _counter = Provider.of<CounterModel>(context);
        final textSize = Provider.of<int>(context).toDouble();
        final _chatmodel = Provider.of<ChatModel>(context);
        return Column(
            children: <Widget>[
                Center(
                    child: Text(
                        'Value: ${_counter.value}',
                        style: TextStyle(fontSize: textSize),
                    ),
                ),
                Center(
                  child: Text(
                      '??:${_chatmodel.status.toString()}'
                  ),
                ),
//                FloatingActionButton(
//                    onPressed: () => Navigator.of(context)
//                        .push(MaterialPageRoute(builder: (context) => SecondPage())),
//                    child: Icon(Icons.navigate_next),
//                ),
            ],

        );
    }
}