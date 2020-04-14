import 'package:flutter/material.dart';
import 'package:what_to_eat/functions/Functions.dart';
import '../functions/SharedPreferences.dart';
import '../functions/RandomFood.dart';

class FoodModel with ChangeNotifier{
    Map food_names = {}; // key : foodname  value : map
    Map food_types = {};
//    Map food_types_in = {};
    
    Map food_locations = {};
//    Map food_locations_in = {};
    var mayGonefood = "";
    String username = 'empty';
    int foodlenth = 0;
    int typeslenth = 0;
    int locationslenth = 0;
    
    FoodModel(){
        GetUser();
    }
    //添加新食物
    addFood(Map fooddata){
        
        var foodname = fooddata['foodname'];
//        print('in foods fooddata');
//        print(fooddata);
        if(food_names.containsKey(foodname) == false){  //如果新添加的食物以前不存在
            var price = fooddata['price'];
//            print('inaddfood price ');
//            print('price');
            
            var times = fooddata.containsKey('times')?fooddata['times']:0;
            var type = fooddata['type'];
            var location = fooddata['location'];
            
            if(food_types.containsKey(type)){//如果添加的食物类型之前存在过
                food_types[type].add(foodname);
            }else{
                food_types[type] = [];
                food_types[type].add(foodname);
                typeslenth++;
            }

            if(food_locations.containsKey(location)){//如果添加的食物地点之前存在过
                food_locations[location].add(foodname);
            }else{
                food_locations[location] = [location];
                locationslenth++;
            }
            
            
            this.food_names[foodname] = {
                'price':price,
                'type':type,
                'location':location,
                'times':times
            };
            foodlenth++;
            notifyListeners();
        }else{
            return false;
        }
    }
    
    RandomIt(){
      var result = EatIt(food_names);
      print(result);
      return result;
    }
    
    DoIt(String result)async{
        if(await PlusTimesServer({'foodname':result,'username':username}) == 1){
            food_names[result]['times']++;
        }
        notifyListeners();
    }
    
    bool CheckFoodName (String foodname){
        return food_names.containsKey(foodname);
    }
    
    GetFoodDetails(String foodname){
        return food_names[foodname];
    }
    //获取现在登录的用户名
    GetUser() async {
        var temp = await localData('readuser');
        if(temp != 'empty'){
            username = temp['nameJZM'];
        }
       
//        notifyListeners();
    }
    ChangeMayGoneFood(String foodname){
        mayGonefood = foodname;
    }
    
    DeleteFoodLocal(){
        Map data = food_names[mayGonefood];
        var location = data['location'];
        var type = data['type'];
//        print(type);
//        print(location);
//        print(food_types);
//        print(food_locations[location].toString());
//        print(food_types[type].toString());
        food_locations[location].remove(mayGonefood);
//        print(food_locations[location]);
//        print(food_locations[location].runtimeType.toString());
        if (food_locations[location].length == 0){
            food_locations.remove(location);
            locationslenth--;
        }
        food_types[type].remove(mayGonefood);
        if (food_types[type].length == 0){
            food_types.remove(type);
            typeslenth--;
        }
        foodlenth--;
        food_names.remove(mayGonefood);
        notifyListeners();
    }
    
    ClearAll(){
        food_names = {}; // key : foodname  value : map
        food_types = {};
//    Map food_types_in = {};
    
        food_locations = {};
//    Map food_locations_in = {};
        mayGonefood = "";
        username = '';
        foodlenth = 0;
        typeslenth = 0;
        locationslenth = 0;
        
        notifyListeners();
    }
    
    ReturnUserName(){
//        print ('return username');
        return username;
    }
}