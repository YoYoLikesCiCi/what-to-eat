import 'package:flutter/material.dart';
import '../functions/Functions.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var userID = TextEditingController();
  var _password;
  var _password2;
  var email_controller = TextEditingController();
  var _sex;
  //存储数据

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

  _toast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  
  
  stringListWrite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var c = ['slf', 'slf', 'ald', 'slfa'];
    var b = [123, 12, 1233, 1234];
    prefs.setStringList("1", c);
  }

  saveAsyncData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", userID.text.toString());
    await prefs.setString("password", _password);
    print("success");
  }

  //读取数据
  getAsyncData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var some = prefs.getKeys();
    print("keys");
    print(some.runtimeType.toString());
    print(some);
  }

  List<DropdownMenuItem> generateItemList() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem item1 =
        new DropdownMenuItem(value: '男', child: new Text('男'));
    DropdownMenuItem item2 =
        new DropdownMenuItem(value: '女', child: new Text('女'));

    items.add(item1);
    items.add(item2);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('欢迎注册'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(65, 25, 65, 5),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "用户名", hintText: "请输入ID"),
              controller: userID,
              autofocus: true,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "邮箱",
                hintText: "请输入正确的邮箱地址，错误的目前也没关系",
              ),
              controller: email_controller,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
            ),
            
            DropdownButtonHideUnderline(
              child: new DropdownButton(
                hint: new Text('请选择性别'),
                //设置这个value之后,选中对应位置的item，
                //再次呼出下拉菜单，会自动定位item位置在当前按钮显示的位置处
                value: _sex,
                items: generateItemList(),
                onChanged: (T) {
                  setState(() {
                    _sex = T;
                  });
                },
              ),
            ),
            
            TextFormField(
              decoration: InputDecoration(
                labelText: "输入密码",
                hintText: "input password",
              ),
              onChanged: (value) {
                this._password = value;
              },
              maxLines: 1,
              obscureText: true,
              keyboardType: TextInputType.url,
            ),
            
            TextFormField(
                maxLines: 1,
                maxLength: 16,
                obscureText: true,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  labelText: "再次确认密码",
                  hintText: "请再次输入密码",
                ),
                onChanged: (value) {
                  this._password2 = value;
                },
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不能少于6位";
                }),
            SizedBox(
              height: 20,
            ),
            Container(
              child: RaisedButton(
                child: Text('注册'),
                onPressed: () {
                  if(userID.text.length == 0){
                      _alertDialog('错误', '用户名为空，请输入正确的用户名');
                  }else if(this._password == null){
                      _alertDialog( '错误', '密码为空，请输入正确格式的密码');
                  }else if(_password2 != _password ){
                      _alertDialog('错误','两次输入的密码不一致，请重新输入');
                  }else if(_sex == null){
                      _alertDialog('错误', '请选择性别');
                  }else {
                      print(this._password);
                      print(userID.text.length);
                      var tempmap = {
                          'name': userID.text,
                          'password': _password,
                          'email': email_controller.text,
                          'sex' : _sex,
                      };
                      saveAsyncData();
                      var status = UserDataPost('register', tempmap);
                      if ( status == 0 ){
                          _alertDialog('网络错误','服务器发生了未知的错误，请稍后尝试');
                      }else if (status==2){
                         _alertDialog('用户名错误','用户名已存在，请重新注册');
                      } else {
                          Navigator.of(context).pop();
                          _toast('注册并登录成功');
                          
                      }
                  }
                  
                },
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text('获取'),
                onPressed: () {
                  print(localData('readuser'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
