import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_to_eat/functions/Functions.dart';
import 'package:what_to_eat/functions/InputFormats.dart';
import 'package:what_to_eat/models/Foods.dart';

class AddFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    
    
    return Consumer<FoodModel>(
        builder: (context, FoodModel foodmodel,_){
    
            TextEditingController _foodnameController = TextEditingController();
            TextEditingController _priceController = TextEditingController();
            TextEditingController _typeController = TextEditingController();
            TextEditingController _locationController = TextEditingController();
            
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
                body: SingleChildScrollView(
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
                                        labelText: '啥菜呀',
                                        hintText: '请输入新发现的美食',
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
                                        labelText: '几个钱呀',
                                        hintText: '请输入价格',
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
                                        labelText: '什么类型呀？早点还是外卖呀',
                                        hintText: '请输入你给这项食物的分类',
                                        
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
                                        labelText: '啥地儿吃啊',
                                        hintText: '请输入购买地点',
                                        prefixIcon: Icon(Icons.location_on),
                                    ),
                                ),
                                SizedBox(
                                    height: 20,
                                ),
                                RaisedButton(
                                    child: Text('提交到美食清单'),
                                    onPressed: ()async{
                                        if (foodmodel.CheckFoodName(_foodnameController.text) == false){
                                            //先提交到服务器，成功后添加到本地内存
                                            var tempmap = {
                                                'name':foodmodel.username,
                                                'foodname':_foodnameController.text,
                                                'price':_priceController.text,
                                                'type':_typeController.text,
                                                'location':_locationController.text
                                            };
                                            var status = await FoodDataPost('addfood', tempmap);
                                            if (status == 0) {
                                                alertDialog('网络错误', '服务器发生了未知的错误，请稍后尝试');
                                            } else if (status == 1) {
                                                foodmodel.addFood(tempmap);
                                                Navigator.pop(context);
        
                                            }
                                        }else{
                                            alertDialog('这个食物已经存在', '请更换食物名');
                                        }
    
                                        
                                    },
                                )
                            ],
                        ),
                    ),
                ),

            );
    
    });
  }
}
