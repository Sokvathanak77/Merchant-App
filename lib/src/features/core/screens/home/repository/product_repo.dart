import 'package:get/get.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepo extends GetxService {
  final ApiService apiService;
  ProductRepo({required this.apiService});

  @override
  void onInit() {
    // TODO: implement onInit
    getUserID();
    super.onInit();
  }

  Future getUserID() async {
    var pref = await SharedPreferences.getInstance();
    AppConstant.USER_ID = pref.getString("user_id") ?? "";
  }

  Map<String, String> body = {"user_id": AppConstant.USER_ID};

  Future<Response> getPopularProductList() async {
    return await apiService.getData(AppConstant.PRODUCT_LIST_API, body);
  }

  Future<Response> getSlideShow() async {
    return await apiService.getData(AppConstant.LIST_SLIDE, body);
  }

  Future<Response> getUserProfile() async {
    var pref = await SharedPreferences.getInstance();
    String token = await pref.getString("user_token") ?? "";
    Map<String, String> header = {"Authorization": "Bearer $token"};
    return await apiService.checkToken(AppConstant.CHECK_TOKEN, header);
  }
}
