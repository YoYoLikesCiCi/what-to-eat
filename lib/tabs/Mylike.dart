import 'package:flutter/material.dart';
import 'package:what_to_eat/functions/Functions.dart';
import 'package:image/image.dart';
import 'dart:io';

class MyLikePage extends StatefulWidget {
  @override
  _MyLikePageState createState() => _MyLikePageState();
}

class _MyLikePageState extends State<MyLikePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('press me Test'),
            onPressed: (){
              print('kk');
            },
          )
        ],
      ),
    );
  }
}
