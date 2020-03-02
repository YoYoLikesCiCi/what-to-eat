import 'package:flutter/material.dart';

class KitchenPage extends StatefulWidget {
  @override
  _KitchenPageState createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('press me Test'),
            onPressed: (){
              print('test');
            },
          )
        ],
      ),
    );
  }
}
