import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 聊天信息的布局
 */
class MessageItem extends StatelessWidget {
    final  message;
    
    MessageItem(this.message);
    
    @override
    Widget build(BuildContext context) {
//    Widget timeWidget = Visibility(
//      child: Container(
//        child: Text(DateUtil.getNewChatTime(message.sendTime)),
//      ),
//      visible: message.timeVisility == true,
//    );
    
        Widget messageWidget;
        if (message['status'] == 'Send') {
            messageWidget = MineMessageItem(message);
        } else {
//            print('build otherItem');
            messageWidget = OtherMessageItem(message);
        }
        
        return Column(
            children: <Widget>[
//        timeWidget,
                messageWidget
            ],
        );
    }
}

/**
 * 自己
 */
class MineMessageItem extends StatelessWidget {
    final  message;
    
    MineMessageItem(this.message);
    
    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.all(10),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    SizedBox(
                        width: 10,
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
//                Text("username"),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                    ),
                                    color: Color(0xff9FE658),
                                    child: Text(message['msg']),
                                ),
                            ],
                        ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image(
                            width: 35,
                            height: 35,
                            image: AssetImage("assets/cat.jpeg")
                        ),
                    ),
                ],
            ),
        );
    }
}

/**
 * 别人的Item
 */
class OtherMessageItem extends StatelessWidget {
    final message;
    
    OtherMessageItem(this.message);
    
    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.all(10),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image(
                            image:AssetImage("assets/mouse.jpeg"),
                            width: 35,
                            height: 35,
                        ),
                    ),
                    SizedBox(
                        width: 10,
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 5,
                                    ),
                                    color: Colors.lightBlue[100],
                                    child: Text(message['msg']),
                                ),
                            ],
                        ),
                    )
                ],
            ),
        );
    }
}
