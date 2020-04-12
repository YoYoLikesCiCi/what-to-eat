import 'package:flutter/material.dart';
import '../tabs/Buybuy.dart';
import '../tabs/Kitchen.dart';
import '../tabs/Mylike.dart';
import '../tabs/Friends.dart';


class Tabs extends StatefulWidget {
    final index ;
    Tabs({Key key, this.index=0}):super(key:key);
    @override
    _TabsState createState() => _TabsState(this.index);
}

class _TabsState extends State<Tabs> {
    
    int _currentIndex ;
    
    _TabsState(index){
        this._currentIndex = index;
    }
    
    List<Widget> _pageList = [
        MyLikePage(),
        BuyBuyPage(),
        KitchenPage(),
        FriendsPage(),
    ];
    
    
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
              title: Text('今天吃啥哟'),
          ),
          body:IndexedStack(
              index:this._currentIndex,
              children: this._pageList,
          ),
          floatingActionButton: FloatingActionButton(
              child: Text('食',style: TextStyle(fontSize: 28),),
              onPressed: (){
                  _alertDialog('决定了', '今天要吃的是--牛肉面，价格：¥10，准备好碎银去享受美食吧！');
              },
        
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: this._currentIndex,
              onTap: (int index){
                  setState(() {
                      this._currentIndex = index;
                      if (_currentIndex == 2){
                      
                      }
                  });
              },
              type: BottomNavigationBarType.fixed,
              items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      title: Text('选最爱'),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.restaurant),
                      title: Text('下馆子'),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.kitchen),
                      title: Text('小当家'),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.supervisor_account),
                      title: Text('小圈子'),
                  ),
              ],
          ),
          drawer: Drawer(
              child: Column(
                  children: <Widget>[
                      Row(
                          children: <Widget>[
                              Expanded(
                                  child: UserAccountsDrawerHeader(
                                      accountName: Text('Jess Aarons'),
                                      accountEmail: Text('youl'),
                                      currentAccountPicture: CircleAvatar(
                                          backgroundImage: NetworkImage('https://www.itying.com/images/flutter/3.png'),
                                      ),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage('https://www.itying.com/images/flutter/2.png'),
                                              fit: BoxFit.cover,
                                          )
                                      ),
                                      otherAccountsPictures: <Widget>[
                                          Image.network('https://www.itying.com/images/flutter/4.png'),
                                          Image.network('https://www.itying.com/images/flutter/5.png')
                                      ],
                                  )
                              )
                          ],
                      ),
//                        DrawerHeader(
//                            child: Text('hello flutter'),
//                        ),
                      ListTile(
                          leading: CircleAvatar(
                              child: Icon(Icons.home),
                          ),
                          title: Text('my zone'),
                      ),
                      Divider(),
                      ListTile(
                          leading: CircleAvatar(
                              child: Icon(Icons.people),
                          ),
                          title: Text('user center'),
                      ),
                      Divider(),
                      ListTile(
                          leading: CircleAvatar(
                              child: Icon(Icons.settings),
                          ),
                          title: Text('settings center'),
                      )
                  ],
              ),
          ),
          endDrawer: Drawer(
              child: Text('right drawer'),
          ),
      );
  }

    _alertDialog(String title, String Message) async {
        var result = await showDialog(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: Text(title),
                    content: Text(Message),
                    actions: <Widget>[
                        FlatButton(
                            child: Text('cancel'),
                            onPressed: () {
                                Navigator.pop(context, 'cancel');
                            },
                        ),
                        FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                                Navigator.pop(context, 'yes');
                            },
                        )
                    ],
                );
            });
    }
}