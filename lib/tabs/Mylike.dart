import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_to_eat/models/Foods.dart';
import 'package:what_to_eat/pages/AddFood.dart';
import 'package:what_to_eat/functions/Functions.dart';
import 'package:what_to_eat/pages/EditFood.dart';
import '../models/ProviderChat.dart';
import '../functions/SharedPreferences.dart';

class MyLikePage extends StatelessWidget {
  String type_now = '';

  var _tapPosition;
  
 
  var username2;
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodModel>(builder: (context, FoodModel foodmodel, _) {
      
      foodmodel.GetUser();
      username2 = foodmodel.ReturnUserName();
//      username2 = username;
      InitFood(foodmodel);
      return GestureDetector(
        onDoubleTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddFoodPage(),));
        },
        child: Column(
          children: <Widget>[
//            RaisedButton(
//              child: Icon(Icons.add),
//              onPressed: () {
//
//              }
//            ),
//            RaisedButton(
//              child: Icon(Icons.play_arrow),
//              onPressed: () async {
//                var getFoodResult =
//                    await GetFoodData('getfood', {'name': '孙起'});
//                if (getFoodResult[0] != 0) {
////                  print(getFoodResult);
//                  getFoodResult.forEach((v) {
//                    foodmodel.addFood(PackageFood(v));
//                  });
//                }
//              },
//            ),
            Expanded(
              child: new ListView.separated(
                itemBuilder: _buildExpansionItem,
                separatorBuilder: (content, index) {
                  return new Divider(color: Colors.white,height:1,);
                },
                itemCount: foodmodel.typeslenth,
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildExpansionItem(BuildContext context, int index) {
    return Consumer<FoodModel>(builder: (context, FoodModel foodmodel, _) {
      List foodtypes = foodmodel.food_types.keys.toList();
      type_now = foodtypes[index];
      return Card(
        child: ExpansionTile(
          title: Text(foodtypes[index]),
          leading: Icon(Icons.filter_2, color: Colors.lightGreen),
          backgroundColor: Colors.white,
          initiallyExpanded: true,
          // 是否默认展开
          children: _buildListItemsss(foodmodel.food_types[type_now]),
//          children: <Widget>[
//            _buildListItem2(context,index),
//            _buildListItem(context,index),
////              ListView.builder(
////                  itemBuilder: _buildListItem,
////                  itemExtent: 30,
////                  itemCount: foodmodel.food_types[type_now].length,
////              )
//            ]
        ),
      );
    });
  }

  List<Widget> _buildListItemsss(List typenames) {
    List<Widget> foods = [];
//    print('in buildlist itemsssss');
//    print(typenames);
    typenames.forEach((v) {
      var aa = _buildListItem(v);
      foods.add(aa);
    });
    return foods;
    // ignore: missing_return
  }

  Widget _buildListItem(String foodname) {
    // ignore: missing_return
    return Consumer<FoodModel>(
      builder: (context, FoodModel foodmodel, _) {
        var fooddata = foodmodel.GetFoodDetails(foodname);
//        print(foodname);
//        print('in items');
//        print(fooddata);
        return GestureDetector(
          child: ListTile(
              trailing: Text("¥"+fooddata['price'].toString()),
              leading: Text(fooddata['times'].toString()),
              title: Text(foodname),
              subtitle: Text(fooddata['location'])),
          onTapDown: _storePosition,
          onLongPress: () {
            foodmodel.ChangeMayGoneFood(foodname); //长按时就把它加入可能会变动的，方便后续删除或者编辑
            _showMenu(context);
          },
        );
      },
    );
    {}
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  alertDialog(BuildContext context, String title, String Message) async {
    var result = await showDialog(
        context: context,
        // ignore: missing_return
        builder: (context) {
          return Consumer<FoodModel>(builder: (context, FoodModel foodmodel, _) {
            return AlertDialog(
                title: Text(title),
                content: Text(Message),
                actions: <Widget>[
                  FlatButton(
                    child: Text('取消'),
                    onPressed: () {
                      Navigator.pop(context, 'cancel');
                    },
                  ),
                  FlatButton(
                    child: Text('确定'),
                    onPressed: () {
                      print('确定了');
                      Navigator.pop(context, 'yes');
                      Map tempmap = {};
                      tempmap['username'] = foodmodel.username;
                      tempmap['foodname'] = foodmodel.mayGonefood;
                      DeleteFoodServer(tempmap);
                      foodmodel.DeleteFoodLocal();
                    },
                  )
                ]);
          });
        });
  }

  
  _showMenu(BuildContext context) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
        _tapPosition & Size(40, 40), // smaller rect, the touch area
        Offset.zero & overlay.size // Bigger rect, the entire screen
        );
    var pop = _popMenu();
    showMenu<String>(
      context: context,
      items: pop.itemBuilder(context),
      position: position,
    ).then<void>((String newValue) {
      print(newValue);
      if (newValue == 'edit') {
        Navigator.push(context, MaterialPageRoute(
              builder: (context) => EditFoodPage(),
            ));
      
      } else if (newValue == 'delete') {
        alertDialog(context, '确认删除？', '确定要把这个食物从你的美食菜单里删除吗？');
      }
//      if (newValue == null) {
//        if (pop.onCanceled != null) pop.onCanceled();
//        return null;
//      }
//      print(pop.onSelected);
//      if (pop.onSelected != null) pop.onSelected(newValue);
    });

    
   
  }

  PopupMenuButton _popMenu() {
    return PopupMenuButton<String>(
      itemBuilder: (context) => _getPopupMenu(context),
//      onSelected: (String value) {
//          print(value.runtimeType.toString());
//          print('onSelected');
//        return '222';
//      },
//      onCanceled: () {
//        print('onCanceled');
//        return 'null';
//      },
//      child: RaisedButton(onPressed: (){},child: Text('选择'),),
//      icon: Icon(Icons.shopping_basket),
    );
  }

  _getPopupMenu(BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: 'edit',
        child: Text('编辑'),
      ),
      PopupMenuItem<String>(
        value: 'delete',
        child: Text('删除'),
      ),
    ];
  }

  void InitFood(FoodModel foodmodel)async{
    if(username2 != 'empty'){
      print('in splash page');
      
      var getFoodResult = await GetFoodData('getfood', {'name':username2});
//      print('getfoodresult');
//      print(getFoodResult);
//                    if(getFoodResult.length >  0){
//      print(getFoodResult);
      getFoodResult.forEach((v){
        foodmodel.addFood(PackageFood(v));
      });
//                    }
    
    }
  }
}

