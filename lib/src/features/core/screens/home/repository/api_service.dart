import 'package:get/get.dart';
import 'package:merchant/src/constants/constant.dart';

class ApiService extends GetConnect implements GetxService{
  
  late String? token;
  final String appBaseUrl;
  Map<String, String>? _mainHeaders;
  ApiService({required this.appBaseUrl}){
    baseUrl= appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstant.TOKEN;
    //authentication
    _mainHeaders={
      'conten-type' : 'application/json; charset=UTF-8',
      'Authorization' :  'Bearer $token',
    };
    
  }

  void updateHeader(String token){
    _mainHeaders={
      'connection':'keep-alive',
      "Keep-Alive": "timeout=5, max=1000",
      'conten-type' : 'application/json; charset=UTF-8',
      'Authorization' :  'Bearer $token',
    };
  }
  
  Future<Response> postData(String uri,dynamic body) async{
      try{
       Response response = await post(uri,body,headers: _mainHeaders);
       return response;
      }catch(e){
        return Response(statusCode: 1,statusText: e.toString());
      }
  }
  
  Future<Response> checkToken(String uri,dynamic header) async{
      try{
       Response response = await get(uri,headers: header);
       return response;
      }catch(e){
        return Response(statusCode: 1,statusText: e.toString());
      }
  }

  

  Future<Response> signUp(String uri,dynamic body,header) async{

      try{
       Response response = await post(uri,body,headers: header);
       return response;
      }catch(e){
        return Response(statusCode: 1,statusText: e.toString());
      }
  }

  Future<Response> submitOrderDetail(String uri,List<Map<String,String>>body) async{
    // Map<String,String> body={
    //   "order_id": "84",
    //   "product_id": "50",
    //   "qty": "5",
    //   "discount": "10"
    // };
      try{
       Response response = await post(uri,body,headers: _mainHeaders);
       return response;
      }catch(e){
        return Response(statusCode: 1,statusText: e.toString());
      }
  }

  Future<Response> getData(String uri,dynamic body) async{
    
      try{
       Response response = await get(uri,headers: _mainHeaders,query: body);
       return response;
      }catch(e){
        return Response(statusCode: 1,statusText: e.toString());
      }
  }

  Future<Response> deleteData(String uri,Map<String,String> body) async{
    
      try{
       Response response = await delete(uri,headers: _mainHeaders,query: body);
       return response;
      }catch(e){
        return Response(statusCode: 1,statusText: e.toString());
      }
  }
}