import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<int> UserDataPost(String route,Map data ) async {
    Response responsE;
    Dio dio = Dio();
    print(data);
    responsE = await dio.post('http://47.93.25.50/register',data:data);
    print(responsE.statusCode);
    print(responsE.data.toString());
    if(responsE.statusCode == 200){
        if(responsE.data.toString() == 'success'){
            print("response:"+responsE.data.toString());
            return 1;
        }
        else if(responsE.data.toString() == 'existuser'){
            print('user error');
            return 2;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
    
    
}

Future<int> Login(Map data)async{
    Response responsE;
    Dio dio = Dio();
    print(data);
    //0都为网络错误
    //1都为成功
    responsE = await dio.post('http://47.93.25.50/login',data:data);
    print(responsE.statusCode);
    if(responsE.statusCode == 200){
        print(responsE.data.toString());
        if(responsE.data.toString() == 'success'){
            return 1;
        }
        else if(responsE.data.toString() == 'errorpasswd'){
            return 2;
        }else if (responsE.data.toString() == 'unknownuser'){
            return 3;
        }
    }else{
        return 0;
    }
}




//本地数据读写
localData(String operation, {Map data} ) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(operation == 'saveuser'){  //写入数据
        data.forEach((key,value){
            prefs.setString( key,value);
        });
        
    }else if(operation == 'savefood'){  //保存食物数据
        data.forEach((foodname,value){
            prefs.setStringList(foodname, value);
        });
        
    }else if(operation == 'readuser'){  //读取用户数据，账户密码
        
        var user = prefs.getString('name');
        if (user == null){
            return 'empty';
        }
        var password = prefs.getString('password');
        print(user+password);
        Map backdata = {
            'name' : user,
            'password' : password,
        };
        return backdata;
        
    }else if(operation == 'readfood'){  // 读出食品数据
        //        名字   foodname
        //        价格   price
        //        食用次数 times
        //        类型   type
        //        备注   notes
        //        地点   location
        //        坐标  coord
        var food_map = new Map();
        var all = prefs.getKeys();
        all.forEach((key){
            if (key!='name' && key!='password'){
                food_map[key] = prefs.getStringList(key);
            }
        });
        return food_map;
        
    }else if(operation == 'remove'){  //删除数据，删除食物时使用
        data.forEach((foodname,value){
            prefs.remove(foodname);
        });
        
    }else if(operation == 'clear'){  //清除所有数据，用户登录时使用
        prefs.clear();
    }
    
}