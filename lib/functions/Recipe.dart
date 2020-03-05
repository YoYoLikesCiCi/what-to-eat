import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

final firstHtml = 'https://home.meishichina.com/search/';
final random = Random();
final ua = ['Mozilla/5.0 (Windows; U; Windows NT 5.1; it; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11','Opera/9.25 (Windows NT 5.1; U; en)','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)','Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; en) Presto/2.8.131 Version/11.11','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'];
var kv = {'user-agent':ua[random.nextInt(5)]};
final replaceImg = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583403336095&di=08428815f9447cf22a648c0064861858&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_70%2Cc_zoom%2Cw_640%2Fimages%2F20180606%2Ffe396ae5a8124116b037f9c308f83405.jpg';
searchType(String name, int page)async{
    Response response;
    Dio dio = Dio();
    String url = firstHtml+name+'/page/'+page.toString()+'/';
    print(url);
    response = await dio.get(url);
//        .whenComplete((){print(response.data);});
    
    return response.data;

}

//searchType2(String name)async{
//    var url = firstHtml+name+'/';
//    var kv = {'user-agent':ua[random.nextInt(5)]};
//    var response = await http.get(url,headers: kv);
//    print('Response status: ${response.statusCode}');
//    print(response.contentLength);
//    return response.body;
//}
// 数据的解析
html_parse(String html) {
    Document document = parse(html);
    var t = document.querySelector(".ui_list_1");
    var allList = t.querySelectorAll('li');
    print("length:"+allList.length.toString());
    List alldata =[];
    alldata.clear();
    allList.forEach((v){
        
        var divPic = v.querySelector('div>a');//包含图片链接 和详情链接
        var href = divPic.attributes['href'];
        
        var imgLoad= divPic.querySelector('img');
        var imgLink = imgLoad.attributes['data-src']; //小图链接
        print(imgLink); //小图链接
        var divDetail = v.querySelector('.detail');//包含 菜名和食材
        var food = divDetail.querySelector('h4>a');
        var foodname = food.text; //食物名称
        var raw_material = divDetail.querySelector('.subcontent').text;//原料
        print(raw_material);
        if(href.contains('recipe')==true){
            alldata.add({'img':imgLink,'name':foodname,'raw':raw_material,'href':href});
        }
        
    });
    if(alldata.length>20){
        alldata.removeAt(0);
    }
    
    print(alldata.length);
    return alldata;
//    var divPic = allList[1].querySelector('div>a');//包含图片链接 和详情链接
//    print("详情连接"+divPic.attributes['href']);
//    var imgLoad= divPic.querySelector('img');
//    var imgLink = imgLoad.attributes['data-src'];
//    print(imgLink); //小图链接
//    var divDetail = allList[1].querySelector('.detail');//包含 菜名和食材
//    var food = divDetail.querySelector('h4>a');
//    var foodname = food.text;
//    var raw_material = divDetail.querySelector('.subcontent').text;
//    print(raw_material);
    
//    print(foodname.text);
    
//    return data;
}

detail_html_get(String url)async{
    print(url);
    int count = 0;
    Response response;
    Dio dio = Dio();
    response = await dio.get(url);
    if (response.statusCode != 200){
        return 'false';
    }else {
        print(url);
        return response.data;
    }
}
detail_parse(String html){
    Map data = new Map();
    Map temp_map1 = new Map();
    Document document = parse(html);
    
    
    
    var t = document.querySelector(".space_left");
    
    var temp =  t.querySelector('.userTop.clear');
    
    //获取标题
    var titleLink =temp.querySelector('h1>a');
    String title = titleLink.attributes['title'];
    temp_map1['title']=title;
    
    //获取图片链接
    var mainImgLink = t.querySelector('.recipe_De_imgBox');
    var mainImg = mainImgLink.querySelector('img').attributes['src'];
    temp_map1['main_img']=mainImg;
    

    var tt = t.querySelector('.space_box_home'); //details 总览
    
    //获取描述
    var description = getDescription(tt)!=null? getDescription(tt) : '暂无描述';
    temp_map1['description']=description;
   
    data['ready'] = temp_map1; //ready 里的内容获取完毕
    print(data);
    
    //开始获取 food material 里的内容
    List temp_list = [];
    var food_material_link = tt.querySelectorAll('.particulars');
    print('start food material');
    print(food_material_link.length);
    
    if(food_material_link.length != 0){
        //添加主料信息
        var main_raw_link = food_material_link[0].querySelectorAll('div>ul>li');
        main_raw_link.forEach((v){
            title = v.querySelector('.category_s1').querySelector('b').text;
            String count = v.querySelector('.category_s2').text;
            temp_list.add({'title':title,'count':count});
        });
        Map temp_map2 = new Map();
        temp_map2['main_raw'] = temp_list;
    
    
        if(food_material_link.length>1){
            //添加辅料信息
            List temp_list2 = [];
            var ingredient = food_material_link[1].querySelectorAll('div>ul>li');
            ingredient.forEach((v){
                title = v.querySelector('.category_s1').querySelector('b').text;
                String count = v.querySelector('.category_s2').text;
                temp_list2.add({'title':title,'count':count});
            });
            temp_map2['ingredient'] = temp_list2;
        }

        data['food_material'] = temp_map2; //材料信息获取完毕
        print(data);
    }

    
    
    
    print('start step');
    //开始获取步骤信息
    List temp_list3 = [];
    var step = tt.querySelector('.recipeStep').querySelectorAll('ul>li');
    step.forEach((v){
        
        String img = getImage(v)!=null ? getImage(v): replaceImg;
        print(img);
        String word = v.querySelector('.recipeStep_word').text;
        print(word);
        temp_list3.add({'img':img,'word':word});
    });
    data['step'] = temp_list3; //步骤信息获取完毕
    print(data);
    print('start tip');
    //开始获取tip信息
    var tips = getTips(tt)!=null? getTips(tt):'暂无tips';
    data['tips'] = tips;
    print(tips);
    
    return data;
}
String getImage(v){
    try{
        var t= v.querySelector('img').attributes['src'];
        return t;
    }catch(e){
        print(e);
    }
}

String getDescription(tt){
    try{
        var t = tt.querySelector('div>blockquote>div').text;
        return t;
    }catch(e){
        print(e);
    }
}

String getTips(tt){
    try{
        var t = tt.querySelector('.recipeTip').text;
        return t;
    }catch(e){
        print(e);
    }
}