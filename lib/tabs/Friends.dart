import 'dart:math';
import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/material.dart';
import '../pages/ChatDetail.dart';
import '../models/ProviderChat.dart';
import 'package:provider/provider.dart';

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
          chatmodel.setNowWho('');}
        
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
                          chatmodel.GetUser();
                          chatmodel.status ? {chatmodel.EmitMessage('join',{'name': chatmodel.fromname, 'code': '0'}), chatmodel.clear()} :chatmodel.EmitMessage('join', {'name': chatmodel.fromname, 'code': '1'});
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
            leading: (name == '孙起'?Icon(Icons.star,color: Colors.red,):Icon(Icons.account_box)),
            title: Text(name),
            subtitle: Text((name == '孙起'?'独家认证（只孙起一家）开发者':'聊一聊')),
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
