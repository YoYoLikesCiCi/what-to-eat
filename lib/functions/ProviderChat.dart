import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../functions/SharedPreferences.dart';
import '../pages/ChatDetail.dart';


class ChatModel with ChangeNotifier{
    var status = false;
    String fromname = '';
    IO.Socket socket;
    int usercount = 1;
    List users = []; //在线用户列表
    String now_who = '';
    
    ChatModel(){
        GetUser();
        if(fromname != 'empty'){
            IOthins();
        }
    }
    Map allChat = {};
    
    
    //处理发送的信息
    void SendMessage(Map sed){
        var you = sed['toname'];
        var time = sed['time'];
        var msg = sed['msg'];
        print('inmap+${sed.toString()}');
        if(this.allChat.containsKey(you)){
    
            var single_msg = {'status':'Send','msg':msg,'time':time };
            this.allChat[you].insert(0,single_msg);
            
        }else{
            List  msgs = [];
            var single_msg = {'status':'Send','msg':msg,'time':time };
            msgs.add(single_msg);
            this.allChat[you] = msgs;
        }
        socket.emit('chat',sed);
        notifyListeners();
    }
    
    
    //处理接收的信息
    void ReceiveMessage(Map rec){
        
        var you = rec['fromname'];
        var time = rec['time'];
        var msg = rec['msg'];
        
        if(this.allChat.containsKey(you)){
            
            var single_msg = {'status':'Rec','msg':msg,'time':time };
            this.allChat[you].insert(0,single_msg);
            
        }else{
            List  msgs = [];
            var single_msg = {'status':'Rec','msg':msg,'time':time };
            msgs.add(single_msg);
            this.allChat[you] = msgs;
        }
        if(now_who != you)
       {
           this.allChat[you+'_status'] = true;//是否有新消息
       }
        notifyListeners();
    }
    
    List getChatRecord(String name){
        return allChat[name];
    }
    
    void EmitMessage(String way,Map map){
        socket.emit(way,map);
    }
    
    //设置在线用户数量
    int UserCount(){
        this.usercount =  allChat.length;
        notifyListeners();
    }
    
    //设置用户名
    void Setname(String name){
        this.fromname = name;
        IOthins();
    }
    
    void changeState(){
        status = !status;
        print(status.toString());
        notifyListeners();
    }
    //读取本地存储的用户名
    GetUser() async {
        var temp = await localData('readuser');
        fromname = temp['nameJZM'];
    }
    
    void setNowWho(String name){
        this.now_who = name;
        allChat[name+'_status']= false;
    }
    void clear(){
        users.clear();
        usercount = 0;
    }
    
    
    void IOthins(){
        socket = IO.io('ws://47.93.25.50', <String, dynamic>{
            'transports': ['websocket'],
            'login': {'username': fromname} // optional
        });
    
        socket.on('connect', (data2) {
            print('connect');
            print(data2);
        });
        socket.on('message', (data2) {
            print('message');
//      print(data2.runtimeType.toString());
            print(data2);
        });
        socket.on('json', (data2) {
            print('json');
            print(data2);
        });
    
        socket.on('join', (data2) {
            this.users = data2;
            users.forEach((f){
                if(allChat.containsKey(f+'_status') == false){
                    allChat[f+'_status'] =false;
                }
                
            });
            print(users);
            usercount = this.users.length;
            notifyListeners();
        });
        socket.on('chat', (data2) {
            print('chat');
            ReceiveMessage(data2);
        });
    
        socket.on('login', (data2) {
            print('login');
            print(data2);
        
        });
        socket.on('event', (data2) {
            print('event');
            print(data2.runtimeType.toString());
            print(data2);
        });
        socket.on('disconnect', (_) {
        });
    
        socket.on('fromServer', (data2) {
            print('fromserver');
            print(data2);
        });
    }
    
}





class CounterModel with ChangeNotifier {
    int _count = 1;
    int get value => _count;
    
    void increment() {
        _count++;
        notifyListeners();
    }
}

