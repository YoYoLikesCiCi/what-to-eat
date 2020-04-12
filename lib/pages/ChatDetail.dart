import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:what_to_eat/functions/Functions.dart';
import 'package:image/image.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import '../functions/SharedPreferences.dart';
import 'package:provider/provider.dart';
import '../models/ProviderChat.dart';
import 'MessageItem.dart';

class ChatDetailPage extends StatefulWidget {
  
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
    String text = "";
    
    TextEditingController inputController = TextEditingController(text: "");
    ScrollController scrollController = new ScrollController();

    sendMessage(){
    
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

    @override
  Widget build(BuildContext context) {
    
    return Consumer<ChatModel>(
        builder: (context, ChatModel chatmodel,_){
            List messageList = chatmodel.getChatRecord(chatmodel.now_who);
            
            return Scaffold(
                appBar: AppBar(
                    title: Text(chatmodel.now_who),
                ),
                body: GestureDetector(
                    //点击空白处收回键盘
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                        FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                            Expanded(
                                flex: 8,
                                child: CupertinoScrollbar(
                                    child: ListView.builder(
                                        reverse: true,
                                        controller: scrollController,
                                        itemBuilder: (context, index){
                                            return MessageItem(messageList[index]);
                                        },
                                        itemCount:(messageList==null ? 0 : messageList.length),
                                    ),
                                ),
                            ),
                            Container(
                                height: 1,
                                color: Colors.blue,
                            ),
                            //消息发送框
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                    Expanded(
                                        child: TextFormField(
                                            controller: inputController,
                                        ),
                                    ),
                                    RaisedButton(
                                        
                                        onPressed: ()async{
                                            if(inputController.text.length != 0){
                                                chatmodel.SendMessage(PackgeMessage(chatmodel.fromname, chatmodel.now_who, inputController.text, await GetTime()));
                                                inputController.clear();
                                            }
                                            
                                            },
                                        child:Text('send')
                                    )
                                ],
                            ),
                        ],
                    ),
                ),
            );
        }
    );

    
  }
  
}
