import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';

String EatIt(Map userdata){
    var rng = new Random(GetTime());
    
//    Map food_and_times ={};
    List food = [];
    List times = [];
    List weights = [];//权重
    num totaltimes = 0;
    int totalweights = 0;
    userdata.forEach((f , v ){
        food.add(f);
       times.add(v['times']);
       totaltimes += v['times'];  //总次数
       
    });
    
    int length = food.length;
    
    double result = totaltimes.toDouble()/length.toDouble();
    int avg = result.toInt();
//    print(result);
    if (result.compareTo(3.00) == -1){//小于3 ，执行完全随机
        int got = rng.nextInt(length);
//        print('length'+length.toString());
//        print(got);
        return food[got];
    }else{
        //平均值大于3 ， 执行加权随机
        
        //开始加权
        for(var i = 0; i<length;i++){
            if(times[i]<avg ){
                weights.add(times[i] + avg);
                totalweights += weights[i];
            }else if(times[i]> avg){
                weights.add(CounterWeight(times[i]-avg, avg));
                totalweights += weights[i];
            }else{
                weights.add(times[i]);
                totalweights += weights[i];
            }
        }
        
        //加权完成后开始加权随机算法
        int got = rng.nextInt(totalweights);
//        print(weights);
//        print(food);
//        print(times);
//        print('totalweights:'+totalweights.toString()+"   got:"+got.toString() + 'avg:'+avg.toString());
        for(var i = 0; i<length ; i++){
            got -= weights[i];
            if(got <= 0 ){
                return food[i];
            }
        }
        
    }
    
    
    result.isNegative;
}

 GetTime()  {
    var now = new DateTime.now();
    var a = now.millisecondsSinceEpoch;
//    print(a);
    return a;
}

CounterWeight(int difference, int avg){
    //difference 为 that和平均数的差，必定大于0
//    int difference = that - avg;

    if(avg - difference > 0 ){
        return avg-difference;
    }else{
        return (CounterWeight(difference~/2, avg));
    }
}