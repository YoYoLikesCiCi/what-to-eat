import 'package:flutter/material.dart';
import '../functions/Recipe.dart';
import '../style/theme.dart';
import 'dart:async';

class DetailsPage extends StatefulWidget {
    DetailsPage({Key,key,this.url}):super(key:key);
    final String url;
  @override
  _DetailsPageState createState() => _DetailsPageState();
  
  
}

class _DetailsPageState extends State<DetailsPage> {
    
    Map data = new Map();
    
    int status = 1;
    String html = '';
    Map ready = new Map();
    Map food_material = new Map();
    List step = [];
    String Tips = '';
    List main_raw = [];
    List ingredient = [];
    List<Widget> ingredient_widget = [];
    List<Widget> main_raw_widget = [Text('error')];
    
    
    
    initWhenEnter()async{
        print(widget.url);
        if((html = await detail_html_get(widget.url))!='false'){
            data = detail_parse(html);
            ready = data['ready'];
            food_material = data['food_material'];
            step = data['step'];
            Tips = data['tips'];
            main_raw = food_material['main_raw'];
            ingredient = food_material['ingredient'];
            main_raw_widget.clear();
            main_raw_widget =  MainRowBuilder(main_raw);
            ingredient_widget = MainRowBuilder(ingredient);
            
            setState(() {
            
            });
        }else{
            status = 0;
        }
        
        
    }
    @override
    void initState(){
        initWhenEnter();
        
    }
    
    @override
    Widget build(BuildContext context) {
        return status==1?Scaffold(
            appBar: AppBar(
                title: Text(ready['title']!=null?ready['title']:'error'),
            ),
            body: ListView(
                children: <Widget>[
                    Card(
                        margin: EdgeInsets.all(1),
                        child: Column(
                            
                            children: <Widget>[
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(19),
                                    child: ready['main_img']!=null ? Image.network(ready['main_img'],fit: BoxFit.fitWidth,):Text('error'),
                                ),
                                Container(
                                    child: Text(ready['description']!=null ? ready['description']:'empty'),
                                    
                                )
                            ],
                        ),
                    ),
                    Divider(),
                    Column(
                        children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue[200],width:1.7),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                    )
                                ),
                                child: Row(
                                    children: <Widget>[
                                        Expanded(
                                            child: Container(
                                                child: Column(
                                                    children: <Widget>[
                                                        Text('主'),
                                                        Text('料'),
                                                    ],
                                                ),
                                            ),
                                            flex: 1,
                                        ),
                                        Expanded(
                                            child: Card(
                                                child:Padding(
                                                    padding: const EdgeInsets.all(8),
                                                    child: Wrap(
                                                        spacing: 10,
                                                        runSpacing: 10,
                                                        alignment: WrapAlignment.spaceEvenly,
                                                        runAlignment: WrapAlignment.end,
                                                        children: main_raw_widget,
                                                    ),
                                                ),
                                            ),
                                            flex: 7,
                                        )
                                    ],
                                ),
                            ),
                            Divider(),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue[200],width:1.7),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                    )
                                ),
                                child: Row(
                                    children: <Widget>[
                                        Expanded(
                                            child: Container(
                                                child: Column(
                                                    children: <Widget>[
                                                        Text('配'),
                                                        
                                                        Text('料'),
                                                    ],
                                                ),
                                            ),
                                            flex: 1,
                                        ),
                                        Expanded(
                                            child: Card(
                                                child:Padding(
                                                    padding: const EdgeInsets.all(8),
                                                    child: Wrap(
                                                        spacing: 10,
                                                        runSpacing: 10,
                                                        alignment: WrapAlignment.spaceEvenly,
                                                        runAlignment: WrapAlignment.end,
                                                        children: ingredient_widget,
                                                    ),
                                                ),
                                            ),
                                            flex: 7,
                                        )
                                    ],
                                ),
                            )
                        ],
                    ),
                    Divider(),
                    Column(
                        children: StepWidgetBuilder(step),
                    ),
                    Divider(),
                    Card(
                        
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                            )
                        ),
                        child: Column(
                            children: <Widget>[
                                Container(
                                    height: 20,
                                    child: Center(
                                        child: Text('Tips', ),
                                    )
                                    
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(15, 0, 15, 3),
                                    decoration: BoxDecoration(
                                        
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0),
                                            bottomRight: Radius.circular(20.0),
                                        )
                                    ),
                                    child: Text(Tips),
                                ),
                            ],
                        )
                    )
                ],
            )
        ):
        Scaffold(
            appBar: AppBar(
                title:Text('error'),
            ),
            body:Center(
                child: Column(
                    children: <Widget>[
                        Text('something went wrong'),
                    ],
                ),
            )
        );
        
    }
    List<Widget> StepWidgetBuilder(List k){
        List<Widget> step = [];
        k.forEach((v){
            step.add(Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                    )
                ),
                margin: EdgeInsets.all(5),
               child: Container(
                   decoration: BoxDecoration(
                       border: Border.all(color: Colors.blue[200],width:1.7),
                       borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(20.0),
                           topRight: Radius.circular(20.0),
                           bottomLeft: Radius.circular(20.0),
                           bottomRight: Radius.circular(20.0),
                       )
                   ),
                   child: Row(
                       children: <Widget>[
                           Expanded(
                               flex: 1,
                               child: ClipRRect(
                                   borderRadius: BorderRadius.circular(19),
                                   child: Image.network(v['img'],),
                               )
                           ),
                           Expanded(
                               child: Text(v['word']),
                               flex: 1,
                           )
                       ],
                   ),
               ),
            ));
        });
        return step;
    }
    
    List<Widget> MainRowBuilder(List k){
        List<Widget> Raw = [];
        k.forEach((v){
            Raw.add(getTimeBoxUI(v['title'], v['count']));
        });
        return Raw;
    }
    
    Widget getTimeBoxUI(String text1, String txt2) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    color: DesignCourseAppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: DesignCourseAppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 8.0),
                    ],
                ),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Text(
                                text1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.nearlyBlue,
                                ),
                            ),
                            Text(
                                txt2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.grey,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}

