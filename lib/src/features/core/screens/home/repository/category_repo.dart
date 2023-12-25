import 'package:get/get.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryRepo extends GetxService{
  final ApiService apiService;
  CategoryRepo({required this.apiService});

  @override
  void onInit() {
    // TODO: implement onInit
    getUserID();
    super.onInit();
  }

  Future getUserID() async{
    var pref = await SharedPreferences.getInstance();
    AppConstant.USER_ID = pref.getString("user_id")??"";
  }
  Map<String, String> body={
    "user_id":AppConstant.USER_ID
  };
  
  Future<Response> getCategoryList() async{
    
    return await apiService.getData(AppConstant.LIST_CATEGORY,body);
    
  }
  
  Future<Response> getCategoryItems(int categoryId) async{
    Map<String, String> body={
      "user_id":AppConstant.USER_ID,
      "category_id":categoryId.toString(),
    };
    
    return await apiService.getData(AppConstant.CATEGORY_ITEMS,body);
    
  }
}