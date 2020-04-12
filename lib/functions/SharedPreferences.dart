import 'package:shared_preferences/shared_preferences.dart';

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
        
        var user = prefs.getString('nameJZM');
        if (user == null){
            return 'empty';
        }
        var password = prefs.getString('passwordJZM');
        print(user+password);
        Map backdata = {
            'nameJZM' : user,
            'passwordJZM' : password,
        };
        return backdata;
        
    }else if(operation == 'readfood'){  // 读出食品数据
        //        名字   foodname
        //        价格   price  0
        //        食用次数 times  1
        //        类型   type     2
        //        备注   notes    3
        //        地点   location  4
        //        坐标  coord   5
        var food_map = new Map();
        var all = prefs.getKeys();
        all.forEach((key){
            if (key!='nameJZM' && key!='passwordJZM'){
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
