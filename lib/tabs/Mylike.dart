import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_to_eat/models/Foods.dart';
import 'package:what_to_eat/pages/AddFood.dart';
import 'package:what_to_eat/functions/Functions.dart';
import '../models/ProviderChat.dart';
import '../functions/SharedPreferences.dart';
class MyLikePage extends StatelessWidget {

  
  
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodModel>(
        builder: (context, FoodModel foodmodel,_){
        return Container(
          child: Column(
    
            children: <Widget>[
              RaisedButton(
                child: Icon(Icons.add),
                onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(
                    builder: (context) => AddFoodPage(),
                  )
                  );
                },
              ),
                RaisedButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: ()async {
                        var getFoodResult = await GetFoodData('getfood', {'name':'孙起'});
                        if(getFoodResult[0] != 0){
                            print(getFoodResult);
                            getFoodResult.forEach((v){
                               foodmodel.addFood(PackageFood(v));
                            });
                        }
                    },
                ),
              Expanded(
                child:new ListView.separated(
                    itemBuilder: _buildExpansionItem,
                    separatorBuilder: (content, index) {
                      return new Divider();},
                    itemCount: 3
                ) ,
              )
            ],
          ),
        );
  });
  }
  
  Widget _buildExpansionItem (BuildContext context,int index){
      return ExpansionTile(
          title: Text('展开闭合demo'),
          leading: Icon(Icons.ac_unit, color: Colors.green),
          backgroundColor: Colors.white,
          initiallyExpanded: true, // 是否默认展开
          children: <Widget>[
            _buildListItem(context),
            _buildListItem(context),
            
          ]
      );
  }
  
  Widget _buildListItem(BuildContext context){
      return GestureDetector(
        child: ListTile(
            title:Text('北京daf远扬'),
            subtitle:Text('重庆优帆天成')
        ),
      );
  }
  
}

