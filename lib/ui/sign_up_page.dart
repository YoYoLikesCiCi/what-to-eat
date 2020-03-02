import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:what_to_eat/style/theme.dart' as theme;
import 'package:fluttertoast/fluttertoast.dart';
import '../functions/Functions.dart';
import '../functions/SharedPreferences.dart';
/**
 * 注册界面
 */
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  
  _toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }



  /**
   * 点击控制密码是否显示
   */
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  void showPassWord2() {
    setState(() {
      isShowPassWord2 = !isShowPassWord2;
    });
  }

  alertDialog(String title, String Message) async {
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
  
  
  bool isShowPassWord = false;
  bool isShowPassWord2 = false;

  var userID = TextEditingController();
  var _password;
  var _password2;
  var email_controller = TextEditingController();
  GlobalKey<FormState> _SignUpFormKey = new GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(top: 23),
        child: new Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: <Widget>[
            new Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                ),
                width: 300,
                height: 360,
                child: buildSignUpTextForm()),
            new SizedBox(
              height: 800,
            ),
            new Positioned(
              child: new Center(
                  child: GestureDetector(
                child: Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 42, right: 42),
                  decoration: new BoxDecoration(
                    gradient: theme.Theme.primaryGradient2,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: new Text(
                    "SignUp",
                    style: new TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                onTap: () async {
                  if (_SignUpFormKey.currentState.validate()) {
                    if (userID.text.length == 0) {
                      alertDialog('错误', '用户名为空，请输入正确的用户名');
                    } else if (this._password == null) {
                      alertDialog('错误', '密码为空，请输入正确格式的密码');
                    } else if (_password2 != _password) {
                      alertDialog('错误', '两次输入的密码不一致，请重新输入');
                    } else {
                      var tempmap = {
                        'name': userID.text,
                        'password': _password,
                        'email': email_controller.text,
                        'sex': '男',
                      };

                      var status = await UserDataPost('register', tempmap);
                      if (status == 0) {
                        alertDialog('网络错误', '服务器发生了未知的错误，请稍后尝试');
                      } else if (status == 2) {
                        alertDialog('用户名错误', '用户名已存在，请重新注册');
                      } else if (status == 1) {
                        Map tempmap2 = {
                          'nameJZM': userID.text,
                          'passwordJZM': _password
                        };
                        localData('saveuser', data: tempmap2);
                        Navigator.pushReplacementNamed(context, '/');
                        _toast('注册并登录成功');
                      }
                    }
                  }
                },
              )),
              top: 360,
            )
          ],
        ));
  }

  Widget buildSignUpTextForm() {
    return new Form(
      key: _SignUpFormKey,
        child: new Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //用户名字
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: new TextFormField(
              decoration: new InputDecoration(
                  icon: new Icon(
                    FontAwesomeIcons.user,
                    color: Colors.black,
                  ),
                  hintText: "用户名",
                  border: InputBorder.none),
              style: new TextStyle(fontSize: 16, color: Colors.black),
              controller: userID,
//              validator: (value) {
//                if (value.isEmpty) {
//                  return "用户名为空!";
//                };
//              },
            ),
          ),
        ),
        new Container(
          height: 1,
          width: 250,
          color: Colors.grey[400],
        ),
        //邮箱
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: new TextFormField(
              decoration: new InputDecoration(
                  icon: new Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  hintText: "邮箱",
                  border: InputBorder.none),
              style: new TextStyle(fontSize: 16, color: Colors.black),
              controller: email_controller,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
        new Container(
          height: 1,
          width: 250,
          color: Colors.grey[400],
        ),
        //密码
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: new TextFormField(
              decoration: new InputDecoration(
                icon: new Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                hintText: "请输入密码",
                border: InputBorder.none,
                suffixIcon: new IconButton(
                    icon: new Icon(
                      Icons.remove_red_eye,
                      color: Colors.black,
                    ),
                    onPressed: showPassWord),
              ),
              onChanged: (value) {
                this._password = value;
              },
              obscureText: !isShowPassWord,
              style: new TextStyle(fontSize: 16, color: Colors.black),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.length < 6 ||
                    value.length > 16) {
                  return "密码长度须大于6位小于16位";
                }
              },
            ),
          ),
        ),
        new Container(
          height: 1,
          width: 250,
          color: Colors.grey[400],
        ),
        //确认密码
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: new TextFormField(
              decoration: new InputDecoration(
                icon: new Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                hintText: "请确认密码",
                border: InputBorder.none,
                suffixIcon: new IconButton(
                    icon: new Icon(
                      Icons.remove_red_eye,
                      color: Colors.black,
                    ),
                    onPressed: showPassWord2),
              ),
              onChanged: (value) {
                this._password2 = value;
              },
              obscureText: !isShowPassWord2,
              style: new TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ],
    ));
  }
}
