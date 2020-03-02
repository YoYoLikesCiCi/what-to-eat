import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:what_to_eat/style/theme.dart' as theme;
import '../functions/Functions.dart';
import '../functions/SharedPreferences.dart';

/**
 *登陆界面
 */
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  /**
   * 利用FocusNode和FocusScopeNode来控制焦点
   * 可以通过FocusNode.of(context)来获取widget树中默认的FocusScopeNode
   */
  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusScopeNode focusScopeNode = new FocusScopeNode();
  GlobalKey<FormState> _SignInFormKey = new GlobalKey();

  bool isShowPassWord = false;

  var _userID = TextEditingController();
  var _password = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 23),
      child: new Stack(
        alignment: Alignment.center,
//        /**
//         * 注意这里要设置溢出如何处理，设置为visible的话，可以看到孩子，
//         * 设置为clip的话，若溢出会进行裁剪
//         */
//        overflow: Overflow.visible,
        children: <Widget>[
          new Column(
            children: <Widget>[
              //创建表单
              buildSignInTextForm(),
              buildSignInButton(),
            ],
          ),
          SizedBox(height: 400,),
//          new Positioned(child: buildSignInButton(), top: 170,)
        ],
      ),
    );
  }

  /**
   * 点击控制密码是否显示
   */
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
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

  
  /**
   * 创建登录界面的TextForm
   */
  Widget buildSignInTextForm() {
    return new Container(
      decoration:
      new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8))
          , color: Colors.white
      ),
      width: 300,
      height: 190,
      /**
       * Flutter提供了一个Form widget，它可以对输入框进行分组，
       * 然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。
       */
      child: new Form(
        key: _SignInFormKey,
        //开启自动检验输入内容，最好还是自己手动检验，不然每次修改子孩子的TextFormField的时候，其他TextFormField也会被检验，感觉不是很好
//        autovalidate: true,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: new TextFormField(
                  //关联焦点
                  focusNode: emailFocusNode,
                  onEditingComplete: () {
                    if (focusScopeNode == null) {
                      focusScopeNode = FocusScope.of(context);
                    }
                    focusScopeNode.requestFocus(passwordFocusNode);
                  },

                  decoration: new InputDecoration(
                      icon: new Icon(Icons.account_box, color: Colors.black,),
                      hintText: "用户名",
                      border: InputBorder.none
                  ),
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  //验证
                  validator: (value) {
                    if (value.isEmpty) {
                      return "用户名为空!";
                    }
                  },
                  controller: _userID,
                ),
              ),
            ),
            new Container(
              height: 1,
              width: 250,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20),
                child: new TextFormField(
                  focusNode: passwordFocusNode,
                  decoration: new InputDecoration(
                      icon: new Icon(Icons.lock, color: Colors.black,),
                      hintText: "请输入密码",
                      border: InputBorder.none,
                      suffixIcon: new IconButton(icon: new Icon(
                        Icons.remove_red_eye, color: Colors.black,),
                          onPressed: showPassWord)
                  ),
                  //输入密码，需要用*****显示
                  obscureText: !isShowPassWord,
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6 ||value.length >16) {
                      return "密码长度须大于6位小于16位";
                    }
                  },
                  controller: _password,
                ),
              ),
            ),


          ],
        ),),
    );
  }

  /**
   * 创建登录界面的按钮
   */
  Widget buildSignInButton() {
    return
      new GestureDetector(
        child: new Container(
          padding: EdgeInsets.only(left: 42, right: 42, top: 10, bottom: 10),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: theme.Theme.primaryGradient2,
          ),
          child: new Text(
            "LOGIN", style: new TextStyle(fontSize: 25, color: Colors.white),),
        ),
        onTap: () async{
          if (_SignInFormKey.currentState.validate()) {
            //如果输入都检验通过，则进行登录操作
            Map aa = {
              'name' : _userID.text,
              'password' : _password.text
            };
            var bb = await Login(aa);
            if (bb == 1){
              localData('saveuser',data:{'nameJZM':_userID.text,'passwordJZM':_password.text});
              Navigator.pushReplacementNamed(context, '/');
            }else if(bb == 3){
              alertDialog('错误', '用户不存在，请输入正确的用户名');
            }else if(bb == 2){
              alertDialog('错误', '密码错误，请输入正确的密码');
            }else{
              alertDialog('网络错误', '服务出现问题，请稍后再试');
            }
            
          }
//          debugDumpApp();
        },

      );
  }
}