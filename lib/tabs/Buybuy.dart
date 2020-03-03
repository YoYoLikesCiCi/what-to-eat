import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:decorated_flutter/decorated_flutter.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/scrollable_text.widget.dart';
class BuyBuyPage extends StatefulWidget {
  @override
  _BuyBuyPageState createState() => _BuyBuyPageState();
}

class _BuyBuyPageState extends State<BuyBuyPage> {
  
  
  
  Location location ;
  var tempLatLng = LatLng(29.08,119.65);
  String address = "刷新中……";
  String wheretoeat = "";
  double _latitude;  //纬度
  double _longitude; //经度
  var _keywordController = TextEditingController();
  String searchCode ='050000';
  
  List poiTitleList = [{'title':'想吃啥','address':'8千米内就吃啥','tel':' ','lat':LatLng(29.08,119.65)}];
  
  void _GetLocation()async {
    if (await requestPermission()) {
      location = await AmapLocation.fetchLocation();
      address = await location.address;
      tempLatLng=await location.latLng;
      _latitude = tempLatLng.latitude;
      _longitude = tempLatLng.longitude;
      print(address);
      setState(() {
      
      });
    }
  }

  @override
  void initState(){
    _GetLocation();
  }
  
  @override
  Widget build(BuildContext context) {
    return DecoratedColumn(
      children: <Widget>[
    
        Padding(
         child: Text('当前位置是：'+address,
           maxLines: 2,
           overflow: TextOverflow.fade,
           style: TextStyle(
             fontWeight:FontWeight.w400 ,
           ),
         ),
         padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      ),
        Row(
          
          children: <Widget>[
            
            Expanded(
              child: Padding(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: '输入你想吃的'
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
                  child: Text('觅食'),
                  onPressed: () async {
                    poiTitleList.clear();
                    List poiList = await AmapSearch.searchAround(
                      LatLng(
                        double.tryParse(_latitude.toString()) ?? 29.08,
                        double.tryParse(_longitude.toString()) ?? 119.65,
                      ),
                      keyword: _keywordController.text,
                      type: searchCode,
                    );
                    poiList.forEach((v)async{
                      String address =await v.address;
                      String title =await v.title;
//                      String tel = await v.tel;
                      LatLng latLng =await v.latLng;
//                      double lat = latLng.latitude;
//                      double lon = latLng.longitude;
                      poiTitleList.add({"address":address,"title":title,'lat':latLng});
                      _keywordController.text = '为您找到'+poiTitleList.length.toString()+'个结果';
                      setState(() {

                      });
                    });
                    
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
//        ListTile(
//              leading: Icon(Icons.restaurant_menu),
//              title:Text('店名'),
//              subtitle: Text('地址'),
//            ),
        Expanded(
          child:new ListView.separated(
            itemBuilder: _buildListItem,
            separatorBuilder: (content, index) {
              return new Divider();},
            itemCount: poiTitleList.length,
        ) ,
        )
          ],
        
      
    );
  }

  Widget _buildListItem(BuildContext context,int index){
    print('buildlistitem');
    print(poiTitleList.length);
    if (poiTitleList.length == 0){
      return ListTile(
        leading: Icon(Icons.error),
        title:Text('无结果'),
        subtitle: Text('换一个搜索词吧'),
      );
    }
    
    Map newItem = poiTitleList[index];
    
    print('build process');
    return ListTile(
      leading: Icon(Icons.restaurant_menu),
      title:Text(newItem['title']),
      subtitle: Text(newItem['address']),
      onTap: (){
        AmapService.navigateDrive(newItem['lat']);
      },
    );
  }
//  _launchURL(String keyword1) async {
//    final url = 'androidamap://keywordNavi?sourceApplication=softname&keyword='+keyword1+'&style=2';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }
  
  
}

 





  Future<bool> requestPermission() async {
    final permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
  
    if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
      return true;
    } else {
      toast('需要定位权限!');
      return false;
    }
  }