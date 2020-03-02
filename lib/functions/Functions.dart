import 'package:dio/dio.dart';

Future<int> UserDataPost(String route,Map data ) async {
    Response responsE;
    Dio dio = Dio();
    print(data);
    responsE = await dio.post('http://47.93.25.50/register',data:data);
    print(responsE.statusCode);
    print(responsE.data.toString());
    if(responsE.statusCode == 200){
        if(responsE.data.toString() == 'success'){
            print("response:"+responsE.data.toString());
            return 1;
        }
        else if(responsE.data.toString() == 'existuser'){
            print('user error');
            return 2;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
    
    
}

Future<int> Login(Map data)async{
    Response responsE;
    Dio dio = Dio();
    print(data);
    //0都为网络错误
    //1都为成功
    responsE = await dio.post('http://47.93.25.50/login',data:data);
    print(responsE.statusCode);
    if(responsE.statusCode == 200){
        print(responsE.data.toString());
        if(responsE.data.toString() == 'success'){
            return 1;
        }
        else if(responsE.data.toString() == 'errorpasswd'){
            return 2;
        }else if (responsE.data.toString() == 'unknownuser'){
            return 3;
        }
    }else{
        return 0;
    }
}



