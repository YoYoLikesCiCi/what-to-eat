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
    
    List _pageList = [
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
          body: this._pageList[this._currentIndex],
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.people),
              onPressed: (){
                  print('floatingActionButton tabs');
              },
        
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: this._currentIndex,
              onTap: (int index){
                  setState(() {
                      this._currentIndex = index;
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
                      title: Text('小福贵'),
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
}