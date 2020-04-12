import 'dart:math';

import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/material.dart';
import 'package:what_to_eat/functions/Functions.dart';
import 'package:image/image.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import '../functions/SharedPreferences.dart';
import '../pages/ChatDetail.dart';
import '../functions/ProviderChat.dart';
import 'package:provider/provider.dart';
import '../functions/ProviderChat.dart';
import '../pages/Second.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  TextEditingController _controller = new TextEditingController();
  
  var chat_status = false;
  String chatText = '聊天功能关闭，点击开启';
 
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatModel>(
      builder: (context, ChatModel chatmodel,_){
        bool isBack = ModalRoute.of(context).isCurrent;
        if (isBack){
          chatmodel.setNowWho('');
      }
        return GestureDetector(
            child: new Padding(
              padding: const EdgeInsets.fromLTRB(5,2,5,5),
              child: new DecoratedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //切换聊天状态
                  Row(
                    children: <Widget>[
                      Text(chatText),
                      Checkbox(
                        value: chatmodel.status,
                        onChanged: ((v) {
                          
                          chatmodel.status ? {chatmodel.EmitMessage('join',{'name': '孙起', 'code': '0'}), chatmodel.clear()} :chatmodel.EmitMessage('join', {'name': '孙起', 'code': '1'});
                          chatmodel.changeState();
                          setState(() {
                            chat_status = v;
                            chatText = v ? '聊天功能开启，点击关闭' : '聊天功能关闭，点击开启';
                          });
                        }),
                      ),
                    ],
                  ),
                  Expanded(
                    child:new ListView.separated(
                      shrinkWrap: true,
                      itemBuilder:_buildListItem,
                      separatorBuilder: (content, index) {
                        return new Divider();},
                      itemCount:max(chatmodel.usercount-1, 1),
                    ) ,
                  )
                ],
              ),
            )
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    
    return Consumer<ChatModel>(
    // ignore: missing_return
    builder: (context, ChatModel chatmodel,_){
      var users = chatmodel.users;
      var user = chatmodel.fromname;
      users.remove(user);
      
      if (users.length >= 1 && chat_status){
        String name = users[index];
        if (name != user ) {
          print('name+'+name);
          print('messagestatus'+chatmodel.allChat[name+'_status'].toString());
          return ListTile(
            leading: Icon(Icons.account_box),
            title: Text(name),
            subtitle: Text('聊一聊'),
            trailing: (chatmodel.allChat[name+'_status'] == true ? Icon(Icons.message,color: Colors.red,):Icon(Icons.keyboard_arrow_right)),
            onTap: () {
              chatmodel.setNowWho(name);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ChatDetailPage();
              }));
            },
          );
        }
      } else {
        return ListTile(
          leading: Icon(Icons.account_box),
          title: Text('无人在线'),
          subtitle: Text('等等吧，先去别的页面吃点'),
        );
      }
    }
    );
    }
    
  Map PackgeMessage(String fromname,String toname,String msg,String time){
    return {
      'fromname': fromname,
      'toname': toname,
      'msg': msg,
      'time': time};
  }
  
  GetTime() async {
    var now = new DateTime.now();
    var a = now.millisecondsSinceEpoch;
    return DateTime.fromMillisecondsSinceEpoch((a)).toString().split('.')[0];
  }
  
}
