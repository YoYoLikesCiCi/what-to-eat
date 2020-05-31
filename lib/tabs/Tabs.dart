import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_to_eat/functions/SharedPreferences.dart';
import 'package:what_to_eat/models/Foods.dart';
import '../tabs/Buybuy.dart';
import '../tabs/Kitchen.dart';
import '../tabs/Mylike.dart';
import '../tabs/Friends.dart';
import '../models/Email.dart';
import '../main.dart';

class Tabs extends StatefulWidget {
  final index;
  Tabs({Key key, this.index = 0}) : super(key: key);
  @override
  _TabsState createState() => _TabsState(this.index);
}

class _TabsState extends State<Tabs> {
  int _currentIndex;
  final TelAndSmsService _service = locator<TelAndSmsService>();
  _TabsState(index) {
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
    return Consumer<FoodModel>(
        // ignore: missing_return
        builder: (context, FoodModel foodmodel, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text('今天吃啥哟'),
        ),
        body: IndexedStack(
          index: this._currentIndex,
          children: this._pageList,
        ),
        floatingActionButton: FloatingActionButton(
          child: Text(
            '食',
            style: TextStyle(fontSize: 28),
          ),
          
          onPressed: () async {
              if(foodmodel.food_names.length != 0){
                var resultfood = foodmodel.RandomIt();
                alertDialog(context,'决定了', resultfood);
              }else{
                alertDialog2(context, '出错了', '你还没有添加任何好吃的，所以现在我还不能替你选择哦');
              }
              
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
              if (_currentIndex == 2) {}
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
                    accountName: Text(
                      '开发者：孙起',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 15),
                    ),
//                                      accountEmail: Text('youlikescici@gmail.com',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15)),
                    currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage(
                      'assets/me.jpeg',
                    )),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/fresh.jpg'),
                      fit: BoxFit.cover,
                    )),
//                                      otherAccountsPictures: <Widget>[
//                                          Image.network('https://www.itying.com/images/flutter/4.png'),
//                                          Image.network('https://www.itying.com/images/flutter/5.png')
//                                      ],
                  ))
                ],
              ),
//                        DrawerHeader(
//                            child: Text('hello flutter'),
//                        ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.chat),
                ),
                title: Text('QQ:704922102'),
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.mail),
                ),
                title: Text('YoYoLikesCiCi@gmail.com'),
                onTap: () {
                  _service.sendEmail('yoyolikescici@gmail.com');
                },
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.exit_to_app),
                ),
                title: Text('Log Out'),
                onTap: () {
                  localData('clear');
                  foodmodel.ClearAll();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/signpage', (Route<dynamic> route) => false);
                },
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.new_releases),
                ),
                title: Text('about'),
                onTap: () {
                  alertDialog2(context, '关于', "此App为个人学习之余制作，本人经验不多，App可能会有各种各样的bug，还请各位见谅，如有兴致，可联系我讨论你的想法或者反馈bug。\n联系方式详见侧栏:)");
                },
              )
            ],
          ),
        ),
//          endDrawer: RaisedButton(
//              child: Text('right drawer'),
//          ),
      );
    });
  }

  alertDialog(BuildContext context, String title, String Message) async {
    var result = await showDialog(
        context: context,
        // ignore: missing_return
        builder: (context) {
          return Consumer<FoodModel>(builder: (context, FoodModel foodmodel, _) {
            return AlertDialog(
                title: Text(title),
                content: Text('今天要吃的是-- ${Message} --，价格：¥${foodmodel.food_names[Message]['price']}，要去${foodmodel.food_names[Message]['location']}吃哦，去充电吧！皮卡丘！'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('取消'),
                    onPressed: () {
                      Navigator.pop(context, 'cancel');
                    },
                  ),
                  FlatButton(
                    child: Text('确定'),
                    onPressed: () {
                      foodmodel.DoIt(Message);
                      Navigator.pop(context, 'yes');
                      
                    },
                  )
                ]);
          });
        });
  }
  alertDialog2(BuildContext context, String title, String Message) async {
    var result = await showDialog(
        context: context,
        // ignore: missing_return
        builder: (context) {
          return Consumer<FoodModel>(builder: (context, FoodModel foodmodel, _) {
            return AlertDialog(
                title: Text(title),
                content: Text(Message),
                actions: <Widget>[
//                  FlatButton(
//                    child: Text('取消'),
//                    onPressed: () {
//                      Navigator.pop(context, 'cancel');
//                    },
//                  ),
                  FlatButton(
                    child: Text('确定'),
                    onPressed: () {
                      Navigator.pop(context, 'yes');
                    },
                  )
                ]);
          });
        });
  }
}
