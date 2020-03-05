import 'package:flutter/material.dart';
import '../functions/Recipe.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
class KitchenPage extends StatefulWidget {
    @override
    _KitchenPageState createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
    var kk = 'd';
    var html;
    var page = 1;
    var _keywordController = TextEditingController();
    List first_data = [{'img':'//i3.meishichina.com/attachment/recipe/2015/01/06/c640_201501061420546594200.jpg?x-oss-process=style/c180','name':'红烧牛肉','raw':'原料：土豆、胡萝卜、大葱、姜片、八角、桂皮、红辣椒、草果、冰糖、十三香、盐、味精、老抽生抽、料酒。'}];
    @override
    Widget build(BuildContext context) {
        return Container(
            child: Column(
                children: <Widget>[
                    Row(
                        children: <Widget>[
                            Expanded(
                                child: Padding(
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: '准备做些什么呢？小当家'
                                        ),
                                        controller: _keywordController,
                                        textInputAction: TextInputAction.search,
                                        onTap: (){_keywordController.text = "";
                                        setState(() {
                                        
                                        });},
                                    ),
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                ),
                                flex: 4,
                            ),
                            Expanded(
                                child: Padding(
                                    child: RaisedButton(
                                        child: Text('寻谱'),
                                        onPressed: () async {
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            page = 1;
                                            html = await searchType(_keywordController.text,page);
                                            first_data=html_parse(html);
                                            setState(() {
                                            
                                            });
                                        },
                                    ),
                                    padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                                ),
                                flex: 1,
                            ),
                        ],
                    ),
                    Expanded(
                        child:new ListView.builder(
                            itemBuilder: _buildListItem,
//              separatorBuilder: (content, index) {
//                return new Divider();},
                            itemCount: first_data.length,
                        ) ,
                    ),
                ],
            ),
        );
    }
    
    Widget _buildListItem(BuildContext context,int index){
        var item = first_data[index];
        
        return Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.zero,
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.circular(20.0)
                )
            ),
            margin: EdgeInsets.all(5),
            child:Container(
                child: ListTile(
                    leading: Image.network('http:'+item['img'],fit: BoxFit.fill,),
                    title: Text(item['name']),
                    subtitle: Text(item['raw']),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue[200],width:1.7),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.zero,
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(20.0),
                    )
                ),
            )
        );
        
    }
}
