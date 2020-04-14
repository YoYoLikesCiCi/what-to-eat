import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_to_eat/functions/Functions.dart';
import 'package:what_to_eat/functions/InputFormats.dart';
import 'package:what_to_eat/models/Foods.dart';

class EditFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodModel>(builder: (context, FoodModel foodmodel, _) {
      TextEditingController _foodnameController = TextEditingController();
      TextEditingController _priceController = TextEditingController();
      TextEditingController _typeController = TextEditingController();
      TextEditingController _locationController = TextEditingController();

      var mayfood = foodmodel.mayGonefood;
      Map tim = foodmodel.food_names[mayfood] ?? {};
      print('tim');
      print(tim.runtimeType.toString());
      final times = tim['times']??0;
      final price = tim['price']??'11';
      final type = tim['type']??'22';
      final location = tim['location']??'21';
      print('tim end');
      
      _foodnameController.text = mayfood;
      _priceController.text = price;
      _typeController.text = type;
      _locationController.text = location;

      alertDialog(String title, String Message) async {
        var result = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(title),
                content: Text(Message),
                actions: <Widget>[
                  FlatButton(
                    child: Text('cancel'),
                    onPressed: () {
                      Navigator.pop(context, 'cancel');
                    },
                  ),
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.pop(context, 'yes');
                    },
                  )
                ],
              );
            });
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('添加食物'),
        ),
        body: GestureDetector(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                    maxLength: 12,
                  autofocus: true,
                  controller: _foodnameController,
                  decoration: InputDecoration(
                    labelText: '改菜名？',
//                                      hintText: '请输入新发现的美食',
                    prefixIcon: Icon(Icons.fastfood),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    maxLength: 8,
                  autofocus: true,
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [TestFormat()],
                  decoration: InputDecoration(
                    labelText: '涨价了？',
//                                      hintText: '请输入价格',
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    maxLength: 10,
                  autofocus: true,
                  controller: _typeController,
                  decoration: InputDecoration(
                    labelText: '早餐中午吃？',
//                                      hintText: '请输入你给这项食物的分类',
                    prefixIcon: Icon(Icons.label_outline),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    maxLength: 20,
                  autofocus: true,
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: '店家换铺了？',
//                                      hintText: '请输入购买地点',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    child: Text('确认修改'),
                    onPressed: () async {
                        Navigator.pop(context);
                        if (_foodnameController.text == mayfood) {
                            //现删除网络再删除本地
                            if (await DeleteFoodServer({
                                'foodname': _foodnameController.text,
                                'username': foodmodel.username
                            }) == 1) {
                                foodmodel.DeleteFoodLocal();
                                //先添加网络，再添加本地
                                var tempmap = {
                                    'name': foodmodel.username,
                                    'foodname': _foodnameController.text,
                                    'price': _priceController.text,
                                    'type': _typeController.text,
                                    'location': _locationController.text,
                                    'times': times
                                };
                                var status = await FoodDataPost(
                                    'addfood', tempmap);
                                if (status == 0) {
                                    alertDialog('网络错误', '服务器发生了未知的错误，请稍后尝试');
                                } else if (status == 1) {
                                    foodmodel.addFood(tempmap);
                                    
                                    
                                    
                                }
                            }
                            //当没有修改菜名时执行以下操作
                        } else {
                            if (foodmodel.CheckFoodName(_foodnameController
                                .text) == false) {
                                if (await DeleteFoodServer({
                                    'foodname': _foodnameController.text,
                                    'username': foodmodel.username
                                }) == 1) {
                                    foodmodel.DeleteFoodLocal();
                                    //先添加网络，再添加本地
                                    var tempmap = {
                                        'name': foodmodel.username,
                                        'foodname': _foodnameController.text,
                                        'price': _priceController.text,
                                        'type': _typeController.text,
                                        'location': _locationController.text,
                                        'times': times
                                    };
                                    var status = await FoodDataPost(
                                        'addfood', tempmap);
                                    if (status == 0) {
                                        alertDialog(
                                            '网络错误', '服务器发生了未知的错误，请稍后尝试');
                                    } else if (status == 1) {
                                        foodmodel.addFood(tempmap);
//                                        Navigator.pop(context);
                                    }
                                }
                            }
                        }
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
