import 'package:flutter/material.dart';
import '../functions/SharedPreferences.dart';


class FoodModel with ChangeNotifier{
    Map food_names = {}; // key : foodname  value : map
    Map food_types = {};
    Map food_locations = {};
    String username = '';
    
    FoodModel(){
        GetUser();
    }
    //添加新食物
    addFood(Map fooddata){
        var foodname = fooddata['foodname'];
        print('in foods fooddata');
        print(fooddata);
        if(food_names.containsKey(foodname) == false){  //如果新添加的食物以前不存在
            var price = fooddata['price'];
            var times = fooddata.containsKey('times')?fooddata['times']:0;
            var type = fooddata['type'];
            var location = fooddata['location'];
            
            if(food_types.containsKey(type)){//如果添加的食物类型之前存在过
                food_types[type].add(foodname);
            }else{
                food_types[type] = [];
                food_types[type].add(foodname);
            }

            if(food_locations.containsKey(location)){//如果添加的食物地点之前存在过
                food_locations[location].add(foodname);
            }else{
                food_types[location] = [location];
            }
            
            
            this.food_names[foodname] = {
                'price':price,
                'type':type,
                'location':location,
                'times':times
            };
            notifyListeners();
        }else{
            return false;
        }
    }
    
    bool CheckFoodName (String foodname){
        return food_names.containsKey(foodname);
    }
    
    //获取现在登录的用户名
    GetUser() async {
        var temp = await localData('readuser');
        username = temp['nameJZM'];
    }
}